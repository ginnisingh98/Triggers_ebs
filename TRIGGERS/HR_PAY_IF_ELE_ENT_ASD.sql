--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_ELE_ENT_ASD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_ELE_ENT_ASD" AFTER DELETE
on "HR"."PAY_ELEMENT_ENTRIES_F"
DECLARE
  /* declare the cursors */
  CURSOR csr_get_event_id IS
  SELECT event_id
  FROM pay_trigger_events
  WHERE short_name = 'HR_PAY_IF_ELE_ENT_ASD';
  --
  CURSOR csr_final_process_date IS
  SELECT pps.final_process_date fpd
  FROM
	per_periods_of_service pps
  WHERE
     pps.person_id = hr_pay_interface_pkg.g_ele_person_id;
  --
  l_event_id   NUMBER;
  l_business_group_id NUMBER;
  l_legislation_code VARCHAR2(10);
  l_payroll_id NUMBER;
  l_fpd DATE := NULL;
  --
BEGIN

  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
    -- If the business group id is null, the Before Row trigger didn't fire
    -- which means that no rows have been deleted in the database.
    -- Hence the trigger doesn't need to fire.
    --
    IF hr_pay_interface_pkg.g_element_entry_rec_var.business_group_id IS NULL
    THEN
      return;
    END IF;
    --
    --open  csr_final_process_date;
    --fetch csr_final_process_date into l_fpd;
    --close csr_final_process_date;
    for cfpd in csr_final_process_date
    loop
        l_fpd := cfpd.fpd;
    end loop;

    --Ensure the start date of the element entry is not after the final
    --process date of the employee (if terminated).  If it is, then the
    --element should be deleted, therefore the trigger shouldn't fire,
    --and should exit at this point.
    IF ((l_fpd IS NOT NULL) AND
        (l_fpd < hr_pay_interface_pkg.g_ele_start_date)) OR
       (hr_pay_interface_pkg.g_ele_start_date IS NULL) THEN
      hr_pay_interface_pkg.g_ele_start_date := NULL;
      hr_pay_interface_pkg.g_ele_person_id := NULL;
      return;
    END IF;

    /* Initialise the variables to ensure the triggers work */
    --
    l_business_group_id :=
      hr_pay_interface_pkg.g_element_entry_rec_var.business_group_id;
    l_payroll_id := hr_pay_interface_pkg.g_element_entry_rec_var.payroll_id;
    l_legislation_code := pay_core_utils.get_legislation_code(
      p_bg_id => l_business_group_id);
    --
    -- Check if the cursor is enabled
    --
    OPEN csr_get_event_id;
      FETCH csr_get_event_id INTO l_event_id;
    CLOSE csr_get_event_id ;
    IF paywsfgt_pkg.trigger_is_not_enabled(
      p_event_id          => l_event_id,
      p_legislation_code  => l_legislation_code,
      p_business_group_id => l_business_group_id,
      p_payroll_id        => l_payroll_id
      ) THEN
      RETURN;
    END IF;
    /* If the procedure hasn't exited at this point, run the trigger code*/
    --
    hr_pay_interface_pkg.disable_ele_entry_delete;
    --
  END IF;
END hr_pay_if_ele_ent_asd;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_ELE_ENT_ASD" ENABLE;
