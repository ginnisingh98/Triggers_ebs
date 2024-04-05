--------------------------------------------------------
--  DDL for Trigger XTR_AU_DEALER_CODES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_DEALER_CODES_T" 
 AFTER UPDATE on "XTR"."XTR_DEALER_CODES"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'USER CODES SETUP';
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
   INSERT INTO XTR_A_DEALER_CODES(
      DEALER_USER_NAME, DEALER_CODE, UPDATED_ON,
      UPDATED_BY, AUDIT_INDICATOR,
      AUDIT_DATE_STORED,CREATED_ON, CREATED_BY,USER_ID
      ) VALUES (
      :old.DEALER_USER_NAME, :old.DEALER_CODE, sysdate,
      :old.UPDATED_BY, :old.AUDIT_INDICATOR,
      to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'),:old.CREATED_ON, :old.CREATED_BY,:old.USER_ID);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_DEALER_CODES_T" ENABLE;
