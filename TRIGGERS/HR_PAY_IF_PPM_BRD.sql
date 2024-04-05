--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_PPM_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_PPM_BRD" BEFORE DELETE
ON "HR"."PAY_PERSONAL_PAYMENT_METHODS_F" FOR EACH ROW
DECLARE
  --
  CURSOR csr_get_bg IS
    SELECT pa.business_group_id
    FROM   per_all_assignments_f pa
    WHERE  pa.assignment_id =  :old.assignment_id
    AND    rownum=1;
  --
  CURSOR csr_get_event_id IS
  SELECT event_id
  FROM pay_trigger_events
  WHERE short_name = 'HR_PAY_IF_PPM_BRD';
  --
  CURSOR csr_get_pid IS
    SELECT aa.payroll_id
    FROM per_all_assignments_f aa
    WHERE aa.assignment_id = :old.assignment_id                           AND
    nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate) >= aa.effective_start_date AND
    nvl(HR_PAY_INTERFACE_PKG.g_payroll_extract_date, sysdate) <= aa.effective_end_date;
  --
 l_event_id   NUMBER;
 l_business_group_id NUMBER;
 l_legislation_code VARCHAR2(10);
 l_payroll_id NUMBER;
  --
BEGIN
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
    --

    /* Is the trigger in an enabled functional area */
    OPEN csr_get_event_id;
    FETCH csr_get_event_id INTO l_event_id;
    CLOSE csr_get_event_id ;

    OPEN csr_get_bg;
    FETCH csr_get_bg
      INTO HR_PAY_INTERFACE_PKG.g_reporting_details_rec_var.business_group_id;
    CLOSE csr_get_bg;

    l_business_group_id := HR_PAY_INTERFACE_PKG.g_reporting_details_rec_var.business_group_id;
    l_legislation_code := pay_core_utils.get_legislation_code(
            p_bg_id                        => l_business_group_id
    );

    OPEN csr_get_pid;
    FETCH csr_get_pid
      INTO HR_PAY_INTERFACE_PKG.g_reporting_details_rec_var.payroll_id;
    CLOSE csr_get_pid;

    l_payroll_id :=
    hr_pay_interface_pkg.g_reporting_details_rec_var.payroll_id;

    IF paywsfgt_pkg.trigger_is_not_enabled(
      p_event_id          => l_event_id,
      p_legislation_code  => l_legislation_code,
      p_business_group_id => l_business_group_id,
      p_payroll_id        => l_payroll_id
    ) THEN
      RETURN;
    END IF;

    IF hr_pay_interface_pkg.g_personal_payment_method_id IS NOT NULL AND
      :old.personal_payment_method_id <>
	 hr_pay_interface_pkg.g_personal_payment_method_id
    THEN
      hr_utility.set_message (800, 'PER_PRS_PAY_MTD_DIS_MULT_DEL');
      hr_pay_interface_pkg.g_personal_payment_method_id := NULL;
      hr_utility.raise_error;
    ELSE
      hr_pay_interface_pkg.g_personal_payment_method_id :=
				  :old.personal_payment_method_id;
      hr_pay_interface_pkg.g_ppm_ass_id := :old.assignment_id;
--	 hr_pay_interface_pkg.g_ppm_end_date := :old.effective_end_date;
      hr_pay_interface_pkg.g_ppm_start_date := :old.effective_start_date;
    END IF;
  END IF;
END hr_pay_if_ppm_brd;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_PPM_BRD" ENABLE;
