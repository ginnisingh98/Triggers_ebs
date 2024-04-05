--------------------------------------------------------
--  DDL for Trigger IGI_AP_INVOICE_DIST_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IGI_AP_INVOICE_DIST_T1" 
AFTER INSERT OR UPDATE OF MATCH_STATUS_FLAG ON "AP"."AP_INVOICE_DISTRIBUTIONS_ALL"
FOR EACH ROW
--
DECLARE
l_SapStatusFlag VARCHAR2(1);
l_SapErrorNum   NUMBER;
--
BEGIN
--
IGI_GEN.get_option_status('SIA'
                           ,l_SapStatusFlag
                           ,l_SapErrorNum);
--
IF l_SapStatusFlag='Y' THEN
        IGI_SIA.SET_INVOICE_ID  (:NEW.INVOICE_ID,
                                 :NEW.LAST_UPDATED_BY,
				0
				);
        -- Bug 3427479 hkaniven start --
        IF UPDATING THEN
           UPDATE IGI_INVOICE_DISTRIBUTIONS_ALL
           SET IGI_SAP_FLAG = 'N'
           WHERE INVOICE_ID = :NEW.INVOICE_ID
           AND INVOICE_LINE_NUMBER = :NEW.INVOICE_LINE_NUMBER  -- Bug # 5905278 pashivara
           AND DISTRIBUTION_LINE_NUMBER = :NEW.DISTRIBUTION_LINE_NUMBER;

           -- Bug # 5905278 pshivara start --
           UPDATE IGI_INVOICE_LINES_ALL
           SET IGI_SAP_FLAG = 'N'
           WHERE INVOICE_ID = :New.INVOICE_ID
           AND LINE_NUMBER = :NEW.DISTRIBUTION_LINE_NUMBER;
           -- Bug # 5905278 pshivara end --

        END IF;
        -- Bug 3427479 hkaniven end --





   -- Bug 3671954 Start
   -- if inserting distribution lines then release any existing SIA hold i.e.
   -- if modifying an approved invoice, release existing holds and re-approve.
   --
   IF INSERTING AND :NEW.line_type_lookup_code <> 'PREPAY'
   THEN
      IGI_SIA.RELEASE_HOLDS;
   END IF;
   --
   -- Bug 3671954 End

END IF;



END;

/
ALTER TRIGGER "APPS"."IGI_AP_INVOICE_DIST_T1" ENABLE;
