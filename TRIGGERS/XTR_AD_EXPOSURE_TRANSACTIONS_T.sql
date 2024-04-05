--------------------------------------------------------
--  DDL for Trigger XTR_AD_EXPOSURE_TRANSACTIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AD_EXPOSURE_TRANSACTIONS_T" 
	 AFTER DELETE on "XTR"."XTR_EXPOSURE_TRANSACTIONS"
	 FOR EACH ROW

begin
   --Delete row from XTR_CONFIRMATION_DETAILS table

   if :OLD.SETTLE_ACTION_REQD = 'Y'
       and :OLD.PURCHASING_MODULE = 'N'
       and nvl(:OLD.CASH_POSITION_EXPOSURE,'N') = 'N' then

       delete from XTR_CONFIRMATION_DETAILS
       where deal_type = 'EXP'
       and transaction_no = :OLD.TRANSACTION_NUMBER;

   end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AD_EXPOSURE_TRANSACTIONS_T" ENABLE;
