--------------------------------------------------------
--  DDL for Trigger BEN_EXT_PER_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_PER_EVT" 
before update on "HR"."PER_ALL_PEOPLE_F"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_per_rec_type;
  l_new_rec           ben_ext_chlg.g_per_rec_type;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.national_identifier := :old.national_identifier;
  l_old_rec.full_name := :old.full_name;
  l_old_rec.last_name := :old.last_name;
  l_old_rec.first_name := :old.first_name;
  l_old_rec.middle_names := :old.middle_names;
  l_old_rec.title := :old.title;
  l_old_rec.pre_name_adjunct := :old.pre_name_adjunct;
  l_old_rec.suffix := :old.suffix;
  l_old_rec.known_as := :old.known_as;
  l_old_rec.previous_last_name := :old.previous_last_name;
  l_old_rec.date_of_birth := :old.date_of_birth;
  l_old_rec.sex := :old.sex;
  l_old_rec.marital_status := :old.marital_status;
  l_old_rec.person_id := :old.person_id;
  l_old_rec.person_type_id := :old.person_type_id;
  l_old_rec.business_group_id := :old.business_group_id;
  l_old_rec.registered_disabled_flag := :old.registered_disabled_flag;
  l_old_rec.benefit_group_id := :old.benefit_group_id;
  l_old_rec.student_status := :old.student_status;
  l_old_rec.date_of_death := :old.date_of_death;
  l_old_rec.date_employee_data_verified := :old.date_employee_data_verified;
  l_old_rec.effective_start_date :=:old.effective_start_date;
  l_old_rec.effective_end_date :=:old.effective_end_date;
  l_old_rec.attribute1 :=:old.attribute1;
  l_old_rec.attribute2 :=:old.attribute2;
  l_old_rec.attribute3 :=:old.attribute3;
  l_old_rec.attribute4 :=:old.attribute4;
  l_old_rec.attribute5 :=:old.attribute5;
  l_old_rec.attribute6 :=:old.attribute6;
  l_old_rec.attribute7 :=:old.attribute7;
  l_old_rec.attribute8 :=:old.attribute8;
  l_old_rec.attribute9 :=:old.attribute9;
  l_old_rec.attribute10 :=:old.attribute10;
  l_old_rec.email_address :=:old.email_address;
  l_old_rec.per_information1 :=:old.per_information1;
  l_old_rec.per_information2 :=:old.per_information2;
  l_old_rec.per_information3 :=:old.per_information3;
  l_old_rec.per_information4 :=:old.per_information4;
  l_old_rec.per_information5 :=:old.per_information5;
  l_old_rec.per_information6 :=:old.per_information6;
  l_old_rec.per_information7 :=:old.per_information7;
  l_old_rec.per_information8 :=:old.per_information8;
  l_old_rec.per_information9 :=:old.per_information9;
  l_old_rec.per_information10 :=:old.per_information10;
  l_old_rec.per_information11 :=:old.per_information11;
  l_old_rec.per_information12 :=:old.per_information12;
  l_old_rec.per_information13 :=:old.per_information13;
  l_old_rec.per_information14 :=:old.per_information14;
  l_old_rec.per_information15 :=:old.per_information15;
  l_old_rec.per_information16 :=:old.per_information16;
  l_old_rec.per_information17 :=:old.per_information17;
  l_old_rec.per_information18 :=:old.per_information18;
  l_old_rec.per_information19 :=:old.per_information19;
  l_old_rec.per_information20 :=:old.per_information20;
  l_old_rec.per_information21 :=:old.per_information21;
  l_old_rec.per_information22 :=:old.per_information22;
  l_old_rec.per_information23 :=:old.per_information23;
  l_old_rec.per_information24 :=:old.per_information24;
  l_old_rec.per_information25 :=:old.per_information25;
  l_old_rec.per_information26 :=:old.per_information26;
  l_old_rec.per_information27 :=:old.per_information27;
  l_old_rec.per_information28 :=:old.per_information28;
  l_old_rec.per_information29 :=:old.per_information29;
  l_old_rec.per_information30 :=:old.per_information30;
  l_old_rec.correspondence_language :=:old.correspondence_language;
  l_old_rec.uses_tobacco_flag :=:old.uses_tobacco_flag;
  l_old_rec.employee_number   :=:old.employee_number;
--
  l_new_rec.national_identifier := :new.national_identifier;
  l_new_rec.full_name := :new.full_name;
  l_new_rec.last_name := :new.last_name;
  l_new_rec.first_name := :new.first_name;
  l_new_rec.middle_names := :new.middle_names;
  l_new_rec.title := :new.title;
  l_new_rec.pre_name_adjunct := :new.pre_name_adjunct;
  l_new_rec.suffix := :new.suffix;
  l_new_rec.known_as := :new.known_as;
  l_new_rec.previous_last_name := :new.previous_last_name;
  l_new_rec.date_of_birth := :new.date_of_birth;
  l_new_rec.sex := :new.sex;
  l_new_rec.marital_status := :new.marital_status;
  l_new_rec.person_id := :new.person_id;
  l_new_rec.person_type_id := :new.person_type_id;
  l_new_rec.business_group_id := :new.business_group_id;
  l_new_rec.registered_disabled_flag := :new.registered_disabled_flag;
  l_new_rec.benefit_group_id := :new.benefit_group_id;
  l_new_rec.student_status := :new.student_status;
  l_new_rec.date_of_death := :new.date_of_death;
  l_new_rec.date_employee_data_verified := :new.date_employee_data_verified;
  l_new_rec.effective_start_date :=:new.effective_start_date;
  l_new_rec.effective_end_date :=:new.effective_end_date;
  l_new_rec.attribute1 :=:new.attribute1;
  l_new_rec.attribute2 :=:new.attribute2;
  l_new_rec.attribute3 :=:new.attribute3;
  l_new_rec.attribute4 :=:new.attribute4;
  l_new_rec.attribute5 :=:new.attribute5;
  l_new_rec.attribute6 :=:new.attribute6;
  l_new_rec.attribute7 :=:new.attribute7;
  l_new_rec.attribute8 :=:new.attribute8;
  l_new_rec.attribute9 :=:new.attribute9;
  l_new_rec.attribute10 :=:new.attribute10;
  l_new_rec.email_address :=:new.email_address;
  l_new_rec.per_information1 :=:new.per_information1;
  l_new_rec.per_information2 :=:new.per_information2;
  l_new_rec.per_information3 :=:new.per_information3;
  l_new_rec.per_information4 :=:new.per_information4;
  l_new_rec.per_information5 :=:new.per_information5;
  l_new_rec.per_information6 :=:new.per_information6;
  l_new_rec.per_information7 :=:new.per_information7;
  l_new_rec.per_information8 :=:new.per_information8;
  l_new_rec.per_information9 :=:new.per_information9;
  l_new_rec.per_information10 :=:new.per_information10;
  l_new_rec.per_information11 :=:new.per_information11;
  l_new_rec.per_information12 :=:new.per_information12;
  l_new_rec.per_information13 :=:new.per_information13;
  l_new_rec.per_information14 :=:new.per_information14;
  l_new_rec.per_information15 :=:new.per_information15;
  l_new_rec.per_information16 :=:new.per_information16;
  l_new_rec.per_information17 :=:new.per_information17;
  l_new_rec.per_information18 :=:new.per_information18;
  l_new_rec.per_information19 :=:new.per_information19;
  l_new_rec.per_information20 :=:new.per_information20;
  l_new_rec.per_information21 :=:new.per_information21;
  l_new_rec.per_information22 :=:new.per_information22;
  l_new_rec.per_information23 :=:new.per_information23;
  l_new_rec.per_information24 :=:new.per_information24;
  l_new_rec.per_information25 :=:new.per_information25;
  l_new_rec.per_information26 :=:new.per_information26;
  l_new_rec.per_information27 :=:new.per_information27;
  l_new_rec.per_information28 :=:new.per_information28;
  l_new_rec.per_information29 :=:new.per_information29;
  l_new_rec.per_information30 :=:new.per_information30;
  l_new_rec.correspondence_language :=:new.correspondence_language;
  l_new_rec.uses_tobacco_flag :=:new.uses_tobacco_flag;
  l_new_rec.employee_number   :=:new.employee_number;

--
  if :new.effective_start_date = :old.effective_start_date then
    l_new_rec.update_mode := 'CORRECTION';
    l_old_rec.update_mode := 'CORRECTION';
  else
    l_new_rec.update_mode := 'UPDATE';
    l_old_rec.update_mode := 'UPDATE';
  end if;
--
  ben_ext_chlg.log_per_chg
  (p_event   => 'UPDATE'
  ,p_old_rec => l_old_rec
  ,p_new_rec => l_new_rec
  );
--
 --
 end if;
 --
end;



/
ALTER TRIGGER "APPS"."BEN_EXT_PER_EVT" ENABLE;
