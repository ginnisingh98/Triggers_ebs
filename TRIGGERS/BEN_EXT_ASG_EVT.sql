--------------------------------------------------------
--  DDL for Trigger BEN_EXT_ASG_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_ASG_EVT" 
before update or insert or delete on "HR"."PER_ALL_ASSIGNMENTS_F"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_asg_rec_type;
  l_new_rec           ben_ext_chlg.g_asg_rec_type;

  CURSOR csr_leg_cd (c_bus_grp_id IN number) is
    SELECT legislation_code
      FROM per_business_groups_perf
     WHERE business_group_id = c_bus_grp_id;
  l_leg_code varchar2(3);

--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.assignment_id  := :old.assignment_id;
  l_old_rec.assignment_status_type_id  := :old.assignment_status_type_id;
  l_old_rec.hourly_salaried_code  := :old.hourly_salaried_code;
  l_old_rec.normal_hours := :old.normal_hours; -- Bug 1554477
  l_old_rec.location_id := :old.location_id;
  l_old_rec.position_id := :old.position_id;
  l_old_rec.employment_category := :old.employment_category;
  l_old_rec.person_id := :old.person_id;
  l_old_rec.assignment_type := :old.assignment_type;
  l_old_rec.business_group_id := :old.business_group_id;
  l_old_rec.effective_start_date :=:old.effective_start_date;
  l_old_rec.effective_end_date :=:old.effective_end_date;
  l_old_rec.ass_attribute1 :=:old.ass_attribute1;
  l_old_rec.ass_attribute2 :=:old.ass_attribute2;
  l_old_rec.ass_attribute3 :=:old.ass_attribute3;
  l_old_rec.ass_attribute4 :=:old.ass_attribute4;
  l_old_rec.ass_attribute5 :=:old.ass_attribute5;
  l_old_rec.ass_attribute6 :=:old.ass_attribute6;
  l_old_rec.ass_attribute7 :=:old.ass_attribute7;
  l_old_rec.ass_attribute8 :=:old.ass_attribute8;
  l_old_rec.ass_attribute9 :=:old.ass_attribute9;
  l_old_rec.ass_attribute10 :=:old.ass_attribute10;
  l_old_rec.payroll_id :=:old.payroll_id;
  l_old_rec.grade_id :=:old.grade_id;

--rpinjala
  l_old_rec.primary_flag := :old.primary_flag;
--rpinjala

--vjhanak
  l_old_rec.soft_coding_keyflex_id := :old.soft_coding_keyflex_id;
--vjhanak

--
  l_new_rec.assignment_id  := :new.assignment_id ;
  l_new_rec.assignment_status_type_id  := :new.assignment_status_type_id ;
  l_new_rec.hourly_salaried_code  := :new.hourly_salaried_code;
  l_new_rec.normal_hours := :new.normal_hours; --Bug 1554477
  l_new_rec.location_id := :new.location_id;
  l_new_rec.position_id := :new.position_id;
  l_new_rec.employment_category := :new.employment_category;
  l_new_rec.person_id := :new.person_id;
  l_new_rec.assignment_type := :new.assignment_type;
  l_new_rec.business_group_id := :new.business_group_id;
  l_new_rec.effective_start_date :=:new.effective_start_date;
  l_new_rec.effective_end_date :=:new.effective_end_date;
  l_new_rec.ass_attribute1 :=:new.ass_attribute1;
  l_new_rec.ass_attribute2 :=:new.ass_attribute2;
  l_new_rec.ass_attribute3 :=:new.ass_attribute3;
  l_new_rec.ass_attribute4 :=:new.ass_attribute4;
  l_new_rec.ass_attribute5 :=:new.ass_attribute5;
  l_new_rec.ass_attribute6 :=:new.ass_attribute6;
  l_new_rec.ass_attribute7 :=:new.ass_attribute7;
  l_new_rec.ass_attribute8 :=:new.ass_attribute8;
  l_new_rec.ass_attribute9 :=:new.ass_attribute9;
  l_new_rec.ass_attribute10 :=:new.ass_attribute10;
  l_new_rec.payroll_id :=:new.payroll_id;
  l_new_rec.grade_id :=:new.grade_id;
--rpinjala
  l_new_rec.primary_flag := :new.primary_flag;
--rpinjala

--vjhanak
  l_new_rec.soft_coding_keyflex_id := :new.soft_coding_keyflex_id;
--vjhanak
--
  if UPDATING then
    if :new.effective_start_date = :old.effective_start_date then
      l_new_rec.update_mode := 'CORRECTION';
      l_old_rec.update_mode := 'CORRECTION';
    else
      l_new_rec.update_mode := 'UPDATE';
      l_old_rec.update_mode := 'UPDATE';
    end if;
  --
    if :new.primary_flag = 'Y' then
      ben_ext_chlg.log_asg_chg
      (p_event   => 'UPDATE'
      ,p_old_rec => l_old_rec
      ,p_new_rec => l_new_rec
      );
    --rpinjala
    elsif NVL(:new.employment_category,'$') <>
          NVL(:old.employment_category,'$') THEN

      open csr_leg_cd(:new.business_group_id);
      fetch csr_leg_cd InTo l_leg_code;

      if csr_leg_cd%FOUND And
         l_leg_code = 'NL' Then
        ben_ext_chlg.log_asg_chg
        (p_event   => 'UPDATE'
        ,p_old_rec => l_old_rec
        ,p_new_rec => l_new_rec
        );
      end If;

      close csr_leg_cd;
    --rpinjala
     elsif NVL(:new.soft_coding_keyflex_id,0) <>
           NVL(:old.soft_coding_keyflex_id,0) THEN

       open csr_leg_cd(:new.business_group_id);
       fetch csr_leg_cd InTo l_leg_code;

       if csr_leg_cd%FOUND And
          l_leg_code = 'NL' Then
         ben_ext_chlg.log_asg_chg
         (p_event   => 'UPDATE'
         ,p_old_rec => l_old_rec
         ,p_new_rec => l_new_rec
         );
      END IF;
    end if;
  --
  elsif INSERTING then
    ben_ext_chlg.log_asg_chg
    (p_event    => 'INSERT'
    ,p_old_rec  => l_old_rec
    ,p_new_rec  => l_new_rec
    );
  elsif DELETING then
    ben_ext_chlg.log_asg_chg
    (p_event    => 'DELETE'
    ,p_old_rec  => l_old_rec
    ,p_new_rec  => l_new_rec
    );
  end if;
 --
 end if;
 --
end;


/
ALTER TRIGGER "APPS"."BEN_EXT_ASG_EVT" ENABLE;
