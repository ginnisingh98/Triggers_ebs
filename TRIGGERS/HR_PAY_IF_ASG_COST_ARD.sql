--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_ASG_COST_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_ASG_COST_ARD" AFTER DELETE
ON "HR"."PAY_COST_ALLOCATIONS_F"
DECLARE
  /* declare the cursors */
  CURSOR csr_get_event_id IS
  SELECT event_id
  FROM pay_trigger_events
  WHERE short_name = 'HR_PAY_IF_ASG_COST_ARD';
  --
  l_event_id          NUMBER;
  l_business_group_id NUMBER;
  l_legislation_code  VARCHAR2(10);
  l_payroll_id        NUMBER;
BEGIN
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
   IF hr_pay_interface_pkg.g_reporting_details_rec_var.business_group_id IS NULL
     THEN
          RETURN;
    END IF;

    l_business_group_id :=
    hr_pay_interface_pkg.g_reporting_details_rec_var.business_group_id;
    --
    l_legislation_code :=
    hr_pay_interface_pkg.g_reporting_details_rec_var.legislation_code;

    l_payroll_id :=
    hr_pay_interface_pkg.g_reporting_details_rec_var.payroll_id;

    /* Check whether the trigger is enabled in a functional area */
    OPEN csr_get_event_id;
      FETCH csr_get_event_id INTO l_event_id;
    CLOSE csr_get_event_id;

    IF paywsfgt_pkg.trigger_is_not_enabled(
                            p_event_id          => l_event_id,
                            p_legislation_code  => l_legislation_code,
                            p_business_group_id => l_business_group_id,
                            p_payroll_id        => l_payroll_id)
    THEN
      hr_pay_interface_pkg.g_cost_allocation_id := NULL;
      RETURN;
    ELSE
      hr_pay_interface_pkg.disable_asg_cost_delete_purge;
    END IF;
  END IF;
END hr_pay_if_asg_cost_ard;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_ASG_COST_ARD" ENABLE;
