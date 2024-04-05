--------------------------------------------------------
--  DDL for Trigger ITG_IP_HEADERS_ALL2_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_HEADERS_ALL2_ARU" 
  AFTER INSERT
  ON "PO"."PO_HEADERS_ALL"
  FOR EACH ROW
     WHEN (UPPER(new.type_lookup_code) IN ('STANDARD', 'PLANNED') AND
        UPPER(new.authorization_status) = 'APPROVED') DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_headers_all2_ARU');

  /*  Modified all SYNC PO wf event parms:
        p_id will always be po_header_id
        p_param1 will now be po_release_id (formerly, the case code of 1-2)
        p_param2 remains the synchind.
  */
  itg_outbound_utils.raise_wf_event(
    p_bsr    => 'SYNC_PO',
    p_id     => :new.po_header_id,
    p_org    => :new.org_id,
    p_doctyp => 'ITG_SYNC_PO',
    p_clntyp => 'ITG_SYNC_PO_CREATE',
    p_doc    => :new.segment1,
    p_param2 => 'A');

  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_HEADERS_ALL2_ARU" DISABLE;
