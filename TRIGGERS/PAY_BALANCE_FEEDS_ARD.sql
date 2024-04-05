--------------------------------------------------------
--  DDL for Trigger PAY_BALANCE_FEEDS_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_BALANCE_FEEDS_ARD" 
   after delete
   on    "HR"."PAY_BALANCE_FEEDS_F"
   for each row
begin
  if hr_general.g_data_migrator_mode <> 'Y' then
   --  delete any potentially damaged latest balances
   hr_utility.set_location('pay_balance_feeds_ard',1);
   hrassact.trash_latest_balances(:OLD.balance_type_id,
                                  :OLD.input_value_id,
                                  :OLD.effective_start_date);
--
   hr_utility.set_location('pay_balance_feeds_ard',2);
   --
   -- set affected run balances to invalid
   --
   pay_balance_pkg.invalidate_run_balances(:OLD.balance_type_id,
                                           :OLD.input_value_id,
                                           :OLD.effective_start_date);
   --
   hr_utility.set_location('pay_balance_feeds_ard',5);
  end if;
end pay_balance_feeds_ard;



/
ALTER TRIGGER "APPS"."PAY_BALANCE_FEEDS_ARD" ENABLE;
