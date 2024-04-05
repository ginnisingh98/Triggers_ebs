--------------------------------------------------------
--  DDL for Trigger XTR_AU_TAX_BROKERAGE_SETUP_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_TAX_BROKERAGE_SETUP_T" 
 AFTER UPDATE on "XTR"."XTR_TAX_BROKERAGE_SETUP"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'TAX/BROKERAGE SETUP';
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
   INSERT INTO XTR_A_TAX_BROKERAGE_SETUP(
      DEDUCTION_TYPE, REFERENCE_CODE, RATE_GROUP,
      CALC_TYPE, DESCRIPTION, PAYEE,
      NOMINAL_ANNUAL_TAX_BREAK, UPDATED_ON, UPDATED_BY,
      AUDIT_INDICATOR , AUDIT_DATE_STORED,DEAL_TYPE,AUTHORISED,
      CREATED_ON, CREATED_BY
      ) VALUES (
      :old.DEDUCTION_TYPE, :old.REFERENCE_CODE, :old.RATE_GROUP,
      :old.CALC_TYPE, :old.DESCRIPTION, :old.PAYEE,
      :old.NOMINAL_ANNUAL_TAX_BREAK, sysdate, :old.UPDATED_BY,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'),:old.DEAL_TYPE, :old.AUTHORISED,
      :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_TAX_BROKERAGE_SETUP_T" ENABLE;
