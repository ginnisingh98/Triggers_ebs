--------------------------------------------------------
--  DDL for Trigger XTR_AU_TAX_BROKERAGE_RATES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_TAX_BROKERAGE_RATES_T" 
 AFTER UPDATE on "XTR"."XTR_TAX_BROKERAGE_RATES"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'TAX/BROKERAGE RATES';
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
   INSERT INTO XTR_A_TAX_BROKERAGE_RATES(
      REF_TYPE, RATE_GROUP, EFFECTIVE_FROM, MIN_AMT,
      MAX_AMT, INTEREST_RATE, CMF_BROKERAGE_RATE,
      FLAT_AMOUNT, UPDATED_ON, UPDATED_BY,
      AUDIT_INDICATOR, AUDIT_DATE_STORED,
      CREATED_ON, CREATED_BY
      ) VALUES (
      :old.REF_TYPE, :old.RATE_GROUP, :old.EFFECTIVE_FROM, :old.MIN_AMT,
      :old.MAX_AMT, :old.INTEREST_RATE, :old.CMF_BROKERAGE_RATE,
      :old.FLAT_AMOUNT, sysdate, :old.UPDATED_BY,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'), :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_TAX_BROKERAGE_RATES_T" ENABLE;
