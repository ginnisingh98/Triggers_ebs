--------------------------------------------------------
--  DDL for Trigger IGI_SIA_AP_HOLDS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_SIA_AP_HOLDS_T1" 
 	 AFTER UPDATE OF RELEASE_LOOKUP_CODE
 	 ON "AP"."AP_HOLDS_ALL"
 	 FOR EACH ROW
 	 DECLARE
 	 l_SapStatusFlag VARCHAR2(1);
 	 l_SapErrorNum   NUMBER;
 	 BEGIN
 	     l_SapStatusFlag := 'N';
 	     IGI_GEN.get_option_status('SIA'
 	                            ,l_SapStatusFlag
 	                            ,l_SapErrorNum);
 	     IF l_SapStatusFlag='Y' THEN
 	         IF :NEW.RELEASE_LOOKUP_CODE IS NOT NULL AND :NEW.HOLD_LOOKUP_CODE = 'QTY REC' THEN
 	             IGI_SIA.SET_INVOICE_ID  (:NEW.INVOICE_ID,
 	                                      :NEW.LAST_UPDATED_BY,
 	                                      0
 	                                     );
 	             IGI_SIA.G_QTY_REC_HOLD_RELEASED := 'Y';

 	           ELSE

 	            IF (:NEW.RELEASE_LOOKUP_CODE IS NOT NULL AND
 	                :NEW.RELEASE_LOOKUP_CODE = 'MATCHED') THEN
 	                  IGI_SIA.SET_INVOICE_ID  (:NEW.INVOICE_ID,
 	                                           :NEW.LAST_UPDATED_BY,
 	                                           0
 	                                          );
 	                  IGI_SIA.G_MATCH_PO_HOLD_RELEASED := 'Y';
 	            END IF;
 	         END IF;
 	     END IF;
 	 END;

/
ALTER TRIGGER "APPS"."IGI_SIA_AP_HOLDS_T1" ENABLE;
