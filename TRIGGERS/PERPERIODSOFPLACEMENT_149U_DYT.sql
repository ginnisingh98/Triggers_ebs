--------------------------------------------------------
--  DDL for Trigger PERPERIODSOFPLACEMENT_149U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERPERIODSOFPLACEMENT_149U_DYT" AFTER UPDATE ON "HR"."PER_PERIODS_OF_PLACEMENT" FOR EACH ROW DECLARE 
  /* Local variable declarations */
  l_business_group_id            NUMBER;
  l_legislation_code             VARCHAR2(30);
  l_mode  varchar2(80);

--
BEGIN
/*
  ================================================
  This is a dynamically generated database trigger
  ================================================
            ** DO NOT CHANGE MANUALLY **          
  ------------------------------------------------
    Table:  PER_PERIODS_OF_PLACEMENT
    Action: Update
    Date:   04/01/2007 09:50
    Name:   PER_PERIODS_OF_PLACEMENT_ARU
    Info.:  Incident Register trigger on update of PER_PERIODS_OF_PLACEMENT
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
    p_statement                    => 'select '||:new.business_group_id||' from sys.dual'
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 149,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_misc_dyt_incident_pkg.per_periods_of_placement_aru(
    p_business_group_id            => l_business_group_id,
    p_effective_date               => :new.DATE_START,
    p_legislation_code             => l_legislation_code,
    p_new_actual_termination_date  => :new.actual_termination_date,
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
    p_new_attribute21              => :new.attribute21,
    p_new_attribute22              => :new.attribute22,
    p_new_attribute23              => :new.attribute23,
    p_new_attribute24              => :new.attribute24,
    p_new_attribute25              => :new.attribute25,
    p_new_attribute26              => :new.attribute26,
    p_new_attribute27              => :new.attribute27,
    p_new_attribute28              => :new.attribute28,
    p_new_attribute29              => :new.attribute29,
    p_new_attribute3               => :new.attribute3,
    p_new_attribute30              => :new.attribute30,
    p_new_attribute4               => :new.attribute4,
    p_new_attribute5               => :new.attribute5,
    p_new_attribute6               => :new.attribute6,
    p_new_attribute7               => :new.attribute7,
    p_new_attribute8               => :new.attribute8,
    p_new_attribute9               => :new.attribute9,
    p_new_attribute_category       => :new.attribute_category,
    p_new_business_group_id        => :new.business_group_id,
    p_new_date_start               => :new.date_start,
    p_new_final_process_date       => :new.final_process_date,
    p_new_information1             => :new.information1,
    p_new_information10            => :new.information10,
    p_new_information11            => :new.information11,
    p_new_information12            => :new.information12,
    p_new_information13            => :new.information13,
    p_new_information14            => :new.information14,
    p_new_information15            => :new.information15,
    p_new_information16            => :new.information16,
    p_new_information17            => :new.information17,
    p_new_information18            => :new.information18,
    p_new_information19            => :new.information19,
    p_new_information2             => :new.information2,
    p_new_information20            => :new.information20,
    p_new_information21            => :new.information21,
    p_new_information22            => :new.information22,
    p_new_information23            => :new.information23,
    p_new_information24            => :new.information24,
    p_new_information25            => :new.information25,
    p_new_information26            => :new.information26,
    p_new_information27            => :new.information27,
    p_new_information28            => :new.information28,
    p_new_information29            => :new.information29,
    p_new_information3             => :new.information3,
    p_new_information30            => :new.information30,
    p_new_information4             => :new.information4,
    p_new_information5             => :new.information5,
    p_new_information6             => :new.information6,
    p_new_information7             => :new.information7,
    p_new_information8             => :new.information8,
    p_new_information9             => :new.information9,
    p_new_information_category     => :new.information_category,
    p_new_last_standard_process_da => :new.last_standard_process_date,
    p_new_period_of_placement_id   => :new.period_of_placement_id,
    p_new_person_id                => :new.person_id,
    p_new_projected_termination_da => :new.projected_termination_date,
    p_new_termination_reason       => :new.termination_reason,
    p_old_actual_termination_date  => :old.actual_termination_date,
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
    p_old_attribute21              => :old.attribute21,
    p_old_attribute22              => :old.attribute22,
    p_old_attribute23              => :old.attribute23,
    p_old_attribute24              => :old.attribute24,
    p_old_attribute25              => :old.attribute25,
    p_old_attribute26              => :old.attribute26,
    p_old_attribute27              => :old.attribute27,
    p_old_attribute28              => :old.attribute28,
    p_old_attribute29              => :old.attribute29,
    p_old_attribute3               => :old.attribute3,
    p_old_attribute30              => :old.attribute30,
    p_old_attribute4               => :old.attribute4,
    p_old_attribute5               => :old.attribute5,
    p_old_attribute6               => :old.attribute6,
    p_old_attribute7               => :old.attribute7,
    p_old_attribute8               => :old.attribute8,
    p_old_attribute9               => :old.attribute9,
    p_old_attribute_category       => :old.attribute_category,
    p_old_business_group_id        => :old.business_group_id,
    p_old_date_start               => :old.date_start,
    p_old_final_process_date       => :old.final_process_date,
    p_old_information1             => :old.information1,
    p_old_information10            => :old.information10,
    p_old_information11            => :old.information11,
    p_old_information12            => :old.information12,
    p_old_information13            => :old.information13,
    p_old_information14            => :old.information14,
    p_old_information15            => :old.information15,
    p_old_information16            => :old.information16,
    p_old_information17            => :old.information17,
    p_old_information18            => :old.information18,
    p_old_information19            => :old.information19,
    p_old_information2             => :old.information2,
    p_old_information20            => :old.information20,
    p_old_information21            => :old.information21,
    p_old_information22            => :old.information22,
    p_old_information23            => :old.information23,
    p_old_information24            => :old.information24,
    p_old_information25            => :old.information25,
    p_old_information26            => :old.information26,
    p_old_information27            => :old.information27,
    p_old_information28            => :old.information28,
    p_old_information29            => :old.information29,
    p_old_information3             => :old.information3,
    p_old_information30            => :old.information30,
    p_old_information4             => :old.information4,
    p_old_information5             => :old.information5,
    p_old_information6             => :old.information6,
    p_old_information7             => :old.information7,
    p_old_information8             => :old.information8,
    p_old_information9             => :old.information9,
    p_old_information_category     => :old.information_category,
    p_old_last_standard_process_da => :old.last_standard_process_date,
    p_old_period_of_placement_id   => :old.period_of_placement_id,
    p_old_person_id                => :old.person_id,
    p_old_projected_termination_da => :old.projected_termination_date,
    p_old_termination_reason       => :old.termination_reason
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
    hr_utility.set_location('PERPERIODSOFPLACEMENT_149U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;



/
ALTER TRIGGER "APPS"."PERPERIODSOFPLACEMENT_149U_DYT" ENABLE;
