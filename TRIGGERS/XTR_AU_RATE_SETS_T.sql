--------------------------------------------------------
--  DDL for Trigger XTR_AU_RATE_SETS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_RATE_SETS_T" 
 AFTER UPDATE on "XTR"."XTR_RATE_SETS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'RATE SETS';
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
   INSERT INTO XTR_A_RATE_SETS(
      DEAL_TYPE, DEAL_SUBTYPE, PRODUCT_TYPE,
      EFFECTIVE_FROM, CURRENCY, LOW_RANGE, HIGH_RANGE,
      RATE, MARGIN, INTEREST_PERIOD, FIXED_FLOATING,
      CLIENT_GROUPING, UPDATED_ON, UPDATED_BY,
      UNIQUE_REF_NUM, AUDIT_INDICATOR, TERM,
      UPDATE_EXISTING_DEALS, PI_CONSTANT, POSTED,
      RATE_EFFECTIVE_CREATED, RESET_BASIS, AUDIT_DATE_STORED,
      CREATED_ON, CREATED_BY
      ) VALUES (
      :old.DEAL_TYPE, :old.DEAL_SUBTYPE, :old.PRODUCT_TYPE,
      :old.EFFECTIVE_FROM, :old.CURRENCY, :old.LOW_RANGE, :old.HIGH_RANGE,
      :old.RATE, :old.MARGIN, :old.INTEREST_PERIOD, :old.FIXED_FLOATING,
      :old.CLIENT_GROUPING, sysdate, :old.UPDATED_BY,
      :old.UNIQUE_REF_NUM, :old.AUDIT_INDICATOR, :old.TERM,
      :old.UPDATE_EXISTING_DEALS, :old.PI_CONSTANT, :old.POSTED,
      :old.RATE_EFFECTIVE_CREATED,
      :old.RESET_BASIS,sysdate, :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_RATE_SETS_T" ENABLE;
