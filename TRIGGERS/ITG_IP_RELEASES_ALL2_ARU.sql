--------------------------------------------------------
--  DDL for Trigger ITG_IP_RELEASES_ALL2_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_RELEASES_ALL2_ARU" 
  AFTER INSERT
  ON "PO"."PO_RELEASES_ALL"
  FOR EACH ROW
     WHEN (UPPER(new.authorization_status) = 'APPROVED') DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */
  CURSOR get_doc(p_po_header_id NUMBER) IS
    SELECT segment1
    FROM   po_headers_all
    WHERE  po_header_id = p_po_header_id;

  l_doc_num    VARCHAR2(100);
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_releases_all2_ARU');

  /*  Modified all SYNC PO wf event parms:
        p_id will always be po_header_id
        p_param1 will now be po_release_id (formerly, the case code of 1-2)
        p_param2 remains the synchind.

      Added '_RELEASE' to the p_bsr for RELEASE case
  */
  OPEN  get_doc(:new.po_header_id);
  FETCH get_doc INTO l_doc_num;
  CLOSE get_doc;

  itg_outbound_utils.raise_wf_event(
    p_bsr    => 'SYNC_PO_RELEASE',
    p_id     => :new.po_header_id,
    p_org    => :new.org_id,
    p_doctyp => 'ITG_SYNC_PO',
    p_clntyp => 'ITG_SYNC_PO_CREATE',
    p_doc    => l_doc_num,
    p_rel    => to_char(:new.release_num),
    p_param1 => :new.po_release_id,
    p_param2 => 'A');

  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_RELEASES_ALL2_ARU" DISABLE;
