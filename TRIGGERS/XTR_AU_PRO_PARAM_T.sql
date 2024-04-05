--------------------------------------------------------
--  DDL for Trigger XTR_AU_PRO_PARAM_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_PRO_PARAM_T" 
 AFTER UPDATE on "XTR"."XTR_PRO_PARAM"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'SYSTEM PARAMETERS';
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
   INSERT INTO XTR_A_PRO_PARAM(
      UNIQUE_REF_NUM, PARAM_NAME, PARAM_VALUE,
      PARAM_TYPE, UPDATED_ON, UPDATED_BY,
      AUDIT_INDICATOR , AUDIT_DATE_STORED,
      CREATED_ON, CREATED_BY
      ) VALUES (
      :old.UNIQUE_REF_NUM, :old.PARAM_NAME, :old.PARAM_VALUE,
      :old.PARAM_TYPE, sysdate, :old.UPDATED_BY,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'), :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_PRO_PARAM_T" ENABLE;
