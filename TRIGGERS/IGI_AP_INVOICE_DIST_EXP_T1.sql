--------------------------------------------------------
--  DDL for Trigger IGI_AP_INVOICE_DIST_EXP_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_AP_INVOICE_DIST_EXP_T1" 
AFTER INSERT OR UPDATE OF MATCH_STATUS_FLAG ON "AP"."AP_INVOICE_DISTRIBUTIONS_ALL"
FOR EACH ROW
--
--
BEGIN
--
--
-- Bug 2438858 Start(1)
--
   IF igi_gen.is_req_installed('EXP') THEN
      igi_exp_holds.l_DistTableRow := 0;
      igi_exp_holds.l_DistTableRow := igi_exp_holds.l_DistTableRow + 1;
      igi_exp_holds.l_InvoiceIdDistTable(igi_exp_holds.l_DistTableRow) :=
                                           :NEW.invoice_id;
      igi_exp_holds.l_UpdatedByDistTable(igi_exp_holds.l_DistTableRow) :=
                                           :NEW.last_updated_by ;
   END IF;
--
-- Bug 2438858 End(1)
--

END;

/
ALTER TRIGGER "APPS"."IGI_AP_INVOICE_DIST_EXP_T1" ENABLE;
