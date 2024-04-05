--------------------------------------------------------
--  DDL for Trigger PERASSIGNMENTEXTRAINF_136U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERASSIGNMENTEXTRAINF_136U_DYT" AFTER UPDATE ON "HR"."PER_ASSIGNMENT_EXTRA_INFO" FOR EACH ROW DECLARE 
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
    Table:  PER_ASSIGNMENT_EXTRA_INFO
    Action: Update
    Date:   04/01/2007 09:49
    Name:   PER_ASSIGNMENT_EXTRA_INFO_ARU
    Info.:  Continuous Calculation trigger for PER_ASSIGNMENT_EXTRA_INFO
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
    p_statement                    => 'select distinct business_group_id from per_all_assignments_f where assignment_id = '||:new.assignment_id
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 136,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_misc_dyt_incident_pkg.per_assignment_extra_info_aru(
    p_business_group_id            => l_business_group_id,
    p_effective_date               => to_date('0001/01/01', 'YYYY/MM/DD'),
    p_legislation_code             => l_legislation_code,
    p_new_AEI_ATTRIBUTE1           => :new.AEI_ATTRIBUTE1,
    p_new_AEI_ATTRIBUTE10          => :new.AEI_ATTRIBUTE10,
    p_new_AEI_ATTRIBUTE11          => :new.AEI_ATTRIBUTE11,
    p_new_AEI_ATTRIBUTE12          => :new.AEI_ATTRIBUTE12,
    p_new_AEI_ATTRIBUTE13          => :new.AEI_ATTRIBUTE13,
    p_new_AEI_ATTRIBUTE14          => :new.AEI_ATTRIBUTE14,
    p_new_AEI_ATTRIBUTE15          => :new.AEI_ATTRIBUTE15,
    p_new_AEI_ATTRIBUTE16          => :new.AEI_ATTRIBUTE16,
    p_new_AEI_ATTRIBUTE17          => :new.AEI_ATTRIBUTE17,
    p_new_AEI_ATTRIBUTE18          => :new.AEI_ATTRIBUTE18,
    p_new_AEI_ATTRIBUTE19          => :new.AEI_ATTRIBUTE19,
    p_new_AEI_ATTRIBUTE2           => :new.AEI_ATTRIBUTE2,
    p_new_AEI_ATTRIBUTE20          => :new.AEI_ATTRIBUTE20,
    p_new_AEI_ATTRIBUTE3           => :new.AEI_ATTRIBUTE3,
    p_new_AEI_ATTRIBUTE4           => :new.AEI_ATTRIBUTE4,
    p_new_AEI_ATTRIBUTE5           => :new.AEI_ATTRIBUTE5,
    p_new_AEI_ATTRIBUTE6           => :new.AEI_ATTRIBUTE6,
    p_new_AEI_ATTRIBUTE7           => :new.AEI_ATTRIBUTE7,
    p_new_AEI_ATTRIBUTE8           => :new.AEI_ATTRIBUTE8,
    p_new_AEI_ATTRIBUTE9           => :new.AEI_ATTRIBUTE9,
    p_new_AEI_ATTRIBUTE_CATEGORY   => :new.AEI_ATTRIBUTE_CATEGORY,
    p_new_AEI_INFORMATION1         => :new.AEI_INFORMATION1,
    p_new_AEI_INFORMATION10        => :new.AEI_INFORMATION10,
    p_new_AEI_INFORMATION11        => :new.AEI_INFORMATION11,
    p_new_AEI_INFORMATION12        => :new.AEI_INFORMATION12,
    p_new_AEI_INFORMATION13        => :new.AEI_INFORMATION13,
    p_new_AEI_INFORMATION14        => :new.AEI_INFORMATION14,
    p_new_AEI_INFORMATION15        => :new.AEI_INFORMATION15,
    p_new_AEI_INFORMATION16        => :new.AEI_INFORMATION16,
    p_new_AEI_INFORMATION17        => :new.AEI_INFORMATION17,
    p_new_AEI_INFORMATION18        => :new.AEI_INFORMATION18,
    p_new_AEI_INFORMATION19        => :new.AEI_INFORMATION19,
    p_new_AEI_INFORMATION2         => :new.AEI_INFORMATION2,
    p_new_AEI_INFORMATION20        => :new.AEI_INFORMATION20,
    p_new_AEI_INFORMATION21        => :new.AEI_INFORMATION21,
    p_new_AEI_INFORMATION22        => :new.AEI_INFORMATION22,
    p_new_AEI_INFORMATION23        => :new.AEI_INFORMATION23,
    p_new_AEI_INFORMATION24        => :new.AEI_INFORMATION24,
    p_new_AEI_INFORMATION25        => :new.AEI_INFORMATION25,
    p_new_AEI_INFORMATION26        => :new.AEI_INFORMATION26,
    p_new_AEI_INFORMATION27        => :new.AEI_INFORMATION27,
    p_new_AEI_INFORMATION28        => :new.AEI_INFORMATION28,
    p_new_AEI_INFORMATION29        => :new.AEI_INFORMATION29,
    p_new_AEI_INFORMATION3         => :new.AEI_INFORMATION3,
    p_new_AEI_INFORMATION30        => :new.AEI_INFORMATION30,
    p_new_AEI_INFORMATION4         => :new.AEI_INFORMATION4,
    p_new_AEI_INFORMATION5         => :new.AEI_INFORMATION5,
    p_new_AEI_INFORMATION6         => :new.AEI_INFORMATION6,
    p_new_AEI_INFORMATION7         => :new.AEI_INFORMATION7,
    p_new_AEI_INFORMATION8         => :new.AEI_INFORMATION8,
    p_new_AEI_INFORMATION9         => :new.AEI_INFORMATION9,
    p_new_AEI_INFORMATION_CATEGORY => :new.AEI_INFORMATION_CATEGORY,
    p_new_ASSIGNMENT_EXTRA_INFO_ID => :new.ASSIGNMENT_EXTRA_INFO_ID,
    p_new_ASSIGNMENT_ID            => :new.ASSIGNMENT_ID,
    p_new_INFORMATION_TYPE         => :new.INFORMATION_TYPE,
    p_old_AEI_ATTRIBUTE1           => :old.AEI_ATTRIBUTE1,
    p_old_AEI_ATTRIBUTE10          => :old.AEI_ATTRIBUTE10,
    p_old_AEI_ATTRIBUTE11          => :old.AEI_ATTRIBUTE11,
    p_old_AEI_ATTRIBUTE12          => :old.AEI_ATTRIBUTE12,
    p_old_AEI_ATTRIBUTE13          => :old.AEI_ATTRIBUTE13,
    p_old_AEI_ATTRIBUTE14          => :old.AEI_ATTRIBUTE14,
    p_old_AEI_ATTRIBUTE15          => :old.AEI_ATTRIBUTE15,
    p_old_AEI_ATTRIBUTE16          => :old.AEI_ATTRIBUTE16,
    p_old_AEI_ATTRIBUTE17          => :old.AEI_ATTRIBUTE17,
    p_old_AEI_ATTRIBUTE18          => :old.AEI_ATTRIBUTE18,
    p_old_AEI_ATTRIBUTE19          => :old.AEI_ATTRIBUTE19,
    p_old_AEI_ATTRIBUTE2           => :old.AEI_ATTRIBUTE2,
    p_old_AEI_ATTRIBUTE20          => :old.AEI_ATTRIBUTE20,
    p_old_AEI_ATTRIBUTE3           => :old.AEI_ATTRIBUTE3,
    p_old_AEI_ATTRIBUTE4           => :old.AEI_ATTRIBUTE4,
    p_old_AEI_ATTRIBUTE5           => :old.AEI_ATTRIBUTE5,
    p_old_AEI_ATTRIBUTE6           => :old.AEI_ATTRIBUTE6,
    p_old_AEI_ATTRIBUTE7           => :old.AEI_ATTRIBUTE7,
    p_old_AEI_ATTRIBUTE8           => :old.AEI_ATTRIBUTE8,
    p_old_AEI_ATTRIBUTE9           => :old.AEI_ATTRIBUTE9,
    p_old_AEI_ATTRIBUTE_CATEGORY   => :old.AEI_ATTRIBUTE_CATEGORY,
    p_old_AEI_INFORMATION1         => :old.AEI_INFORMATION1,
    p_old_AEI_INFORMATION10        => :old.AEI_INFORMATION10,
    p_old_AEI_INFORMATION11        => :old.AEI_INFORMATION11,
    p_old_AEI_INFORMATION12        => :old.AEI_INFORMATION12,
    p_old_AEI_INFORMATION13        => :old.AEI_INFORMATION13,
    p_old_AEI_INFORMATION14        => :old.AEI_INFORMATION14,
    p_old_AEI_INFORMATION15        => :old.AEI_INFORMATION15,
    p_old_AEI_INFORMATION16        => :old.AEI_INFORMATION16,
    p_old_AEI_INFORMATION17        => :old.AEI_INFORMATION17,
    p_old_AEI_INFORMATION18        => :old.AEI_INFORMATION18,
    p_old_AEI_INFORMATION19        => :old.AEI_INFORMATION19,
    p_old_AEI_INFORMATION2         => :old.AEI_INFORMATION2,
    p_old_AEI_INFORMATION20        => :old.AEI_INFORMATION20,
    p_old_AEI_INFORMATION21        => :old.AEI_INFORMATION21,
    p_old_AEI_INFORMATION22        => :old.AEI_INFORMATION22,
    p_old_AEI_INFORMATION23        => :old.AEI_INFORMATION23,
    p_old_AEI_INFORMATION24        => :old.AEI_INFORMATION24,
    p_old_AEI_INFORMATION25        => :old.AEI_INFORMATION25,
    p_old_AEI_INFORMATION26        => :old.AEI_INFORMATION26,
    p_old_AEI_INFORMATION27        => :old.AEI_INFORMATION27,
    p_old_AEI_INFORMATION28        => :old.AEI_INFORMATION28,
    p_old_AEI_INFORMATION29        => :old.AEI_INFORMATION29,
    p_old_AEI_INFORMATION3         => :old.AEI_INFORMATION3,
    p_old_AEI_INFORMATION30        => :old.AEI_INFORMATION30,
    p_old_AEI_INFORMATION4         => :old.AEI_INFORMATION4,
    p_old_AEI_INFORMATION5         => :old.AEI_INFORMATION5,
    p_old_AEI_INFORMATION6         => :old.AEI_INFORMATION6,
    p_old_AEI_INFORMATION7         => :old.AEI_INFORMATION7,
    p_old_AEI_INFORMATION8         => :old.AEI_INFORMATION8,
    p_old_AEI_INFORMATION9         => :old.AEI_INFORMATION9,
    p_old_AEI_INFORMATION_CATEGORY => :old.AEI_INFORMATION_CATEGORY,
    p_old_ASSIGNMENT_EXTRA_INFO_ID => :old.ASSIGNMENT_EXTRA_INFO_ID,
    p_old_ASSIGNMENT_ID            => :old.ASSIGNMENT_ID,
    p_old_INFORMATION_TYPE         => :old.INFORMATION_TYPE
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
    hr_utility.set_location('PERASSIGNMENTEXTRAINF_136U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;



/
ALTER TRIGGER "APPS"."PERASSIGNMENTEXTRAINF_136U_DYT" ENABLE;
