--------------------------------------------------------
--  DDL for Trigger XTR_AU_COMPANY_LIMITS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_COMPANY_LIMITS_T" 
 AFTER UPDATE on "XTR"."XTR_COMPANY_LIMITS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'COMPANY LIMITS';
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
   INSERT INTO XTR_A_COMPANY_LIMITS(
      COMPANY_CODE, LIMIT_CODE, LIMIT_TYPE, NAME,
      CREATED_BY, CREATED_ON, LIMIT_AMOUNT, UPDATED_BY,
      UPDATED_ON, AUTHORISED, AUDIT_INDICATOR, AUDIT_DATE_STORED
      ) VALUES (
      :old.COMPANY_CODE, :old.LIMIT_CODE, :old.LIMIT_TYPE, :old.NAME,
      :old.CREATED_BY, :old.CREATED_ON, :old.LIMIT_AMOUNT, :old.UPDATED_BY,
      sysdate, :old.AUTHORISED,
      :old.AUDIT_INDICATOR,sysdate);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_COMPANY_LIMITS_T" ENABLE;
