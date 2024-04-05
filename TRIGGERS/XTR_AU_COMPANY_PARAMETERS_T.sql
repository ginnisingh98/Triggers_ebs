--------------------------------------------------------
--  DDL for Trigger XTR_AU_COMPANY_PARAMETERS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_COMPANY_PARAMETERS_T" 
 AFTER UPDATE on "XTR"."XTR_COMPANY_PARAMETERS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'COMPANY PARAMETERS';
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
   INSERT INTO XTR_A_COMPANY_PARAMETERS(
      COMPANY_PARAMETER_ID, COMPANY_CODE, PARAMETER_CODE, PARAMETER_VALUE_CODE,
      PARAMETER_VALUE, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN, AUDIT_DATE_STORED
      ) VALUES (
      :OLD.COMPANY_PARAMETER_ID, :OLD.COMPANY_CODE, :OLD.PARAMETER_CODE, :OLD.PARAMETER_VALUE_CODE,
      :OLD.PARAMETER_VALUE, :OLD.CREATED_BY, :OLD.CREATION_DATE,
      :OLD.LAST_UPDATED_BY, SYSDATE, :OLD.LAST_UPDATE_LOGIN, SYSDATE
      );
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_COMPANY_PARAMETERS_T" ENABLE;
