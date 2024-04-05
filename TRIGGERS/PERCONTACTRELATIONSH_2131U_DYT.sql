--------------------------------------------------------
--  DDL for Trigger PERCONTACTRELATIONSH_2131U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERCONTACTRELATIONSH_2131U_DYT" AFTER UPDATE ON "HR"."PER_CONTACT_RELATIONSHIPS" FOR EACH ROW DECLARE 
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
    Table:  PER_CONTACT_RELATIONSHIPS
    Action: Update
    Date:   30/08/2013 11:37
    Name:   PER_CONTACT_RELATIONSHIPS_ARU
    Info.:  Continuous Calcuation trigger on update of PER_CONTACT_RELATIONSHIPS
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
    p_event_id          => 2131,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  PAY_CONTINUOUS_CALC.PER_CONTACT_RELATIONSHIPS_ARU(
    p_business_group_id            => l_business_group_id,
    p_effective_date               => :new.date_start,
    p_legislation_code             => l_legislation_code,
    p_new_BENEFICIARY_FLAG         => :new.BENEFICIARY_FLAG,
    p_new_BONDHOLDER_FLAG          => :new.BONDHOLDER_FLAG,
    p_new_BUSINESS_GROUP_ID        => :new.BUSINESS_GROUP_ID,
    p_new_CONTACT_PERSON_ID        => :new.CONTACT_PERSON_ID,
    p_new_CONTACT_RELATIONSHIP_ID  => :new.CONTACT_RELATIONSHIP_ID,
    p_new_CONTACT_TYPE             => :new.CONTACT_TYPE,
    p_new_CONT_ATTRIBUTE1          => :new.CONT_ATTRIBUTE1,
    p_new_CONT_ATTRIBUTE10         => :new.CONT_ATTRIBUTE10,
    p_new_CONT_ATTRIBUTE11         => :new.CONT_ATTRIBUTE11,
    p_new_CONT_ATTRIBUTE12         => :new.CONT_ATTRIBUTE12,
    p_new_CONT_ATTRIBUTE13         => :new.CONT_ATTRIBUTE13,
    p_new_CONT_ATTRIBUTE14         => :new.CONT_ATTRIBUTE14,
    p_new_CONT_ATTRIBUTE15         => :new.CONT_ATTRIBUTE15,
    p_new_CONT_ATTRIBUTE16         => :new.CONT_ATTRIBUTE16,
    p_new_CONT_ATTRIBUTE17         => :new.CONT_ATTRIBUTE17,
    p_new_CONT_ATTRIBUTE18         => :new.CONT_ATTRIBUTE18,
    p_new_CONT_ATTRIBUTE19         => :new.CONT_ATTRIBUTE19,
    p_new_CONT_ATTRIBUTE2          => :new.CONT_ATTRIBUTE2,
    p_new_CONT_ATTRIBUTE20         => :new.CONT_ATTRIBUTE20,
    p_new_CONT_ATTRIBUTE3          => :new.CONT_ATTRIBUTE3,
    p_new_CONT_ATTRIBUTE4          => :new.CONT_ATTRIBUTE4,
    p_new_CONT_ATTRIBUTE5          => :new.CONT_ATTRIBUTE5,
    p_new_CONT_ATTRIBUTE6          => :new.CONT_ATTRIBUTE6,
    p_new_CONT_ATTRIBUTE7          => :new.CONT_ATTRIBUTE7,
    p_new_CONT_ATTRIBUTE8          => :new.CONT_ATTRIBUTE8,
    p_new_CONT_ATTRIBUTE9          => :new.CONT_ATTRIBUTE9,
    p_new_CONT_ATTRIBUTE_CATEGORY  => :new.CONT_ATTRIBUTE_CATEGORY,
    p_new_CONT_INFORMATION1        => :new.CONT_INFORMATION1,
    p_new_CONT_INFORMATION10       => :new.CONT_INFORMATION10,
    p_new_CONT_INFORMATION11       => :new.CONT_INFORMATION11,
    p_new_CONT_INFORMATION12       => :new.CONT_INFORMATION12,
    p_new_CONT_INFORMATION13       => :new.CONT_INFORMATION13,
    p_new_CONT_INFORMATION14       => :new.CONT_INFORMATION14,
    p_new_CONT_INFORMATION15       => :new.CONT_INFORMATION15,
    p_new_CONT_INFORMATION16       => :new.CONT_INFORMATION16,
    p_new_CONT_INFORMATION17       => :new.CONT_INFORMATION17,
    p_new_CONT_INFORMATION18       => :new.CONT_INFORMATION18,
    p_new_CONT_INFORMATION19       => :new.CONT_INFORMATION19,
    p_new_CONT_INFORMATION2        => :new.CONT_INFORMATION2,
    p_new_CONT_INFORMATION20       => :new.CONT_INFORMATION20,
    p_new_CONT_INFORMATION3        => :new.CONT_INFORMATION3,
    p_new_CONT_INFORMATION4        => :new.CONT_INFORMATION4,
    p_new_CONT_INFORMATION5        => :new.CONT_INFORMATION5,
    p_new_CONT_INFORMATION6        => :new.CONT_INFORMATION6,
    p_new_CONT_INFORMATION7        => :new.CONT_INFORMATION7,
    p_new_CONT_INFORMATION8        => :new.CONT_INFORMATION8,
    p_new_CONT_INFORMATION9        => :new.CONT_INFORMATION9,
    p_new_CONT_INFORMATION_CATEGOR => :new.CONT_INFORMATION_CATEGORY,
    p_new_DATE_END                 => :new.DATE_END,
    p_new_DATE_START               => :new.DATE_START,
    p_new_DEPENDENT_FLAG           => :new.DEPENDENT_FLAG,
    p_new_END_LIFE_REASON_ID       => :new.END_LIFE_REASON_ID,
    p_new_PARTY_ID                 => :new.PARTY_ID,
    p_new_PERSONAL_FLAG            => :new.PERSONAL_FLAG,
    p_new_PERSON_ID                => :new.PERSON_ID,
    p_new_PRIMARY_CONTACT_FLAG     => :new.PRIMARY_CONTACT_FLAG,
    p_new_PROGRAM_APPLICATION_ID   => :new.PROGRAM_APPLICATION_ID,
    p_new_PROGRAM_ID               => :new.PROGRAM_ID,
    p_new_PROGRAM_UPDATE_DATE      => :new.PROGRAM_UPDATE_DATE,
    p_new_REQUEST_ID               => :new.REQUEST_ID,
    p_new_RLTD_PER_RSDS_W_DSGNTR_F => :new.RLTD_PER_RSDS_W_DSGNTR_FLAG,
    p_new_SEQUENCE_NUMBER          => :new.SEQUENCE_NUMBER,
    p_new_START_LIFE_REASON_ID     => :new.START_LIFE_REASON_ID,
    p_new_THIRD_PARTY_PAY_FLAG     => :new.THIRD_PARTY_PAY_FLAG,
    p_old_BENEFICIARY_FLAG         => :old.BENEFICIARY_FLAG,
    p_old_BONDHOLDER_FLAG          => :old.BONDHOLDER_FLAG,
    p_old_BUSINESS_GROUP_ID        => :old.BUSINESS_GROUP_ID,
    p_old_CONTACT_PERSON_ID        => :old.CONTACT_PERSON_ID,
    p_old_CONTACT_RELATIONSHIP_ID  => :old.CONTACT_RELATIONSHIP_ID,
    p_old_CONTACT_TYPE             => :old.CONTACT_TYPE,
    p_old_CONT_ATTRIBUTE1          => :old.CONT_ATTRIBUTE1,
    p_old_CONT_ATTRIBUTE10         => :old.CONT_ATTRIBUTE10,
    p_old_CONT_ATTRIBUTE11         => :old.CONT_ATTRIBUTE11,
    p_old_CONT_ATTRIBUTE12         => :old.CONT_ATTRIBUTE12,
    p_old_CONT_ATTRIBUTE13         => :old.CONT_ATTRIBUTE13,
    p_old_CONT_ATTRIBUTE14         => :old.CONT_ATTRIBUTE14,
    p_old_CONT_ATTRIBUTE15         => :old.CONT_ATTRIBUTE15,
    p_old_CONT_ATTRIBUTE16         => :old.CONT_ATTRIBUTE16,
    p_old_CONT_ATTRIBUTE17         => :old.CONT_ATTRIBUTE17,
    p_old_CONT_ATTRIBUTE18         => :old.CONT_ATTRIBUTE18,
    p_old_CONT_ATTRIBUTE19         => :old.CONT_ATTRIBUTE19,
    p_old_CONT_ATTRIBUTE2          => :old.CONT_ATTRIBUTE2,
    p_old_CONT_ATTRIBUTE20         => :old.CONT_ATTRIBUTE20,
    p_old_CONT_ATTRIBUTE3          => :old.CONT_ATTRIBUTE3,
    p_old_CONT_ATTRIBUTE4          => :old.CONT_ATTRIBUTE4,
    p_old_CONT_ATTRIBUTE5          => :old.CONT_ATTRIBUTE5,
    p_old_CONT_ATTRIBUTE6          => :old.CONT_ATTRIBUTE6,
    p_old_CONT_ATTRIBUTE7          => :old.CONT_ATTRIBUTE7,
    p_old_CONT_ATTRIBUTE8          => :old.CONT_ATTRIBUTE8,
    p_old_CONT_ATTRIBUTE9          => :old.CONT_ATTRIBUTE9,
    p_old_CONT_ATTRIBUTE_CATEGORY  => :old.CONT_ATTRIBUTE_CATEGORY,
    p_old_CONT_INFORMATION1        => :old.CONT_INFORMATION1,
    p_old_CONT_INFORMATION10       => :old.CONT_INFORMATION10,
    p_old_CONT_INFORMATION11       => :old.CONT_INFORMATION11,
    p_old_CONT_INFORMATION12       => :old.CONT_INFORMATION12,
    p_old_CONT_INFORMATION13       => :old.CONT_INFORMATION13,
    p_old_CONT_INFORMATION14       => :old.CONT_INFORMATION14,
    p_old_CONT_INFORMATION15       => :old.CONT_INFORMATION15,
    p_old_CONT_INFORMATION16       => :old.CONT_INFORMATION16,
    p_old_CONT_INFORMATION17       => :old.CONT_INFORMATION17,
    p_old_CONT_INFORMATION18       => :old.CONT_INFORMATION18,
    p_old_CONT_INFORMATION19       => :old.CONT_INFORMATION19,
    p_old_CONT_INFORMATION2        => :old.CONT_INFORMATION2,
    p_old_CONT_INFORMATION20       => :old.CONT_INFORMATION20,
    p_old_CONT_INFORMATION3        => :old.CONT_INFORMATION3,
    p_old_CONT_INFORMATION4        => :old.CONT_INFORMATION4,
    p_old_CONT_INFORMATION5        => :old.CONT_INFORMATION5,
    p_old_CONT_INFORMATION6        => :old.CONT_INFORMATION6,
    p_old_CONT_INFORMATION7        => :old.CONT_INFORMATION7,
    p_old_CONT_INFORMATION8        => :old.CONT_INFORMATION8,
    p_old_CONT_INFORMATION9        => :old.CONT_INFORMATION9,
    p_old_CONT_INFORMATION_CATEGOR => :old.CONT_INFORMATION_CATEGORY,
    p_old_DATE_END                 => :old.DATE_END,
    p_old_DATE_START               => :old.DATE_START,
    p_old_DEPENDENT_FLAG           => :old.DEPENDENT_FLAG,
    p_old_END_LIFE_REASON_ID       => :old.END_LIFE_REASON_ID,
    p_old_PARTY_ID                 => :old.PARTY_ID,
    p_old_PERSONAL_FLAG            => :old.PERSONAL_FLAG,
    p_old_PERSON_ID                => :old.PERSON_ID,
    p_old_PRIMARY_CONTACT_FLAG     => :old.PRIMARY_CONTACT_FLAG,
    p_old_PROGRAM_APPLICATION_ID   => :old.PROGRAM_APPLICATION_ID,
    p_old_PROGRAM_ID               => :old.PROGRAM_ID,
    p_old_PROGRAM_UPDATE_DATE      => :old.PROGRAM_UPDATE_DATE,
    p_old_REQUEST_ID               => :old.REQUEST_ID,
    p_old_RLTD_PER_RSDS_W_DSGNTR_F => :old.RLTD_PER_RSDS_W_DSGNTR_FLAG,
    p_old_SEQUENCE_NUMBER          => :old.SEQUENCE_NUMBER,
    p_old_START_LIFE_REASON_ID     => :old.START_LIFE_REASON_ID,
    p_old_THIRD_PARTY_PAY_FLAG     => :old.THIRD_PARTY_PAY_FLAG
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
    hr_utility.set_location('PERCONTACTRELATIONSH_2131U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERCONTACTRELATIONSH_2131U_DYT" ENABLE;
