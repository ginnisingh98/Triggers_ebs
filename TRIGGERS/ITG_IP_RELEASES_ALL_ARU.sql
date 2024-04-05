--------------------------------------------------------
--  DDL for Trigger ITG_IP_RELEASES_ALL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_RELEASES_ALL_ARU" 
  AFTER UPDATE OF authorization_status, cancel_flag
  ON "PO"."PO_RELEASES_ALL"
  FOR EACH ROW
DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */

  -- Count the # of approvals to determine the value for SYNCIND
  CURSOR cur_po_action_history_cnt(p_release_header_id NUMBER) IS
    SELECT count(*)
    FROM   po_action_history
    WHERE  object_id            = p_release_header_id
    AND    object_type_code     = 'RELEASE'
    AND    UPPER(action_code)   = 'APPROVE';

  CURSOR get_doc(p_po_header_id NUMBER) IS
    SELECT segment1
    FROM   po_headers_all
    WHERE  po_header_id = p_po_header_id;

  l_action_cnt NUMBER;
  l_syncind    VARCHAR2(10) := NULL;
  l_doc_num    VARCHAR2(100);
  l_clntyp     VARCHAR2(30);
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_releases_all_ARU');
  ITG_Debug.msg('RA', 'new.cancel_flag',          :new.cancel_flag);
  ITG_Debug.msg('RA', 'new.approved_flag',        :new.approved_flag);
  ITG_Debug.msg('RA', 'new.po_header_id',         :new.po_header_id);
  ITG_Debug.msg('RA', 'new.po_release_id',        :new.po_release_id);
  ITG_Debug.msg('RA', 'old.authorization_status', :old.authorization_status);
  ITG_Debug.msg('RA', 'new.authorization_status', :new.authorization_status);

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
/* Refer to Bug no: 3896983 Cancel_Po issue*/
/* IF this RELEASE HEADER's cancel_flag is set...  */
IF UPPER(NVL(:new.cancel_flag, 'N'))   = 'Y' THEN
    IF UPPER(NVL(:old.cancel_flag, 'N')) = 'Y' AND
	   UPPER(:old.authorization_status) <> UPPER(:new.authorization_status) AND
	   UPPER(:old.authorization_status) ='REQUIRES REAPPROVAL' THEN
	       /* Cancel an entire PO RELEASE */
		       OPEN  get_doc(:new.po_header_id);
			   FETCH get_doc INTO l_doc_num;
    		   CLOSE get_doc;

    		   itg_outbound_utils.raise_wf_event(
      		   p_bsr    => 'CANCEL_PO_RELEASE',
      		   p_id     => :new.po_header_id,
      		   p_org    => :new.org_id,
      		   p_doctyp => 'ITG_CANCEL_PO',
      		   p_clntyp => 'ITG_CANCEL_PO',
      		   p_doc    => l_doc_num,
      		   p_rel    => to_char(:new.release_num),
      		   p_param1 => :new.po_release_id);
    END IF;

ELSIF UPPER(NVL(:old.authorization_status, 'a')) <>
      UPPER(NVL(:new.authorization_status, 'z')) THEN

    OPEN  cur_po_action_history_cnt(:new.po_release_id);
    FETCH cur_po_action_history_cnt INTO l_action_cnt;
    CLOSE cur_po_action_history_cnt;

    ITG_Debug.msg('RA', 'l_action_cnt', l_action_cnt);

    IF ((l_action_cnt > 1 AND
         UPPER(:new.authorization_status) = 'APPROVED') OR
         UPPER(:new.authorization_status) = 'REQUIRES REAPPROVAL') THEN
          l_syncind := 'C';
      	  l_clntyp  := 'ITG_SYNC_PO_CHANGE';
    ELSIF UPPER(:new.authorization_status) = 'APPROVED' THEN
      	  l_syncind := 'A';
      	  l_clntyp  := 'ITG_SYNC_PO_CREATE';
    END IF;

    IF l_syncind IS NOT NULL THEN
      OPEN  get_doc(:new.po_header_id);
      FETCH get_doc INTO l_doc_num;
      CLOSE get_doc;

      itg_outbound_utils.raise_wf_event(
        p_bsr    => 'SYNC_PO_RELEASE',
        p_id     => :new.po_header_id,
        p_org    => :new.org_id,
        p_doctyp => 'ITG_SYNC_PO',
        p_clntyp => l_clntyp,
        p_doc    => l_doc_num,
        p_rel    => to_char(:new.release_num),
        p_param1 => :new.po_release_id,
        p_param2 => l_syncind,
        p_param4 => :new.authorization_status);
    END IF;

END IF;
  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_RELEASES_ALL_ARU" DISABLE;
