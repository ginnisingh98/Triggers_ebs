--------------------------------------------------------
--  DDL for Trigger XTR_AU_DEALER_LIMITS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_DEALER_LIMITS_T" 
 AFTER UPDATE on "XTR"."XTR_DEALER_LIMITS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'DEALER LIMITS';
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
   INSERT INTO XTR_A_DEALER_LIMITS(
      DEALER_CODE, LIMIT_AMOUNT, DEAL_TYPE,  PRODUCT_TYPE,
      SINGLE_DEAL_LIMIT_AMOUNT ,
      UPDATED_BY, UPDATED_ON, AUDIT_INDICATOR, AUDIT_DATE_STORED,
      CREATED_ON, CREATED_BY
      ) VALUES (:old.DEALER_CODE, :old.LIMIT_AMOUNT,
      :old.DEAL_TYPE, :old.PRODUCT_TYPE, :old.SINGLE_DEAL_LIMIT_AMOUNT,
      :old.UPDATED_BY, sysdate,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'),:old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_DEALER_LIMITS_T" ENABLE;
