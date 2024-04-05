--------------------------------------------------------
--  DDL for Trigger IGI_EXP_AP_HOLDS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_EXP_AP_HOLDS_T1" 
AFTER UPDATE
ON "AP"."AP_HOLDS_ALL"
FOR EACH ROW
BEGIN

   IF igi_gen.is_req_installed('EXP') THEN
      igi_exp_holds.l_TableRow := 0;
      igi_exp_holds.l_TableRow := igi_exp_holds.l_TableRow + 1;
      igi_exp_holds.l_InvoiceIdTable(igi_exp_holds.l_TableRow) :=
                                           :NEW.invoice_id;
      igi_exp_holds.l_UpdatedByTable(igi_exp_holds.l_TableRow) :=
                                           :NEW.last_updated_by ;
   END IF;
END;

/
ALTER TRIGGER "APPS"."IGI_EXP_AP_HOLDS_T1" ENABLE;
