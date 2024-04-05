--------------------------------------------------------
--  DDL for Trigger IGI_EXP_AP_HOLDS_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_EXP_AP_HOLDS_T2" 
AFTER UPDATE
ON "AP"."AP_HOLDS_ALL"
BEGIN

   IF igi_gen.is_req_installed('EXP') THEN
      igi_exp_holds.igi_exp_ap_holds_t2(p_calling_sequence =>
                                     'trigger igi_exp_ap_holds_t2');
   END IF;
END;

/
ALTER TRIGGER "APPS"."IGI_EXP_AP_HOLDS_T2" ENABLE;
