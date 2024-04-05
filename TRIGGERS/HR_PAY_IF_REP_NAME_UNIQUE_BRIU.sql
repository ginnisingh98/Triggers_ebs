--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_REP_NAME_UNIQUE_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_REP_NAME_UNIQUE_BRIU" 
before insert or update of reporting_name
on "HR"."PAY_ELEMENT_TYPES_F" for each row
declare
 /* declare the cursors */
 CURSOR csr_get_event_id IS
 SELECT event_id
 FROM pay_trigger_events
 WHERE short_name = 'HR_PAY_IF_REP_NAME_UNIQUE_BRIU';
 --
 l_event_id   NUMBER;
 l_business_group_id NUMBER;
 l_legislation_code VARCHAR2(10);
begin
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
    -- Need to set these before enabled test to ensure that the table level
    -- trigger can access them.

    hr_pay_interface_pkg.g_reporting_details_rec_var.business_group_id
      := :new.business_group_id;
    hr_pay_interface_pkg.g_reporting_details_rec_var.legislation_code
      := :new.legislation_code;
    --
    /* Initialise the variables to ensure the triggers work */
    l_business_group_id :=:new.business_group_id;
    --
    l_legislation_code := :new.legislation_code;
    --
    OPEN csr_get_event_id;
    FETCH csr_get_event_id INTO l_event_id;
    CLOSE csr_get_event_id ;
    IF paywsfgt_pkg.trigger_is_not_enabled(
      p_event_id          => l_event_id,
      p_legislation_code  => l_legislation_code,
      p_business_group_id => l_business_group_id,
      p_payroll_id        => NULL
    ) THEN
      RETURN;
    END IF;

    /* If the procedure hasn't exited at this point, run the trigger code*/

    hr_pay_interface_pkg.g_reporting_details_rec_var.reporting_name
      :=  :new.reporting_name;
    hr_pay_interface_pkg.g_reporting_details_rec_var.element_type_id
      := :new.element_type_id;
    hr_pay_interface_pkg.g_reporting_details_rec_var.effective_start_date
      := :new.effective_start_date;
    hr_pay_interface_pkg.g_reporting_details_rec_var.effective_end_date
      := :new.effective_end_date;
  END IF;
end HR_PAY_IF_REP_NAME_UNIQUE_BRIU;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_REP_NAME_UNIQUE_BRIU" ENABLE;
