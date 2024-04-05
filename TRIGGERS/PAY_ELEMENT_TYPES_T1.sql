--------------------------------------------------------
--  DDL for Trigger PAY_ELEMENT_TYPES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ELEMENT_TYPES_T1" 
/* $Header: pytrelnk.sql 115.3 99/07/17 06:38:54 porting ship  $ */
before update of 	indirect_only_flag,
			post_termination_rule,
			process_in_run_flag,
			adjustment_only_flag,
			multiple_entries_allowed_flag
on "HR"."PAY_ELEMENT_TYPES_F"
for each row
					--

begin
if hr_general.g_data_migrator_mode <> 'Y' then
hr_utility.set_location ('PAY_ELEMENT_TYPES_T1',1);
					--
if  ((:old.indirect_only_flag <> :new.indirect_only_flag or
      :old.process_in_run_flag <> :new.process_in_run_flag or
      :old.post_termination_rule <> :new.post_termination_rule) and
  	 pay_element_types_pkg.run_results_exist (:new.element_type_id)) then
  --
    hr_utility.set_message (801,'PAY_6909_ELEMENT_NO_UPD_RR');
    hr_utility.raise_error;
					--
elsif (:old.adjustment_only_flag <> :new.adjustment_only_flag and
       pay_element_types_pkg.fed_by_indirect_results (:new.element_type_id)) then
    --
    hr_utility.set_message (801,'PAY_6912_ELEMENT_NO_FRR_UPD');
    hr_utility.raise_error;
					--
elsif (:old.multiple_entries_allowed_flag <> :new.multiple_entries_allowed_flag
     and pay_element_types_pkg.update_recurring_rules_exist (:new.element_type_id)) then
  --
  hr_utility.set_message (801,'HR_6954_PAY_ELE_NO_UPD_REC');
  hr_utility.raise_error;
  --
elsif (:old.multiple_entries_allowed_flag <> :new.multiple_entries_allowed_flag
    and pay_element_types_pkg.stop_entry_rules_exist (:new.element_type_id)) then
    --
    hr_utility.set_message (801,'PAY_6953_PAY_ELE_NO_STOP_ENTRY');
    hr_utility.raise_error;
					--
end if;
					--
					--
end if;
end;



/
ALTER TRIGGER "APPS"."PAY_ELEMENT_TYPES_T1" ENABLE;
