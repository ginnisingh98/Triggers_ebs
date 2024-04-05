--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_PPM_NO_UPDATE_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_PPM_NO_UPDATE_ARU" after update
on "HR"."PAY_PERSONAL_PAYMENT_METHODS_F" for each row
declare
 /* declare the cursors */
 CURSOR csr_get_event_id IS
 SELECT event_id
 FROM pay_trigger_events
 WHERE short_name = 'HR_PAY_IF_PPM_NO_UPDATE_ARU';

 CURSOR csr_get_payroll_id IS
 SELECT aa.payroll_id
 FROM per_all_assignments_f aa
 WHERE
 :old.assignment_id = aa.assignment_id                                  AND
 nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate) >= aa.effective_start_date AND
 nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate) <= aa.effective_end_date;

 --
 l_event_id   NUMBER;
 l_business_group_id NUMBER;
 l_legislation_code VARCHAR2(10);
 l_payroll_id NUMBER;
begin
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
    /* Initialise the variables to ensure the triggers work */

    l_business_group_id := :new.business_group_id;

    IF l_business_group_id IS NULL THEN
	 return;
    END IF;

    l_legislation_code := pay_core_utils.get_legislation_code(
  	    p_bg_id                        => l_business_group_id
    );


    /* Is the trigger in an enabled functional area */
    OPEN csr_get_event_id;
    FETCH csr_get_event_id INTO l_event_id;
    CLOSE csr_get_event_id ;

    OPEN csr_get_payroll_id;
    FETCH csr_get_payroll_id INTO l_payroll_id;
    CLOSE csr_get_payroll_id;

    IF paywsfgt_pkg.trigger_is_not_enabled(
      p_event_id          => l_event_id,
      p_legislation_code  => l_legislation_code,
      p_business_group_id => l_business_group_id,
      p_payroll_id        => l_payroll_id
    ) THEN
      RETURN;
    END IF;
    /* If the procedure hasn't exited at this point, run the trigger code*/

    hr_pay_interface_pkg.disable_ppm_update (:old.priority,
                                             :new.priority);
  END IF;
end hr_pay_if_ppm_no_update_aru ;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_PPM_NO_UPDATE_ARU" ENABLE;
