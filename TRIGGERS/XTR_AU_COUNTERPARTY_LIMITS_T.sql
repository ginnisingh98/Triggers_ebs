--------------------------------------------------------
--  DDL for Trigger XTR_AU_COUNTERPARTY_LIMITS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_COUNTERPARTY_LIMITS_T" 
 AFTER UPDATE on "XTR"."XTR_COUNTERPARTY_LIMITS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT(p_event varchar2) is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = p_event;
 --
 l_val VARCHAR2(1);
 --
begin
 -- Check that Audit on this table has been specified
 open CHK_AUDIT('COUNTERPARTY LIMITS');
  fetch CHK_AUDIT INTO l_val;
 if CHK_AUDIT%NOTFOUND then
  l_val := 'N';
 end if;
 close CHK_AUDIT;
 -- Copy to Audit Table the Pre-Updated row
 if nvl(upper(l_val),'N') = 'Y' then
   INSERT INTO XTR_A_COUNTERPARTY_LIMITS(
      COMPANY_CODE, LIMIT_CODE, CPARTY_CODE,
      CREATED_BY, CREATED_ON, LIMIT_AMOUNT,
      SEQUENCE_NUMBER, INITIAL_FEE_DATE, EXPIRY_DATE,
      UTILISATION_FEE_PERCENT, COMMITMENT_FEE_PERCENT,
      FREQUENCY, UPDATED_BY, UPDATED_ON, AUTHORISED,
      AUDIT_INDICATOR, AUDIT_DATE_STORED
      ) VALUES (
      :old.COMPANY_CODE, :old.LIMIT_CODE, :old.CPARTY_CODE,
      :old.CREATED_BY, :old.CREATED_ON, :old.LIMIT_AMOUNT,
      :old.SEQUENCE_NUMBER, :old.INITIAL_FEE_DATE, :old.EXPIRY_DATE,
      :old.UTILISATION_FEE_PERCENT, :old.COMMITMENT_FEE_PERCENT,
      :old.FREQUENCY, :old.UPDATED_BY, sysdate, :old.AUTHORISED,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'));
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_COUNTERPARTY_LIMITS_T" ENABLE;
