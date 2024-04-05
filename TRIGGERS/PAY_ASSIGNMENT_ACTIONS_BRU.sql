--------------------------------------------------------
--  DDL for Trigger PAY_ASSIGNMENT_ACTIONS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ASSIGNMENT_ACTIONS_BRU" 
/*
   This table shows the different changes in action status that can
   take place. The types are:
--
   -     Not a change
   N/A   Not a valid change (* denotes an exception, described below).
   E     Change which is an effect of a process or function
   C     Change which causes a process or function
--
   The forms must only allow updates of the C class (i.e, from
   Complete to Mark for Retry). In this case we rely on updater
   already calling mark_for_retry_ok function to check for all
   subsequent unretried actions.  Other valid changes must be
   the result of a packaged procedure or process.
--
   From  to ->        Un-          Error    Marked      Complete   BackPaying
                      processed             for Retry
    |
    V
   Unprocessed        -            E        N/A         E          N/A ++
--
   Error              N/A +        -        N/A         E          N/A
--
   Marked for Retry   N/A          E        -           E          N/A
--
   Complete           N/A          N/A      C           -          C
--
   BackPaying         N/A          N/A      N/A         E          -
--
   + This change is valid in the case of Magnetic Transfer.
   ++ This is valid in the Advance Pay process.
*/
   before update
   on     "HR"."PAY_ASSIGNMENT_ACTIONS"
   for each row
      WHEN (OLD.action_status <> NEW.action_status) begin
--
if hr_general.g_data_migrator_mode <> 'Y' then
  hr_utility.set_location('pay_assignment_actions_bru',10);
   if (:NEW.action_status <> :OLD.action_status) then
--
      if (:OLD.action_status in ('C', 'S') and :NEW.action_status = 'M') then
         --  doing a Retry operation
         hr_utility.set_location('pay_assignment_actions_bru',20);
         hrassact.ensure_assact_rolled_back
                    (:OLD.assignment_action_id, 'RETRY');
--
      elsif (:OLD.action_status in ('C', 'S') and :NEW.action_status = 'B') then
         --  doing a Mark for Backpay operation
         hr_utility.set_location('pay_assignment_actions_bru',30);
         hrassact.ensure_assact_rolled_back
                    (:OLD.assignment_action_id, 'BACKPAY');
--
      elsif (:NEW.action_status = 'C'
             or (:NEW.action_status = 'E'
                 and :OLD.action_status in ('U','M'))) then
         null;
--
      elsif (:OLD.action_status = 'E' and :NEW.action_status = 'U') then
         -- We can only perform an update from error to unprocessed
         -- in the case of (retry) of Magnetic Transfer.
         declare
            actype pay_payroll_actions.action_type%type;
         begin
            select pac.action_type
            into   actype
            from   pay_payroll_actions pac
            where  pac.payroll_action_id = :NEW.payroll_action_id;
--
            if (actype <> 'M') then
               hr_utility.set_message(801, 'HR_6218_ACTION_BAD_UPDATE');
               hr_utility.raise_error;
            end if;
         end;
      elsif (:OLD.action_status = 'U' and :NEW.action_status = 'B') then
         -- We can only perform an update from unprocessed to backpaying
         -- in the case of Advance Pay(!)
         declare
            actype pay_payroll_actions.action_type%type;
         begin
            select pac.action_type
            into   actype
            from   pay_payroll_actions pac
            where  pac.payroll_action_id = :NEW.payroll_action_id;
--
            if (actype not in ('F', 'W')) then
               hr_utility.set_message(801, 'HR_6218_ACTION_BAD_UPDATE');
               hr_utility.raise_error;
            end if;
         end;
      elsif ((:NEW.action_status = 'S') OR (:OLD.action_status = 'S')) then
         null;
      else
         hr_utility.set_message(801, 'HR_6218_ACTION_BAD_UPDATE');
         hr_utility.raise_error;
      end if;
  end if;
   hr_utility.set_location('pay_assignment_actions_bru',40);
end if;
end pay_assignment_actions_bru;


/
ALTER TRIGGER "APPS"."PAY_ASSIGNMENT_ACTIONS_BRU" ENABLE;
