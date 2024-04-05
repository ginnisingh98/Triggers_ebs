--------------------------------------------------------
--  DDL for Trigger XTR_AU_REVALUATION_RATES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_REVALUATION_RATES_T" 
 AFTER UPDATE on "XTR"."XTR_REVALUATION_RATES"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'REVALUATION RATES';
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
   INSERT INTO XTR_A_REVALUATION_RATES(
      COMPANY_CODE, PERIOD_FROM, PERIOD_TO, REVAL_TYPE,
      REVAL_SUBTYPE, REVAL_PRODUCT_TYPE, CURRENCYA,
      REVAL_RATE, ENTERED_ON, ENTERED_BY, RATE_DATE,
      VOLATILITY_OR_RATE, DAY_MTH, CURRENCYB,
      PERIOD_REF1, PERIOD_REF2, UPDATED_ON, UPDATED_BY,
      UNIQUE_REF_NUM, AUDIT_INDICATOR, AUDIT_DATE_STORED,
      CREATED_ON, CREATED_BY,
      BATCH_ID, BID, BID_OVERWRITE, ASK, ASK_OVERWRITE, DAY_COUNT_BASIS
      ) VALUES (
      :old.COMPANY_CODE, :old.PERIOD_FROM, :old.PERIOD_TO, :old.REVAL_TYPE,
      :old.REVAL_SUBTYPE, :old.REVAL_PRODUCT_TYPE, :old.CURRENCYA,
      :old.REVAL_RATE, :old.ENTERED_ON, :old.ENTERED_BY, :old.RATE_DATE,
      :old.VOLATILITY_OR_RATE, :old.DAY_MTH, :old.CURRENCYB,
      :old.PERIOD_REF1, :old.PERIOD_REF2, sysdate, :old.UPDATED_BY,
      :old.UNIQUE_REF_NUM,
      :old.AUDIT_INDICATOR,sysdate, :old.CREATED_ON, :old.CREATED_BY,
      :old.BATCH_ID, :old.BID, :old.BID_OVERWRITE, :old.ASK, :old.ASK_OVERWRITE, :old.DAY_COUNT_BASIS
      );
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_REVALUATION_RATES_T" ENABLE;
