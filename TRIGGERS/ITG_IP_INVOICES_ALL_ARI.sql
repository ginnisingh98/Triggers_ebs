--------------------------------------------------------
--  DDL for Trigger ITG_IP_INVOICES_ALL_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ITG_IP_INVOICES_ALL_ARI" 
  AFTER INSERT
  ON "AP"."AP_INVOICES_ALL"
  FOR EACH ROW
     WHEN (upper(new.source) = 'ERS') DECLARE
/* ARCS: $Header: itgoutev.sql 120.0 2005/05/26 14:13:18 appldev noship $
 * CVS:  itgoutev.sql,v 1.36 2003/09/04 18:54:53 ecoe Exp
 */
BEGIN
  ITG_Debug.setup(
    p_reset     => TRUE,
    p_pkg_name  => 'TRIGGER',
    p_proc_name => 'itg_ip_invoices_all_ARI');

  itg_outbound_utils.raise_wf_event(
    p_bsr    => 'LOAD_PLINVOICE',
    p_id     => :new.invoice_id,
    p_org    => :new.org_id,
    p_doctyp => 'ITG_LOAD_PLINVOICE',
    p_clntyp => 'ITG_LOAD_PLINVOICE',
    p_doc    => :new.invoice_num);
  ITG_Debug.flush_to_logfile;
END;


/
ALTER TRIGGER "APPS"."ITG_IP_INVOICES_ALL_ARI" DISABLE;
