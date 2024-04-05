--------------------------------------------------------
--  DDL for Trigger XNP_NRE_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XNP_NRE_BRI" 
BEFORE INSERT ON "XNP"."XNP_NUMBER_RANGES"
FOR EACH ROW

BEGIN
   IF :NEW.POOLED_FLAG = 'Y' THEN
      IF :NEW.ASSIGNED_SP_ID IS NOT NULL THEN
         :NEW.ASSIGNED_SP_ID := '';
      END IF;
   ELSE
      IF :NEW.ASSIGNED_SP_ID <> :NEW.OWNING_SP_ID THEN
         :NEW.ASSIGNED_SP_ID := :NEW.OWNING_SP_ID;
      END IF;
   END IF;
END;



/
ALTER TRIGGER "APPS"."XNP_NRE_BRI" ENABLE;
