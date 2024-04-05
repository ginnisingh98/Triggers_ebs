--------------------------------------------------------
--  DDL for Trigger IGI_AP_INVOICE_DIST_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_AP_INVOICE_DIST_T2" 
AFTER INSERT OR UPDATE OF MATCH_STATUS_FLAG ON "AP"."AP_INVOICE_DISTRIBUTIONS_ALL"
--
DECLARE
l_SapStatusFlag VARCHAR2(1);
l_SapErrorNum   NUMBER;
--
BEGIN
--
-- Bug # 5905278 pshivara start --
--IGI_GEN.get_option_status('SIA'
--                           ,l_SapStatusFlag
--                           ,l_SapErrorNum);
-- Bug # 5905278 pshivara end --
--
--IF l_SapStatusFlag='Y' THEN
--
-- if updating match status flag to 'A' i.e. approving invoice.
--
   IF UPDATING THEN
      IGI_SIA.PROCESS_HOLDS;
   END IF;
--
--END IF;
--

--
-- Bug 2438858 Start(2)
--
   IF igi_gen.is_req_installed('EXP') THEN
      igi_exp_holds.igi_exp_ap_inv_dist_t2(p_calling_sequence =>
                                           'trigger igi_ap_invoice_dist_t2');
   END IF;
--
-- Bug 2438858 End(2)
--

END;

/
ALTER TRIGGER "APPS"."IGI_AP_INVOICE_DIST_T2" ENABLE;
