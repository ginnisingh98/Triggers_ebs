--------------------------------------------------------
--  DDL for Trigger XTR_AU_BUY_SELL_COMBINATIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_BUY_SELL_COMBINATIONS_T" 
 AFTER UPDATE on "XTR"."XTR_BUY_SELL_COMBINATIONS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'BUY / SELL CURRENCIES';
 --
 l_val VARCHAR2(1);
 --
begin
 if nvl(:OLD.LATEST_CROSS_RATE,0) =
   nvl(:NEW.LATEST_CROSS_RATE,0) then
  -- Don't insert audit row when cross rate is being updated
  -- Check that Audit on this table has been specified
  open CHK_AUDIT;
    fetch CHK_AUDIT INTO l_val;
   if CHK_AUDIT%NOTFOUND then
    l_val := 'N';
   end if;
   close CHK_AUDIT;
   -- Copy to Audit Table the Pre-Updated row
   if nvl(upper(l_val),'N') = 'Y' then
    insert into XTR_A_BUY_SELL_COMBINATIONS(
      CURRENCY_BUY, CURRENCY_SELL, CURRENCY_FIRST,
      CURRENCY_SECOND, AUTHORISED, UPDATED_ON,
      UPDATED_BY, AUDIT_INDICATOR, AUDIT_DATE_STORED,
      CREATED_BY, CREATED_ON
      ) VALUES (
      :old.CURRENCY_BUY, :old.CURRENCY_SELL, :old.CURRENCY_FIRST,
      :old.CURRENCY_SECOND, :old.AUTHORISED, sysdate,
      :old.UPDATED_BY, :old.AUDIT_INDICATOR,sysdate,
      :old.CREATED_BY, :old.CREATED_ON);
   end if;
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_BUY_SELL_COMBINATIONS_T" ENABLE;
