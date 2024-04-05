--------------------------------------------------------
--  DDL for Trigger IGI_AP_INVOICE_LINES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_AP_INVOICE_LINES_T2" 
AFTER INSERT OR UPDATE ON "AP"."AP_INVOICE_LINES_ALL"
DECLARE
BEGIN
--
-- Bug # 5905190 EXP R12 uptake. Place or release hold as per Invoice lines update
--
   IF igi_gen.is_req_installed('EXP') THEN
      igi_exp_holds.igi_exp_ap_inv_line_t2(p_calling_sequence =>
                                           'trigger igi_ap_invoice_line_t2');
   END IF;
--
--Bug # 5905190 end

END;

/
ALTER TRIGGER "APPS"."IGI_AP_INVOICE_LINES_T2" ENABLE;
