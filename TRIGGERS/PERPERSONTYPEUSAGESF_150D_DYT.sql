--------------------------------------------------------
--  DDL for Trigger PERPERSONTYPEUSAGESF_150D_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERPERSONTYPEUSAGESF_150D_DYT" AFTER DELETE ON "HR"."PER_PERSON_TYPE_USAGES_F" FOR EACH ROW DECLARE 
  /* Local variable declarations */
  l_business_group_id            NUMBER;
  l_legislation_code             VARCHAR2(10);
  l_mode  varchar2(80);

--
BEGIN
/*
  ================================================
  This is a dynamically generated database trigger
  ================================================
            ** DO NOT CHANGE MANUALLY **          
  ------------------------------------------------
    Table:  PER_PERSON_TYPE_USAGES_F
    Action: Delete
    Date:   04/01/2007 09:50
    Name:   PER_PERSON_TYPE_USAGES_F_ARD
    Info.:  Incident Register trigger on deletion of person type usage
  ================================================
*/
--
  l_mode := pay_dyn_triggers.g_dyt_mode;
  pay_dyn_triggers.g_dyt_mode := pay_dyn_triggers.g_dbms_dyt;
IF NOT (hr_general.g_data_migrator_mode <> 'Y') THEN
  RETURN;
END IF;
  /* Initialising local variables */
  l_business_group_id := pay_core_utils.get_business_group(
    p_statement                    => 'select business_group_id from per_all_people_f where person_id = '||:old.person_id||' and fnd_date.charDT_to_date('''||fnd_date.date_to_charDT(:old.effective_start_date) || ''') between effective_start_date and effective_end_date'
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 150,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_misc_dyt_incident_pkg.per_person_type_usages_f_ard(
    p_business_group_id            => l_business_group_id,
    p_effective_start_date         => :old.effective_start_date,
    p_legislation_code             => l_legislation_code,
    p_person_id                    => :old.person_id,
    p_person_type_usage_id         => :old.person_type_usage_id
  );
  --
  /* Legislation specific component calls */
  --
  /* Business group specific component calls */
  --
  /* Payroll specific component calls */
  --
  pay_dyn_triggers.g_dyt_mode := l_mode;
EXCEPTION
  WHEN OTHERS THEN
    hr_utility.set_location('PERPERSONTYPEUSAGESF_150D_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;



/
ALTER TRIGGER "APPS"."PERPERSONTYPEUSAGESF_150D_DYT" ENABLE;
