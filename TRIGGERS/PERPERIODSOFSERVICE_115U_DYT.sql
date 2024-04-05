--------------------------------------------------------
--  DDL for Trigger PERPERIODSOFSERVICE_115U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERPERIODSOFSERVICE_115U_DYT" AFTER UPDATE ON "HR"."PER_PERIODS_OF_SERVICE" FOR EACH ROW DECLARE 
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
    Table:  PER_PERIODS_OF_SERVICE
    Action: Update
    Date:   29/08/2013 22:02
    Name:   PER_PERIODS_OF_SERVICE_ARU
    Info.:  Incident Register trigger on update of PER_PERIODS_OF_SERVICE
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
    p_event_id          => 115,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_continuous_calc.PER_PERIODS_OF_SERVICE_aru(
    p_business_group_id            => l_business_group_id,
    p_effective_date               => :new.DATE_START,
    p_legislation_code             => l_legislation_code,
    p_new_ACCEPTED_TERMINATION_DAT => :new.ACCEPTED_TERMINATION_DATE,
    p_new_ACTUAL_TERMINATION_DATE  => :new.ACTUAL_TERMINATION_DATE,
    p_new_ADJUSTED_SVC_DATE        => :new.ADJUSTED_SVC_DATE,
    p_new_ATTRIBUTE1               => :new.ATTRIBUTE1,
    p_new_ATTRIBUTE10              => :new.ATTRIBUTE10,
    p_new_ATTRIBUTE11              => :new.ATTRIBUTE11,
    p_new_ATTRIBUTE12              => :new.ATTRIBUTE12,
    p_new_ATTRIBUTE13              => :new.ATTRIBUTE13,
    p_new_ATTRIBUTE14              => :new.ATTRIBUTE14,
    p_new_ATTRIBUTE15              => :new.ATTRIBUTE15,
    p_new_ATTRIBUTE16              => :new.ATTRIBUTE16,
    p_new_ATTRIBUTE17              => :new.ATTRIBUTE17,
    p_new_ATTRIBUTE18              => :new.ATTRIBUTE18,
    p_new_ATTRIBUTE19              => :new.ATTRIBUTE19,
    p_new_ATTRIBUTE2               => :new.ATTRIBUTE2,
    p_new_ATTRIBUTE20              => :new.ATTRIBUTE20,
    p_new_ATTRIBUTE3               => :new.ATTRIBUTE3,
    p_new_ATTRIBUTE4               => :new.ATTRIBUTE4,
    p_new_ATTRIBUTE5               => :new.ATTRIBUTE5,
    p_new_ATTRIBUTE6               => :new.ATTRIBUTE6,
    p_new_ATTRIBUTE7               => :new.ATTRIBUTE7,
    p_new_ATTRIBUTE8               => :new.ATTRIBUTE8,
    p_new_ATTRIBUTE9               => :new.ATTRIBUTE9,
    p_new_ATTRIBUTE_CATEGORY       => :new.ATTRIBUTE_CATEGORY,
    p_new_BUSINESS_GROUP_ID        => :new.BUSINESS_GROUP_ID,
    p_new_DATE_START               => :new.DATE_START,
    p_new_FINAL_PROCESS_DATE       => :new.FINAL_PROCESS_DATE,
    p_new_LAST_STANDARD_PROCESS_DA => :new.LAST_STANDARD_PROCESS_DATE,
    p_new_LEAVING_REASON           => :new.LEAVING_REASON,
    p_new_NOTIFIED_TERMINATION_DAT => :new.NOTIFIED_TERMINATION_DATE,
    p_new_PDS_INFORMATION1         => :new.PDS_INFORMATION1,
    p_new_PDS_INFORMATION10        => :new.PDS_INFORMATION10,
    p_new_PDS_INFORMATION11        => :new.PDS_INFORMATION11,
    p_new_PDS_INFORMATION12        => :new.PDS_INFORMATION12,
    p_new_PDS_INFORMATION13        => :new.PDS_INFORMATION13,
    p_new_PDS_INFORMATION14        => :new.PDS_INFORMATION14,
    p_new_PDS_INFORMATION15        => :new.PDS_INFORMATION15,
    p_new_PDS_INFORMATION16        => :new.PDS_INFORMATION16,
    p_new_PDS_INFORMATION17        => :new.PDS_INFORMATION17,
    p_new_PDS_INFORMATION18        => :new.PDS_INFORMATION18,
    p_new_PDS_INFORMATION19        => :new.PDS_INFORMATION19,
    p_new_PDS_INFORMATION2         => :new.PDS_INFORMATION2,
    p_new_PDS_INFORMATION20        => :new.PDS_INFORMATION20,
    p_new_PDS_INFORMATION21        => :new.PDS_INFORMATION21,
    p_new_PDS_INFORMATION22        => :new.PDS_INFORMATION22,
    p_new_PDS_INFORMATION23        => :new.PDS_INFORMATION23,
    p_new_PDS_INFORMATION24        => :new.PDS_INFORMATION24,
    p_new_PDS_INFORMATION25        => :new.PDS_INFORMATION25,
    p_new_PDS_INFORMATION26        => :new.PDS_INFORMATION26,
    p_new_PDS_INFORMATION27        => :new.PDS_INFORMATION27,
    p_new_PDS_INFORMATION28        => :new.PDS_INFORMATION28,
    p_new_PDS_INFORMATION29        => :new.PDS_INFORMATION29,
    p_new_PDS_INFORMATION3         => :new.PDS_INFORMATION3,
    p_new_PDS_INFORMATION30        => :new.PDS_INFORMATION30,
    p_new_PDS_INFORMATION4         => :new.PDS_INFORMATION4,
    p_new_PDS_INFORMATION5         => :new.PDS_INFORMATION5,
    p_new_PDS_INFORMATION6         => :new.PDS_INFORMATION6,
    p_new_PDS_INFORMATION7         => :new.PDS_INFORMATION7,
    p_new_PDS_INFORMATION8         => :new.PDS_INFORMATION8,
    p_new_PDS_INFORMATION9         => :new.PDS_INFORMATION9,
    p_new_PDS_INFORMATION_CATEGORY => :new.PDS_INFORMATION_CATEGORY,
    p_new_PERIOD_OF_SERVICE_ID     => :new.PERIOD_OF_SERVICE_ID,
    p_new_PERSON_ID                => :new.PERSON_ID,
    p_new_PRIOR_EMPLOYMENT_SSP_PAI => :new.PRIOR_EMPLOYMENT_SSP_PAID_TO,
    p_new_PRIOR_EMPLOYMENT_SSP_WEE => :new.PRIOR_EMPLOYMENT_SSP_WEEKS,
    p_new_PROGRAM_APPLICATION_ID   => :new.PROGRAM_APPLICATION_ID,
    p_new_PROGRAM_ID               => :new.PROGRAM_ID,
    p_new_PROGRAM_UPDATE_DATE      => :new.PROGRAM_UPDATE_DATE,
    p_new_PROJECTED_TERMINATION_DA => :new.PROJECTED_TERMINATION_DATE,
    p_new_REQUEST_ID               => :new.REQUEST_ID,
    p_new_TERMINATION_ACCEPTED_PER => :new.TERMINATION_ACCEPTED_PERSON_ID,
    p_old_ACCEPTED_TERMINATION_DAT => :old.ACCEPTED_TERMINATION_DATE,
    p_old_ACTUAL_TERMINATION_DATE  => :old.ACTUAL_TERMINATION_DATE,
    p_old_ADJUSTED_SVC_DATE        => :old.ADJUSTED_SVC_DATE,
    p_old_ATTRIBUTE1               => :old.ATTRIBUTE1,
    p_old_ATTRIBUTE10              => :old.ATTRIBUTE10,
    p_old_ATTRIBUTE11              => :old.ATTRIBUTE11,
    p_old_ATTRIBUTE12              => :old.ATTRIBUTE12,
    p_old_ATTRIBUTE13              => :old.ATTRIBUTE13,
    p_old_ATTRIBUTE14              => :old.ATTRIBUTE14,
    p_old_ATTRIBUTE15              => :old.ATTRIBUTE15,
    p_old_ATTRIBUTE16              => :old.ATTRIBUTE16,
    p_old_ATTRIBUTE17              => :old.ATTRIBUTE17,
    p_old_ATTRIBUTE18              => :old.ATTRIBUTE18,
    p_old_ATTRIBUTE19              => :old.ATTRIBUTE19,
    p_old_ATTRIBUTE2               => :old.ATTRIBUTE2,
    p_old_ATTRIBUTE20              => :old.ATTRIBUTE20,
    p_old_ATTRIBUTE3               => :old.ATTRIBUTE3,
    p_old_ATTRIBUTE4               => :old.ATTRIBUTE4,
    p_old_ATTRIBUTE5               => :old.ATTRIBUTE5,
    p_old_ATTRIBUTE6               => :old.ATTRIBUTE6,
    p_old_ATTRIBUTE7               => :old.ATTRIBUTE7,
    p_old_ATTRIBUTE8               => :old.ATTRIBUTE8,
    p_old_ATTRIBUTE9               => :old.ATTRIBUTE9,
    p_old_ATTRIBUTE_CATEGORY       => :old.ATTRIBUTE_CATEGORY,
    p_old_BUSINESS_GROUP_ID        => :old.BUSINESS_GROUP_ID,
    p_old_DATE_START               => :old.DATE_START,
    p_old_FINAL_PROCESS_DATE       => :old.FINAL_PROCESS_DATE,
    p_old_LAST_STANDARD_PROCESS_DA => :old.LAST_STANDARD_PROCESS_DATE,
    p_old_LEAVING_REASON           => :old.LEAVING_REASON,
    p_old_NOTIFIED_TERMINATION_DAT => :old.NOTIFIED_TERMINATION_DATE,
    p_old_PDS_INFORMATION1         => :old.PDS_INFORMATION1,
    p_old_PDS_INFORMATION10        => :old.PDS_INFORMATION10,
    p_old_PDS_INFORMATION11        => :old.PDS_INFORMATION11,
    p_old_PDS_INFORMATION12        => :old.PDS_INFORMATION12,
    p_old_PDS_INFORMATION13        => :old.PDS_INFORMATION13,
    p_old_PDS_INFORMATION14        => :old.PDS_INFORMATION14,
    p_old_PDS_INFORMATION15        => :old.PDS_INFORMATION15,
    p_old_PDS_INFORMATION16        => :old.PDS_INFORMATION16,
    p_old_PDS_INFORMATION17        => :old.PDS_INFORMATION17,
    p_old_PDS_INFORMATION18        => :old.PDS_INFORMATION18,
    p_old_PDS_INFORMATION19        => :old.PDS_INFORMATION19,
    p_old_PDS_INFORMATION2         => :old.PDS_INFORMATION2,
    p_old_PDS_INFORMATION20        => :old.PDS_INFORMATION20,
    p_old_PDS_INFORMATION21        => :old.PDS_INFORMATION21,
    p_old_PDS_INFORMATION22        => :old.PDS_INFORMATION22,
    p_old_PDS_INFORMATION23        => :old.PDS_INFORMATION23,
    p_old_PDS_INFORMATION24        => :old.PDS_INFORMATION24,
    p_old_PDS_INFORMATION25        => :old.PDS_INFORMATION25,
    p_old_PDS_INFORMATION26        => :old.PDS_INFORMATION26,
    p_old_PDS_INFORMATION27        => :old.PDS_INFORMATION27,
    p_old_PDS_INFORMATION28        => :old.PDS_INFORMATION28,
    p_old_PDS_INFORMATION29        => :old.PDS_INFORMATION29,
    p_old_PDS_INFORMATION3         => :old.PDS_INFORMATION3,
    p_old_PDS_INFORMATION30        => :old.PDS_INFORMATION30,
    p_old_PDS_INFORMATION4         => :old.PDS_INFORMATION4,
    p_old_PDS_INFORMATION5         => :old.PDS_INFORMATION5,
    p_old_PDS_INFORMATION6         => :old.PDS_INFORMATION6,
    p_old_PDS_INFORMATION7         => :old.PDS_INFORMATION7,
    p_old_PDS_INFORMATION8         => :old.PDS_INFORMATION8,
    p_old_PDS_INFORMATION9         => :old.PDS_INFORMATION9,
    p_old_PDS_INFORMATION_CATEGORY => :old.PDS_INFORMATION_CATEGORY,
    p_old_PERIOD_OF_SERVICE_ID     => :old.PERIOD_OF_SERVICE_ID,
    p_old_PERSON_ID                => :old.PERSON_ID,
    p_old_PRIOR_EMPLOYMENT_SSP_PAI => :old.PRIOR_EMPLOYMENT_SSP_PAID_TO,
    p_old_PRIOR_EMPLOYMENT_SSP_WEE => :old.PRIOR_EMPLOYMENT_SSP_WEEKS,
    p_old_PROGRAM_APPLICATION_ID   => :old.PROGRAM_APPLICATION_ID,
    p_old_PROGRAM_ID               => :old.PROGRAM_ID,
    p_old_PROGRAM_UPDATE_DATE      => :old.PROGRAM_UPDATE_DATE,
    p_old_PROJECTED_TERMINATION_DA => :old.PROJECTED_TERMINATION_DATE,
    p_old_REQUEST_ID               => :old.REQUEST_ID,
    p_old_TERMINATION_ACCEPTED_PER => :old.TERMINATION_ACCEPTED_PERSON_ID
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
    hr_utility.set_location('PERPERIODSOFSERVICE_115U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERPERIODSOFSERVICE_115U_DYT" ENABLE;
