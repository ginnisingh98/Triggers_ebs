--------------------------------------------------------
--  DDL for Trigger PAY_ASSIGNMENT_ACTIONS_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ASSIGNMENT_ACTIONS_BRD" 
/*
   Because of mutating table restrictions we can't current do the actual
   rollback from this trigger (at least not for sequenced actions), all we
   can do is try and make sure the user has already called the
   rollback_ass_action procedure.
*/
   before delete
   on     "HR"."PAY_ASSIGNMENT_ACTIONS"
   for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
--
   hr_utility.set_location('pay_assignment_actions_brd',10);
   hrassact.ensure_assact_rolled_back (:OLD.assignment_action_id, 'ROLLBACK');
--
   hr_utility.set_location('pay_assignment_actions_brd',20);
--
end if;
end pay_assignment_actions_brd;


/
ALTER TRIGGER "APPS"."PAY_ASSIGNMENT_ACTIONS_BRD" ENABLE;
