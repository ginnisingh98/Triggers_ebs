--------------------------------------------------------
--  DDL for Trigger PAY_PAYROLL_ACTIONS_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PAYROLL_ACTIONS_BRD" 
   before delete
   on     "HR"."PAY_PAYROLL_ACTIONS"
   for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
--
   --  we don't do any work here, just check that any assignment actions
   --  have already been rolled back.
   hr_utility.set_location('pay_payroll_actions_brd',10);
   hrassact.ensure_pact_rolled_back (p_pact_id => :OLD.payroll_action_id);
--
   hr_utility.set_location('pay_payroll_actions_brd',20);
end if;
end pay_payroll_actions_brd;


/
ALTER TRIGGER "APPS"."PAY_PAYROLL_ACTIONS_BRD" ENABLE;
