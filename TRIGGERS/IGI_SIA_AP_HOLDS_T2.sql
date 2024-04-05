--------------------------------------------------------
--  DDL for Trigger IGI_SIA_AP_HOLDS_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_SIA_AP_HOLDS_T2" 
 	 AFTER UPDATE
 	 ON "AP"."AP_HOLDS_ALL"
 	 DECLARE
 	 l_SapStatusFlag VARCHAR2(1);
 	 l_SapErrorNum   NUMBER;
 	 BEGIN
 	     l_SapStatusFlag := 'N';
 	     IGI_GEN.get_option_status('SIA'
 	                            ,l_SapStatusFlag
 	                            ,l_SapErrorNum);
 	     IF l_SapStatusFlag='Y' AND IGI_SIA.G_QTY_REC_HOLD_RELEASED = 'Y' THEN
 	         IGI_SIA.PROCESS_HOLDS;
 	         IGI_SIA.G_QTY_REC_HOLD_RELEASED := 'N';
 	     END IF;

 	     IF (l_SapStatusFlag='Y' AND
 	         IGI_SIA.G_MATCH_PO_HOLD_RELEASED = 'Y') THEN
 	         IGI_SIA.PROCESS_HOLDS;
 	         IGI_SIA.G_MATCH_PO_HOLD_RELEASED := 'N';
 	     END IF;
 	 END;

/
ALTER TRIGGER "APPS"."IGI_SIA_AP_HOLDS_T2" ENABLE;
