--------------------------------------------------------
--  DDL for Trigger XTR_BU_CONFIRMATION_DETAILS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_BU_CONFIRMATION_DETAILS_T" 
 BEFORE UPDATE on "XTR"."XTR_CONFIRMATION_DETAILS" FOR EACH ROW
--
begin
 if (nvl(:OLD.CONFIRMATION_VALIDATED_BY,'@@')
     <> nvl(:NEW.CONFIRMATION_VALIDATED_BY,'@@'))
  or (nvl(:OLD.CONFIRMATION_VALIDATED_ON,To_Date('01/01/1980','MM/DD/YYYY'))
     <> nvl(:NEW.CONFIRMATION_VALIDATED_ON,To_Date('01/01/1980','MM/DD/YYYY'))) then

  XTR_MISC_P.VALIDATE_DEALS(:NEW.DEAL_NO,
                 :NEW.TRANSACTION_NO,
                 :NEW.DEAL_TYPE,
                 :NEW.ACTION_TYPE,
                 :NEW.CONFIRMATION_VALIDATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_BU_CONFIRMATION_DETAILS_T" ENABLE;
