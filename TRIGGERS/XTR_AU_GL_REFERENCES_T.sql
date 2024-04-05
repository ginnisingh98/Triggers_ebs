--------------------------------------------------------
--  DDL for Trigger XTR_AU_GL_REFERENCES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_GL_REFERENCES_T" 
 AFTER UPDATE on "XTR"."XTR_GL_REFERENCES"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'GL REFERENCES';
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
   INSERT INTO XTR_A_GL_REFERENCES(
      COMPANY_CODE, CODE_COMBINATION_ID, CREATED_BY, CREATED_ON,
      UPDATED_BY, UPDATED_ON,
      AUDIT_INDICATOR, AUDIT_DATE_STORED
      ) VALUES (
      :old.COMPANY_CODE, :old.CODE_COMBINATION_ID, :old.CREATED_BY, :old.CREATED_ON,
      :old.UPDATED_BY, sysdate,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY
      HH24:MI:SS'),'DD/MM/YYYY HH24:MI:SS'));
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_GL_REFERENCES_T" ENABLE;
