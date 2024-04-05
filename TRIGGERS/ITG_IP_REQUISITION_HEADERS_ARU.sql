--------------------------------------------------------
--  DDL for Trigger ITG_IP_REQUISITION_HEADERS_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_REQUISITION_HEADERS_ARU" 
  AFTER UPDATE OF AUTHORIZATION_STATUS
  ON "PO"."PO_REQUISITION_HEADERS_ALL"
  FOR EACH ROW
     WHEN (upper(new.type_lookup_code) = 'PURCHASE') DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */

  CURSOR cur_req_action_history(
    p_req_header_id NUMBER
  ) is
    SELECT action_code
    FROM   po_action_history
    WHERE  object_id        = p_req_header_id
    AND    object_type_code = 'REQUISITION'
    AND    sequence_num     = (SELECT max(sequence_num) -2
			       FROM   po_action_history
			       WHERE  object_id = p_req_header_id);

  CURSOR cur_req_action_history_cnt(
    p_req_header_id NUMBER
  ) IS
    SELECT count(*)
    FROM   po_action_history
    WHERE  object_id = p_req_header_id
    AND    object_type_code   = 'REQUISITION'
    AND    UPPER(action_code) = 'APPROVE';

  v_action_code po_action_history.action_code%TYPE;
  v_action_cnt  NUMBER;
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_requisition_headers_ARU');

  ITG_Debug.msg('RH', 'old.authorization_status', :old.authorization_status);
  ITG_Debug.msg('RH', 'new.authorization_status', :new.authorization_status);
  ITG_Debug.msg('RH', 'new.requisition_header_id', :new.requisition_header_id);

  IF upper(nvl(:old.authorization_status,'a')) <>
     upper(nvl(:new.authorization_status,'z')) THEN
    IF upper(:new.authorization_status)  = 'APPROVED' THEN

      OPEN cur_req_action_history(:new.requisition_header_id);
      FETCH cur_req_action_history into v_action_code;
      CLOSE cur_req_action_history;
      OPEN cur_req_action_history_cnt(:new.requisition_header_id);
      FETCH cur_req_action_history_cnt into v_action_cnt;
      CLOSE cur_req_action_history_cnt;

      ITG_Debug.msg('RH', 'v_action_code', v_action_code);
      ITG_Debug.msg('RH', 'v_action_cnt',  v_action_cnt);

      IF v_action_code = 'WITHDRAW' AND v_action_cnt > 1 THEN
	itg_outbound_utils.raise_wf_event (
	  p_bsr => 'CHANGE_REQUISITN',
	  p_id  => :new.requisition_header_id,
	  p_org => :new.org_id,
	  p_doctyp => 'ITG_CHANGE_REQUISITN',
	  p_clntyp => 'ITG_CHANGE_REQUISITN',
	  p_doc => :new.segment1);
      ELSE
	itg_outbound_utils.raise_wf_event(
	  p_bsr    => 'ADD_REQUISITN',
	  p_id     => :new.requisition_header_id,
	  p_org    => :new.org_id,
	      p_doctyp => 'ITG_ADD_REQUISITN',
	      p_clntyp => 'ITG_ADD_REQUISITN',
	      p_doc    => :new.segment1);
      END IF;
    ELSIF upper(:new.authorization_status) = 'RETURNED' THEN
      itg_outbound_utils.raise_wf_event(
	p_bsr    => 'CANCEL_REQUISITN',
	p_id     => :new.requisition_header_id,
	p_org    => :new.org_id,
	p_doctyp => 'ITG_CANCEL_REQUISITN',
	p_clntyp => 'ITG_CANCEL_REQUISITN',
	p_doc    => :new.segment1,
	p_param1 => '1');
    END IF;
  END IF;
  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_REQUISITION_HEADERS_ARU" DISABLE;
