--------------------------------------------------------
--  DDL for Trigger XTR_AU_PORTFOLIOS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_PORTFOLIOS_T" 
 AFTER UPDATE on "XTR"."XTR_PORTFOLIOS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'PORTFOLIOS SETUP';
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
   INSERT INTO XTR_A_PORTFOLIOS(
      COMPANY_CODE, PORTFOLIO, NAME,
      DEFAULT_PORTFOLIO, AS_PRINCIPAL, EXTERNAL_PORTFOLIO,
      EXTERNAL_PARTY, INTEREST_FREQ, BROKERAGE_FREQ,
      LAST_INTEREST_SETTLEMENT, LAST_BROKERAGE_SETTLEMENT,
      PHYSICAL_PORTFOLIO_ACCT, CMF_YN,
      EXTERNAL_DEFAULT_PORTFOLIO, UPDATED_ON, UPDATED_BY,
      AUDIT_INDICATOR, AUDIT_DATE_STORED, CREATED_ON, CREATED_BY
      ) VALUES (
      :old.COMPANY_CODE, :old.PORTFOLIO, :old.NAME,
      :old.DEFAULT_PORTFOLIO, :old.AS_PRINCIPAL, :old.EXTERNAL_PORTFOLIO,
      :old.EXTERNAL_PARTY, :old.INTEREST_FREQ, :old.BROKERAGE_FREQ,
      :old.LAST_INTEREST_SETTLEMENT, :old.LAST_BROKERAGE_SETTLEMENT,
      :old.PHYSICAL_PORTFOLIO_ACCT, :old.CMF_YN,
      :old.EXTERNAL_DEFAULT_PORTFOLIO, sysdate, :old.UPDATED_BY,
      :old.AUDIT_INDICATOR,sysdate, :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_PORTFOLIOS_T" ENABLE;
