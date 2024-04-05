--------------------------------------------------------
--  DDL for Trigger IGI_AP_INVOICE_LINES_EXP_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_AP_INVOICE_LINES_EXP_T1" 
after insert or delete or update on "AP"."AP_INVOICE_LINES_ALL"
for each row
BEGIN
--
-- Bug 5905190 Start(1)
--
   IF igi_gen.is_req_installed('EXP') THEN
      igi_exp_holds.l_LineTableRow := 0;
      igi_exp_holds.l_LineTableRow := igi_exp_holds.l_LineTableRow + 1;
      igi_exp_holds.l_InvoiceIdLineTable(igi_exp_holds.l_LineTableRow) :=
                                           :NEW.invoice_id;
      igi_exp_holds.l_UpdatedByLineTable(igi_exp_holds.l_LineTableRow) :=
                                           :NEW.last_updated_by ;
   END IF;
--
-- Bug 5905190 End(1)

END;

/
ALTER TRIGGER "APPS"."IGI_AP_INVOICE_LINES_EXP_T1" ENABLE;
