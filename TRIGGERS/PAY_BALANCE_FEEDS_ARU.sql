--------------------------------------------------------
--  DDL for Trigger PAY_BALANCE_FEEDS_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_BALANCE_FEEDS_ARU" 
   after update
   on    "HR"."PAY_BALANCE_FEEDS_F"
   for each row
begin
  if hr_general.g_data_migrator_mode <> 'Y' then
   --  certain updates are not allowed !
   hr_utility.set_location('pay_balance_feeds_aru',1);
   if :OLD.balance_type_id <> :NEW.balance_type_id
   or :OLD.input_value_id <> :NEW.input_value_id
   or :OLD.balance_feed_id <> :NEW.balance_feed_id
   or :OLD.business_group_id <> :NEW.business_group_id
   or :OLD.legislation_code <> :NEW.legislation_code
   then
      hr_utility.set_message(801, 'HR_BAD_UPDATE');
      hr_utility.raise_error;
   end if;
--
   --  delete any potentially damaged latest balances
   hr_utility.set_location('pay_balance_feeds_aru',2);
   hrassact.trash_latest_balances(:OLD.balance_type_id,
                                  :OLD.input_value_id,
             least(:NEW.effective_end_date,:OLD.effective_end_date));
--
   hr_utility.set_location('pay_balance_feeds_aru',3);
   --
   -- set affected run balances to invalid
   --
   pay_balance_pkg.invalidate_run_balances(:OLD.balance_type_id,
                                           :OLD.input_value_id,
             least(:NEW.effective_end_date,:OLD.effective_end_date));
   --
   hr_utility.set_location('pay_balance_feeds_aru',5);
  end if;
end pay_balance_feeds_aru;



/
ALTER TRIGGER "APPS"."PAY_BALANCE_FEEDS_ARU" ENABLE;
