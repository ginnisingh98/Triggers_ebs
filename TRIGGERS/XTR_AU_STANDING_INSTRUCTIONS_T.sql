--------------------------------------------------------
--  DDL for Trigger XTR_AU_STANDING_INSTRUCTIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_STANDING_INSTRUCTIONS_T" 
 AFTER UPDATE on "XTR"."XTR_STANDING_INSTRUCTIONS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'STANDING INSTRUCTIONS';
 --
 l_val VARCHAR2(1);
 --
begin
 -- Check that Audit on this table has been specified
 open CHK_AUDIT;
  fetch CHK_AUDIT INTO l_val;
 if CHK_AUDIT%NOTFOUND then
  l_val := 'N';
 end if;
 close CHK_AUDIT;
 -- Copy to Audit Table the Pre-Updated row
 if nvl(upper(l_val),'N') = 'Y' then
   INSERT INTO XTR_A_STANDING_INSTRUCTIONS(
      UNIQUE_REF_NUM, PARTY_CODE, CURRENCY, BANK_CODE,
      ACCOUNT_NO, CPARTY_REF, DEAL_TYPE, DEAL_SUBTYPE,
      PRODUCT_TYPE, AMOUNT_TYPE, UPDATED_BY,
      UPDATED_ON, AUDIT_INDICATOR , AUDIT_DATE_STORED ,
      CREATED_ON, CREATED_BY
      ) VALUES (
      :old.UNIQUE_REF_NUM, :old.PARTY_CODE, :old.CURRENCY, :old.BANK_CODE,
      :old.ACCOUNT_NO, :old.CPARTY_REF, :old.DEAL_TYPE, :old.DEAL_SUBTYPE,
      :old.PRODUCT_TYPE, :old.AMOUNT_TYPE, :old.UPDATED_BY,
      sysdate, :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'), :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_STANDING_INSTRUCTIONS_T" ENABLE;
