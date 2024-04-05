--------------------------------------------------------
--  DDL for Trigger PAY_DEFINED_BALANCES_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_DEFINED_BALANCES_ARI" 
   after insert
   on    "HR"."PAY_DEFINED_BALANCES"
   for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  --
  -- set flag so new_defined_balance knows where it is being called from
  --
  hrdyndbi.g_trigger_dfb_ari := true;
  --
  --  create database item and other FF information for this balance
   hr_utility.set_location('pay_defined_balances_ari',1);
   hrdyndbi.new_defined_balance
                (p_defined_balance_id   => :NEW.defined_balance_id,
                 p_balance_dimension_id => :NEW.balance_dimension_id,
                 p_balance_type_id      => :NEW.balance_type_id,
                 p_business_group_id    => :NEW.business_group_id,
                 p_legislation_code     => :NEW.legislation_code);
  --
  -- initialise run balances if the defined balance is marked for run balance
  -- storage
  --
  if :NEW.save_run_balance = 'Y' then
    pay_balance_pkg.initialise_run_balance
                   (p_defbal_id         => :NEW.defined_balance_id
                   ,p_baldim_id         => :NEW.balance_dimension_id
                   ,p_bal_type_id       => :NEW.balance_type_id
                   ,p_legislation_code  => :NEW.legislation_code
                   ,p_business_group_id => :NEW.business_group_id);
  end if;
end if;
end pay_defined_balances_ari;



/
ALTER TRIGGER "APPS"."PAY_DEFINED_BALANCES_ARI" ENABLE;
