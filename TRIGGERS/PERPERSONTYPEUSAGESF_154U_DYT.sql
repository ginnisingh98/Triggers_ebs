--------------------------------------------------------
--  DDL for Trigger PERPERSONTYPEUSAGESF_154U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERPERSONTYPEUSAGESF_154U_DYT" AFTER UPDATE ON "HR"."PER_PERSON_TYPE_USAGES_F" FOR EACH ROW DECLARE 
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
    Action: Update
    Date:   04/01/2007 09:50
    Name:   PER_PERSON_TYPE_USAGES_F_ARU
    Info.:  Incident Register trigger on update of person type usages
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
    p_statement                    => 'select business_group_id from per_all_people_f where person_id = '||:new.person_id||' and fnd_date.charDT_to_date('''||fnd_date.date_to_charDT(:new.effective_start_date) || ''') between effective_start_date and effective_end_date'
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 154,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_misc_dyt_incident_pkg.per_person_type_usages_f_aru(
    p_business_group_id            => l_business_group_id,
    p_effective_date               => :new.effective_start_date,
    p_legislation_code             => l_legislation_code,
    p_new_attribute1               => :new.attribute1,
    p_new_attribute10              => :new.attribute10,
    p_new_attribute11              => :new.attribute11,
    p_new_attribute12              => :new.attribute12,
    p_new_attribute13              => :new.attribute13,
    p_new_attribute14              => :new.attribute14,
    p_new_attribute15              => :new.attribute15,
    p_new_attribute16              => :new.attribute16,
    p_new_attribute17              => :new.attribute17,
    p_new_attribute18              => :new.attribute18,
    p_new_attribute19              => :new.attribute19,
    p_new_attribute2               => :new.attribute2,
    p_new_attribute20              => :new.attribute20,
    p_new_attribute3               => :new.attribute3,
    p_new_attribute4               => :new.attribute4,
    p_new_attribute5               => :new.attribute5,
    p_new_attribute6               => :new.attribute6,
    p_new_attribute7               => :new.attribute7,
    p_new_attribute8               => :new.attribute8,
    p_new_attribute9               => :new.attribute9,
    p_new_attribute_category       => :new.attribute_category,
    p_new_effective_end_date       => :new.effective_end_date,
    p_new_effective_start_date     => :new.effective_start_date,
    p_new_person_id                => :new.person_id,
    p_new_person_type_id           => :new.person_type_id,
    p_new_person_type_usage_id     => :new.person_type_usage_id,
    p_new_program_application_id   => :new.program_application_id,
    p_new_program_id               => :new.program_id,
    p_new_program_update_date      => :new.program_update_date,
    p_new_request_id               => :new.request_id,
    p_old_attribute1               => :old.attribute1,
    p_old_attribute10              => :old.attribute10,
    p_old_attribute11              => :old.attribute11,
    p_old_attribute12              => :old.attribute12,
    p_old_attribute13              => :old.attribute13,
    p_old_attribute14              => :old.attribute14,
    p_old_attribute15              => :old.attribute15,
    p_old_attribute16              => :old.attribute16,
    p_old_attribute17              => :old.attribute17,
    p_old_attribute18              => :old.attribute18,
    p_old_attribute19              => :old.attribute19,
    p_old_attribute2               => :old.attribute2,
    p_old_attribute20              => :old.attribute20,
    p_old_attribute3               => :old.attribute3,
    p_old_attribute4               => :old.attribute4,
    p_old_attribute5               => :old.attribute5,
    p_old_attribute6               => :old.attribute6,
    p_old_attribute7               => :old.attribute7,
    p_old_attribute8               => :old.attribute8,
    p_old_attribute9               => :old.attribute9,
    p_old_attribute_category       => :old.attribute_category,
    p_old_effective_end_date       => :old.effective_end_date,
    p_old_effective_start_date     => :old.effective_start_date,
    p_old_person_id                => :old.person_id,
    p_old_person_type_id           => :old.person_type_id,
    p_old_person_type_usage_id     => :old.person_type_usage_id,
    p_old_program_application_id   => :old.program_application_id,
    p_old_program_id               => :old.program_id,
    p_old_program_update_date      => :old.program_update_date,
    p_old_request_id               => :old.request_id
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
    hr_utility.set_location('PERPERSONTYPEUSAGESF_154U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;



/
ALTER TRIGGER "APPS"."PERPERSONTYPEUSAGESF_154U_DYT" ENABLE;
