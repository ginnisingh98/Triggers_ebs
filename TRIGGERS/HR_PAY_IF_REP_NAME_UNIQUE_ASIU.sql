--------------------------------------------------------
--  DDL for Trigger HR_PAY_IF_REP_NAME_UNIQUE_ASIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PAY_IF_REP_NAME_UNIQUE_ASIU" 
after insert or update OF reporting_name
on "HR"."PAY_ELEMENT_TYPES_F"
declare
 CURSOR csr_get_event_id IS
 SELECT event_id
 FROM pay_trigger_events
 WHERE short_name = 'HR_PAY_IF_REP_NAME_UNIQUE_ASIU';
 --
 l_event_id   NUMBER;
 l_business_group_id NUMBER;
 l_legislation_code VARCHAR2(10);
begin
  IF HR_GENERAL.g_data_migrator_mode <> 'Y' THEN
    l_business_group_id :=
    hr_pay_interface_pkg.g_reporting_details_rec_var.business_group_id;

    --
    l_legislation_code :=
    hr_pay_interface_pkg.g_reporting_details_rec_var.legislation_code;
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
    hr_pay_interface_pkg.chk_reporting_name_uniqueness;
  END IF;
end HR_PAY_IF_REP_NAME_UNIQUE_ASIU;


/
ALTER TRIGGER "APPS"."HR_PAY_IF_REP_NAME_UNIQUE_ASIU" ENABLE;
