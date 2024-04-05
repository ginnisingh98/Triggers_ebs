--------------------------------------------------------
--  DDL for Trigger ITG_IP_REQUISITION_LINES_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_REQUISITION_LINES_ARU" 
  AFTER UPDATE OF cancel_flag
  ON "PO"."PO_REQUISITION_LINES_ALL"
  FOR EACH ROW
DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */

  CURSOR checkHeader is
    SELECT segment1
    FROM   po_requisition_headers_all
    WHERE  UPPER(type_lookup_code)      = 'PURCHASE'
    AND    UPPER(authorization_status)  = 'APPROVED'
    AND    UPPER(NVL(cancel_flag, 'N')) = 'N'
    AND    requisition_header_id        = :new.requisition_header_id;
  l_docno  po_requisition_headers_all.segment1%TYPE;
  l_found  BOOLEAN;
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_requisition_lines_ARU');
  ITG_Debug.msg('RL', 'new.cancel_flag', :new.cancel_flag);

  IF UPPER(NVL(:new.cancel_flag, 'N')) = 'Y' THEN
    OPEN  checkHeader;
    FETCH checkHeader INTO l_docno;
    l_found := checkHeader%FOUND;
    CLOSE checkHeader;
    IF l_found THEN
      itg_outbound_utils.raise_wf_event(
        p_bsr    => 'CANCEL_REQUISITN',
        p_id     => :new.requisition_header_id,
        p_org    => :new.org_id,
	p_doctyp => 'ITG_CANCEL_REQUISITN',
	p_clntyp => 'ITG_CANCEL_REQUISITN',
	p_doc    => l_docno,
        p_param1 => '1',
        p_param2 => :new.requisition_line_id);
    END IF;
  END IF;
  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_REQUISITION_LINES_ARU" DISABLE;
