--------------------------------------------------------
--  DDL for Trigger ITG_IP_HEADERS_ALL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_HEADERS_ALL_ARU" 
  AFTER UPDATE OF authorization_status, cancel_flag, closed_code
  ON "PO"."PO_HEADERS_ALL"
  FOR EACH ROW
     WHEN (upper(new.type_lookup_code) in ('STANDARD', 'PLANNED')) DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */

  CURSOR cur_po_action_history(p_po_header_id NUMBER)  IS
    SELECT action_code
    FROM   po_action_history
    WHERE  object_id        = p_po_header_id
    AND    object_type_code = 'PO'
    AND    sequence_num     = (SELECT MAX(sequence_num)
	                       FROM   po_action_history
                               WHERE  object_id = p_po_header_id);

  CURSOR cur_po_action_history_cnt(p_po_header_id NUMBER) IS
    SELECT count(*)
    FROM   po_action_history
    WHERE  object_id          = p_po_header_id
    AND    object_type_code   = 'PO'
    AND    UPPER(action_code) = 'APPROVE';

  l_action_code po_action_history.action_code%TYPE;
  l_action_cnt  NUMBER;
  l_syncind     VARCHAR2(10);
  l_clntyp      VARCHAR2(30);

BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_headers_all_ARU');
  ITG_Debug.msg('HA', 'new.type_lookup_code',     :new.type_lookup_code);
  ITG_Debug.msg('HA', 'old.cancel_flag',          :old.cancel_flag);
  ITG_Debug.msg('HA', 'new.cancel_flag',          :new.cancel_flag);
  ITG_Debug.msg('HA', 'old.authorization_status', :old.authorization_status);
  ITG_Debug.msg('HA', 'new.authorization_status', :new.authorization_status);
  ITG_Debug.msg('HA', 'new.revision_num',         :new.revision_num);
  ITG_Debug.msg('HA', 'new.po_header_id',         :new.po_header_id);
  ITG_Debug.msg('HA', 'old.closed_code',          :old.closed_code);
  ITG_Debug.msg('HA', 'new.closed_code',          :new.closed_code);

  /*  Modified all CANCEL PO wf event parms:
        p_id will always be po_header_id
        p_param1 will now be po_release_id (formerly, the case code of 1-6)
        p_param2 will now be po_line_id
        p_param3 will now be po_line_location_id.

      Modified all SYNC PO wf event parms:
        p_id will always be po_header_id
        p_param1 will now be po_release_id (formerly, the case code of 1-2)
        p_param2 remains the synchind.

      Added '_RELEASE' to the p_bsr for RELEASE cases
   */

/* IF this PO HEADER's cancel_flag has been changed... */
/* Refer to Bug no: 3896983 For Cancel_Po issue*/
IF UPPER(NVL(:new.cancel_flag, 'N')) = 'Y' THEN
    /* ...and it's now Y for canceled */
	    IF UPPER(NVL(:old.cancel_flag, 'N')) = 'Y' AND
		   UPPER(:old.authorization_status) <> UPPER(:new.authorization_status) AND
		   UPPER(:old.authorization_status) ='REQUIRES REAPPROVAL' THEN
	      /* Cancel the entire PO */
	      itg_outbound_utils.raise_wf_event(
	        p_bsr    => 'CANCEL_PO',
	        p_id     => :new.po_header_id,
	        p_org    => :new.org_id,
			p_doctyp => 'ITG_CANCEL_PO',
			p_clntyp => 'ITG_CANCEL_PO',
			p_doc    => :new.segment1);
        END IF;

ELSIF UPPER(NVL(:old.authorization_status, 'a')) <>
      UPPER(NVL(:new.authorization_status, 'z')) THEN
	    IF :new.revision_num > 0 AND
       	   UPPER(:new.authorization_status) = 'APPROVED' THEN
		         /* PO REAPPROVED */
		      itg_outbound_utils.raise_wf_event(
        	  p_bsr    => 'SYNC_PO',
			  p_id     => :new.po_header_id,
			  p_org    => :new.org_id,
			  p_doctyp => 'ITG_SYNC_PO',
			  p_clntyp => 'ITG_SYNC_PO_CHANGE',
			  p_doc    => :new.segment1,
			  p_param2 => 'C');

	    ELSIF UPPER(:new.authorization_status) = 'APPROVED' THEN
    	  /* PO CREATE  and Release HOLD PO */

 		  /* check to see the history, 2 ways */
      	  OPEN  cur_po_action_history(:new.po_header_id);
      	  FETCH cur_po_action_history INTO l_action_code;
      	  CLOSE cur_po_action_history;

      	  OPEN  cur_po_action_history_cnt(:new.po_header_id);
      	  FETCH cur_po_action_history_cnt INTO l_action_cnt;
      	  CLOSE cur_po_action_history_cnt;

      	  ITG_Debug.msg('HA-1', 'l_action_code', l_action_code);
      	  ITG_Debug.msg('HA-1', 'l_action_cnt',  l_action_cnt);

      	  IF l_action_code = 'RELEASE HOLD' OR l_action_cnt > 1 THEN
          	 l_syncind := 'C';
			 l_clntyp  := 'ITG_SYNC_PO_CHANGE';
      	  ELSE
          	 l_syncind := 'A';
			 l_clntyp  := 'ITG_SYNC_PO_CREATE';
          END IF;

		  itg_outbound_utils.raise_wf_event(
          p_bsr    => 'SYNC_PO',
		  p_id     => :new.po_header_id,
		  p_org    => :new.org_id,
		  p_doctyp => 'ITG_SYNC_PO',
		  p_clntyp => l_clntyp,
		  p_doc    => :new.segment1,
		  p_param2 => l_syncind);

	  ELSIF UPPER(:new.authorization_status) = 'REQUIRES REAPPROVAL' THEN
      		/* PO REQUIRES REAPPROVAL */

	      /* make sure the PO is not in HOLD status. */
      	  OPEN  cur_po_action_history(:new.po_header_id);
      	  FETCH cur_po_action_history INTO l_action_code;
      	  CLOSE cur_po_action_history;

      	  ITG_Debug.msg('HA-2', 'l_action_code', l_action_code);

      	  IF l_action_code <> 'HOLD' THEN
          	 itg_outbound_utils.raise_wf_event(
          	 p_bsr    => 'SYNC_PO',
	  		 p_id     => :new.po_header_id,
	  		 p_org    => :new.org_id,
	  		 p_doctyp => 'ITG_SYNC_PO',
	  		 p_clntyp => 'ITG_SYNC_PO_CHANGE',
	  		 p_doc    => :new.segment1,
	  		 p_param2 => 'C',
        	 p_param4 => 'REQUIRES REAPPROVAL');
      	  END IF;
      END IF;

/* change in closed_code */
ELSIF UPPER(NVL(:old.closed_code, 'a')) <>
	UPPER(NVL(:new.closed_code, 'z')) THEN
    IF UPPER(:new.authorization_status)  = 'APPROVED' AND
       UPPER(NVL(:new.closed_code, 'zz')) = 'FINALLY CLOSED' THEN
      /* PO FINALLY CLOSED */
      itg_outbound_utils.raise_wf_event(
        p_bsr    => 'SYNC_PO',
 		p_id     => :new.po_header_id,
		p_org    => :new.org_id,
		p_doctyp => 'ITG_SYNC_PO',
		p_clntyp => 'ITG_SYNC_PO_CHANGE',
		p_doc    => :new.segment1,
		p_param2 => 'D');

    END IF;

END IF;
  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_HEADERS_ALL_ARU" DISABLE;
