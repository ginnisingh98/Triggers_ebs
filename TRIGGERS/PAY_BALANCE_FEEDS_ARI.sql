--------------------------------------------------------
--  DDL for Trigger PAY_BALANCE_FEEDS_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_BALANCE_FEEDS_ARI" 
   after insert
   on    "HR"."PAY_BALANCE_FEEDS_F"
   for each row
begin
  if hr_general.g_data_migrator_mode <> 'Y' then
   --  delete any potentially damaged latest balances
   hr_utility.set_location('pay_balance_feeds_ari',1);
   hrassact.trash_latest_balances(:NEW.balance_type_id,
                                  :NEW.input_value_id,
                                  :NEW.effective_start_date);
   --
   hr_utility.set_location('pay_balance_feeds_ari',2);
   --
   -- set affected run balances to invalid
   --
   pay_balance_pkg.invalidate_run_balances(:NEW.balance_type_id,
                                           :NEW.input_value_id,
                                           :NEW.effective_start_date);
   --
   hr_utility.set_location('pay_balance_feeds_ari',5);
  end if;
end pay_balance_feeds_ari;



/
ALTER TRIGGER "APPS"."PAY_BALANCE_FEEDS_ARI" ENABLE;
