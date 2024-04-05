--------------------------------------------------------
--  DDL for Trigger XTR_AU_PARTY_DEFAULTS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_PARTY_DEFAULTS_T" 
 AFTER UPDATE on "XTR"."XTR_PARTY_DEFAULTS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'PARTY DEFAULTS';
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
   INSERT INTO XTR_A_PARTY_DEFAULTS(
      TRANSACTION_NUMBER, PARTY_CODE, DEAL_TYPE,
      DEAL_SUBTYPE, PRODUCT_TYPE, DFLT_PRINCIPAL_ACTION,
      DFLT_INTEREST_ACTION, FREQ_INTEREST_SETTLED,
      INTEREST_SETTLED_BY, PRINCIPAL_SETTLED_BY,
      TAX_REFERENCE, BROKERAGE_REFERENCE, DEFAULT_TYPE,
      SETTLEMENT_DEFAULT_CATEGORY, TAX_CATEGORY,
      BROKERAGE_CATEGORY, UPDATED_ON, UPDATED_BY,
      AUDIT_INDICATOR, AUDIT_DATE_STORED,CREATED_ON, CREATED_BY
      ) VALUES (
      :old.TRANSACTION_NUMBER, :old.PARTY_CODE, :old.DEAL_TYPE,
      :old.DEAL_SUBTYPE, :old.PRODUCT_TYPE, :old.DFLT_PRINCIPAL_ACTION,
      :old.DFLT_INTEREST_ACTION, :old.FREQ_INTEREST_SETTLED,
      :old.INTEREST_SETTLED_BY, :old.PRINCIPAL_SETTLED_BY,
      :old.TAX_REFERENCE, :old.BROKERAGE_REFERENCE, :old.DEFAULT_TYPE,
      :old.SETTLEMENT_DEFAULT_CATEGORY, :old.TAX_CATEGORY,
      :old.BROKERAGE_CATEGORY, sysdate, :old.UPDATED_BY,
      :old.AUDIT_INDICATOR,sysdate, :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_PARTY_DEFAULTS_T" ENABLE;
