--------------------------------------------------------
--  DDL for Trigger XTR_BI_DEAL_DATE_AMOUNTS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_BI_DEAL_DATE_AMOUNTS_T" 
 BEFORE INSERT on "XTR"."XTR_DEAL_DATE_AMOUNTS"
 FOR EACH ROW
begin
 select XTR_DEAL_DATE_AMOUNTS_S.nextval
 into :new.DEAL_DATE_AMOUNT_ID
 from dual;
end;
/
ALTER TRIGGER "APPS"."XTR_BI_DEAL_DATE_AMOUNTS_T" ENABLE;
