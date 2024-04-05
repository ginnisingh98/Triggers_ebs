--------------------------------------------------------
--  DDL for Trigger PAY_PAYROLL_ACTIONS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PAYROLL_ACTIONS_BRU" 
/*
   This table shows the different changes in action status that can
   take place. The types are:
--
   -     Not a change
   N/A   Not a valid change
   E     Change which is an effect of a process or function
   C     Change which causes a process or function
--
   From  to ->        Un-          Populating  Error    Marked      Complete
                      processed                         for Retry
    |
    V
   Unprocessed        -            E           E        N/A         E
--
   Populating         N/A          -           E        N/A         E
--
   Error              N/A          E           -        N/A         E
--
   Marked for Retry   N/A          E           E        -           E
--
   Complete           N/A          E           N/A      C           -
--
*/
   before update
   on     "HR"."PAY_PAYROLL_ACTIONS"
   for each row
     WHEN (OLD.action_status <> NEW.action_status) begin
if hr_general.g_data_migrator_mode <> 'Y' then
--
   hr_utility.set_location('pay_payroll_actions_bru',10);
   if (:NEW.action_status <> :OLD.action_status) then
--
      if (:OLD.action_status = 'C' and :NEW.action_status = 'M') then
         --  doing a Retry operation
         hr_utility.set_location('pay_payroll_actions_bru',2);
--
   /*      hr_ass_actions.rollback_payroll_action(:OLD.payroll_action_id,
                                                :OLD.action_type,
                                                :OLD.effective_date,
                                                'RETRY');  */
--
      elsif (:NEW.action_status = 'C'
             or :NEW.action_status = 'P'
             or (:NEW.action_status = 'E' and :OLD.action_status <> 'C')) then
         null;
--
      else
         hr_utility.set_message(801,'HR_BAD_UPDATE');
         hr_utility.raise_error;
      end if;
--
   end if;
   hr_utility.set_location('pay_payroll_actions_bru',3);
end if;
end pay_payroll_actions_bru;


/
ALTER TRIGGER "APPS"."PAY_PAYROLL_ACTIONS_BRU" ENABLE;
