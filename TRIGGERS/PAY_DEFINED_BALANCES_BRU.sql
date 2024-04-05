--------------------------------------------------------
--  DDL for Trigger PAY_DEFINED_BALANCES_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_DEFINED_BALANCES_BRU" 
   before update
   on     "HR"."PAY_DEFINED_BALANCES"
   for    each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
--
-- do not allow the SAVE_RUN_BALANCE flag to be altered from 'Y' to 'N' or null
-- if valid run_balances exist for the defined_balance.
--
  pay_defined_balances_pkg.verify_save_run_bal_flag_upd
                          (p_defined_balance_id     => :OLD.defined_balance_id
                          ,p_old_save_run_bal_flag  => :OLD.save_run_balance
                          ,p_new_save_run_bal_flag  => :NEW.save_run_balance);
  --
end if;
end pay_defined_balances_bru;



/
ALTER TRIGGER "APPS"."PAY_DEFINED_BALANCES_BRU" ENABLE;
