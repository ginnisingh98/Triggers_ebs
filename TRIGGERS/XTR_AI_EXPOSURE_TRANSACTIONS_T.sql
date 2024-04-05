--------------------------------------------------------
--  DDL for Trigger XTR_AI_EXPOSURE_TRANSACTIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AI_EXPOSURE_TRANSACTIONS_T" 
	 AFTER INSERT on "XTR"."XTR_EXPOSURE_TRANSACTIONS"
	 FOR EACH ROW
declare
   l_sys_date DATE;
begin
   --Insert row into XTR_CONFIRMATION_DETAILS table
   l_sys_date :=trunc(sysdate);
   if :NEW.SETTLE_ACTION_REQD = 'Y'
       and :NEW.PURCHASING_MODULE = 'N'
       and nvl(:NEW.CASH_POSITION_EXPOSURE,'N') = 'N' then
      XTR_MISC_P.DEAL_ACTIONS (:NEW.deal_type,
                               0,
                               :NEW.transaction_number,
                               'NEW_EXPOSURE_TRANSACTION',
                               :NEW.thirdparty_code,
                               null,
                               l_sys_date,
                               :NEW.company_code,
                               :NEW.status_code,
                               null,
                               :NEW.deal_subtype,
                               :NEW.currency,
                               null,
                               null,
                               :NEW.amount,
                               'Y');
   end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AI_EXPOSURE_TRANSACTIONS_T" ENABLE;
