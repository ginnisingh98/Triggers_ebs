--------------------------------------------------------
--  DDL for Trigger ITG_IP_LINES_ALL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_LINES_ALL_ARU" 
  AFTER UPDATE OF cancel_flag
  ON "PO"."PO_LINES_ALL"
  FOR EACH ROW
DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */

  CURSOR checkHeader IS
    SELECT segment1
    FROM  po_headers_all
    WHERE UPPER(type_lookup_code) IN ('STANDARD', 'PLANNED')
    AND   UPPER(authorization_status)  = 'APPROVED'
    AND   UPPER(NVL(cancel_flag, 'N')) = 'N'
    AND   po_header_id                 = :new.po_header_id;

  l_ponumber VARCHAR2(100);
  l_doc_num  VARCHAR2(100);
  l_found    BOOLEAN;
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_lines_all_ARU');
  ITG_Debug.msg('LA', 'new.cancel_flag',  :new.cancel_flag);
  ITG_Debug.msg('LA', 'new.po_header_id', :new.po_header_id);

  /*  Modified all CANCEL PO wf event parms:
        p_id will always be po_header_id
        p_param1 will now be po_release_id or NULL
        p_param2 will now be po_line_id
        p_param3 will now be po_line_location_id or NULL
      also added '_RELEASE' to the p_bsr for RELEASE cases
   */
  /* IF this POLINE's cancel_flag is set... */
  IF UPPER(NVL(:new.cancel_flag, 'N')) = 'Y' THEN
    OPEN  checkHeader;
    FETCH checkHeader INTO l_ponumber;
    l_found := checkHeader%FOUND;
    CLOSE checkHeader;
    IF l_found THEN
      l_doc_num := l_ponumber||':'||to_char(:new.line_num);
      itg_outbound_utils.raise_wf_event(
	p_bsr    => 'CANCEL_PO',
	p_id     => :new.po_header_id,
	p_org    => :new.org_id,
	p_doctyp => 'ITG_CANCEL_PO',
        p_clntyp => 'ITG_CANCEL_PO',
	p_doc    => l_doc_num,
	p_param2 => :new.po_line_id);
    END IF;
  END IF;
  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_LINES_ALL_ARU" DISABLE;
