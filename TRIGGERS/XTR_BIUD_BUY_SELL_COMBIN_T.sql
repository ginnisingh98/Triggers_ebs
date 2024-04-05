--------------------------------------------------------
--  DDL for Trigger XTR_BIUD_BUY_SELL_COMBIN_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_BIUD_BUY_SELL_COMBIN_T" 
 BEFORE INSERT OR UPDATE OR DELETE on "XTR"."XTR_AUTH_CCY_COMBINATIONS"
 FOR EACH ROW
-- Insert 2 rows into BUY_SELL_COMBINATIONS table
declare
 dummy VARCHAR2(1);
 cursor COMBIN_EXISTS is
  select 'x'
   from  XTR_BUY_SELL_COMBINATIONS
   where currency_first  = :NEW.CURRENCY_QUOTE_FIRST
   and   currency_second = :NEW.CURRENCY_QUOTE_SECOND;
--
begin
 if INSERTING then
  if :NEW.AUTHORISED = 'Y' then
   open COMBIN_EXISTS;
   fetch COMBIN_EXISTS INTO dummy;
   if COMBIN_EXISTS%NOTFOUND then
   insert INTO XTR_BUY_SELL_COMBINATIONS
    (currency_buy, currency_sell,
     currency_first, currency_second,
     authorised, CREATED_ON, CREATED_BY)
   values
    (:NEW.CURRENCY_QUOTE_FIRST, :NEW.CURRENCY_QUOTE_SECOND,
     :NEW.CURRENCY_QUOTE_FIRST, :NEW.CURRENCY_QUOTE_SECOND,
     :NEW.AUTHORISED, :NEW.CREATED_ON, :NEW.CREATED_BY);
--
   insert INTO XTR_BUY_SELL_COMBINATIONS
    (currency_buy, currency_sell,
     currency_first, currency_second,
     authorised, CREATED_ON, CREATED_BY)
   values
    (:NEW.CURRENCY_QUOTE_SECOND,:NEW.CURRENCY_QUOTE_FIRST,
     :NEW.CURRENCY_QUOTE_FIRST,:NEW.CURRENCY_QUOTE_SECOND,
     :NEW.AUTHORISED, :NEW.CREATED_ON, :NEW.CREATED_BY);
   end if;
   close COMBIN_EXISTS;
  end if;
 elsif UPDATING then
   update XTR_BUY_SELL_COMBINATIONS
     set currency_first=:NEW.CURRENCY_QUOTE_FIRST,
         currency_second=:NEW.CURRENCY_QUOTE_SECOND,
         authorised = :NEW.AUTHORISED
    where (currency_buy  = :NEW.CURRENCY_QUOTE_FIRST
      and  currency_sell = :NEW.CURRENCY_QUOTE_SECOND)
     or (currency_sell  = :NEW.CURRENCY_QUOTE_FIRST
      and  currency_buy = :NEW.CURRENCY_QUOTE_SECOND);
  if SQL%NOTFOUND and :NEW.AUTHORISED='Y' then
   insert INTO XTR_BUY_SELL_COMBINATIONS
    (currency_buy, currency_sell,
     currency_first, currency_second,
     authorised, CREATED_ON, CREATED_BY)
   values
    (:NEW.CURRENCY_QUOTE_FIRST, :NEW.CURRENCY_QUOTE_SECOND,
     :NEW.CURRENCY_QUOTE_FIRST, :NEW.CURRENCY_QUOTE_SECOND,
     :NEW.AUTHORISED, :NEW.CREATED_ON, :NEW.CREATED_BY);
--
   insert INTO XTR_BUY_SELL_COMBINATIONS
    (currency_buy, currency_sell,
     currency_first, currency_second,
     authorised, CREATED_ON, CREATED_BY)
   values
    (:NEW.CURRENCY_QUOTE_SECOND,:NEW.CURRENCY_QUOTE_FIRST,
     :NEW.CURRENCY_QUOTE_FIRST,:NEW.CURRENCY_QUOTE_SECOND,
     :NEW.AUTHORISED, :NEW.CREATED_ON, :NEW.CREATED_BY);
   end if;
 elsif DELETING then
   delete from XTR_BUY_SELL_COMBINATIONS
    where currency_first = :OLD.CURRENCY_QUOTE_FIRST
     and  currency_second = :OLD.CURRENCY_QUOTE_SECOND;
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_BIUD_BUY_SELL_COMBIN_T" ENABLE;
