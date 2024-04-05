--------------------------------------------------------
--  DDL for Trigger XTR_AU_EXPOSURE_TYPES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_EXPOSURE_TYPES_T" 
 AFTER UPDATE on "XTR"."XTR_EXPOSURE_TYPES"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'EXPOSURE TYPES';
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
   INSERT INTO XTR_A_EXPOSURE_TYPES(
      COMPANY_CODE, EXPOSURE_TYPE, NAME,
      FREQUENCY, CODE_COMBINATION_ID, TAX_BROKERAGE_TYPE,
      TAX_OR_BROKERAGE, UPDATED_ON, UPDATED_BY,
      AUDIT_INDICATOR, AUDIT_DATE_STORED,CREATED_ON, CREATED_BY
      ) VALUES (
      :old.COMPANY_CODE, :old.EXPOSURE_TYPE, :old.NAME,
      :old.FREQUENCY, :old.CODE_COMBINATION_ID, :old.TAX_BROKERAGE_TYPE,
      :old.TAX_OR_BROKERAGE, sysdate, :old.UPDATED_BY,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'), :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_EXPOSURE_TYPES_T" ENABLE;
