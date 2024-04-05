--------------------------------------------------------
--  DDL for Trigger BEN_EXT_PTU_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_PTU_EVT" 
before insert on "HR"."PER_PERSON_TYPE_USAGES_F"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_ptu_rec_type;
  l_new_rec           ben_ext_chlg.g_ptu_rec_type;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.person_type_usage_id := :old.person_type_usage_id;
  l_old_rec.person_id :=:old.person_id;
  l_old_rec.effective_start_date :=:old.effective_start_date;
  l_old_rec.person_type_id :=:old.person_type_id;
--
  l_new_rec.person_type_usage_id := :new.person_type_usage_id;
  l_new_rec.person_id :=:new.person_id;
  l_new_rec.effective_start_date :=:new.effective_start_date;
  l_new_rec.person_type_id :=:new.person_type_id;
--
  if :new.effective_start_date = :old.effective_start_date then
    l_new_rec.update_mode := 'CORRECTION';
    l_old_rec.update_mode := 'CORRECTION';
  else
    l_new_rec.update_mode := 'UPDATE';
    l_old_rec.update_mode := 'UPDATE';
  end if;
--
  ben_ext_chlg.log_ptu_chg
  (p_event   => 'INSERT'
  ,p_old_rec => l_old_rec
  ,p_new_rec => l_new_rec
  );
--
 --
 end if;
 --
end;

/
ALTER TRIGGER "APPS"."BEN_EXT_PTU_EVT" ENABLE;
