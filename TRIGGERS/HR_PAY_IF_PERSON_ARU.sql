--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_PERSON_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_PERSON_ARU" after update
on "HR"."PER_ALL_PEOPLE_F" for each row
declare
 /* declare the cursors */
 CURSOR csr_get_event_id IS
 SELECT event_id
 FROM pay_trigger_events
 WHERE short_name = 'HR_PAY_IF_PERSON_ARU';

 CURSOR csr_payroll_id IS
 SELECT aa.payroll_id
 FROM per_all_assignments_f aa
 WHERE
 aa.primary_flag = 'Y'                                                 AND
 aa.person_id = :old.person_id                                         AND
 nvl(hr_pay_interface_pkg.g_payroll_extract_date, sysdate) >= aa.effective_start_date AND
 nvl(hr_pay_interface_pkg.g_payroll_extract_date, sysdate) <= aa.effective_end_date;
 --
 l_event_id   NUMBER;
 l_business_group_id NUMBER;
 l_legislation_code VARCHAR2(10);
 l_payroll_id NUMBER := NULL;
begin
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN

    IF :old.employee_number = :new.employee_number THEN
	 RETURN;
    END IF;

    /* Initialise the variables to ensure the triggers work */
    l_business_group_id := :old.business_group_id;
    --
    l_legislation_code := pay_core_utils.get_legislation_code(
  	  p_bg_id                        => l_business_group_id
     );

    OPEN csr_get_event_id;
    FETCH csr_get_event_id INTO l_event_id;
    CLOSE csr_get_event_id ;

    OPEN csr_payroll_id;
    FETCH csr_payroll_id INTO l_payroll_id;
    CLOSE csr_payroll_id;

    IF paywsfgt_pkg.trigger_is_not_enabled(
      p_event_id          => l_event_id,
      p_legislation_code  => l_legislation_code,
      p_business_group_id => l_business_group_id,
      p_payroll_id        => l_payroll_id
    ) THEN
      RETURN;
    END IF;
    /* If the procedure hasn't exited at this point, run the trigger code*/

    hr_pay_interface_pkg.disable_emp_number_update (:old.employee_number,
                                                    :new.employee_number);
  END IF;
end hr_pay_if_person_aru ;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_PERSON_ARU" ENABLE;
