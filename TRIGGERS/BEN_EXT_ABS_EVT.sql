--------------------------------------------------------
--  DDL for Trigger BEN_EXT_ABS_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_ABS_EVT" 
after insert or update or delete on "HR"."PER_ABSENCE_ATTENDANCES"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_abs_rec_type;
  l_new_rec           ben_ext_chlg.g_abs_rec_type;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.absence_attendance_id := :old.absence_attendance_id;
  l_old_rec.business_group_id := :old.business_group_id;
  l_old_rec.absence_attendance_type_id := :old.absence_attendance_type_id;
  l_old_rec.person_id := :old.person_id;
  l_old_rec.abs_attendance_reason_id := :old.abs_attendance_reason_id;
  l_old_rec.date_start := :old.date_start;
  l_old_rec.date_end := :old.date_end;
  l_old_rec.date_projected_start := :old.date_projected_start;
--
  l_new_rec.absence_attendance_id := :new.absence_attendance_id;
  l_new_rec.business_group_id := :new.business_group_id;
  l_new_rec.absence_attendance_type_id := :new.absence_attendance_type_id;
  l_new_rec.person_id := :new.person_id;
  l_new_rec.abs_attendance_reason_id := :new.abs_attendance_reason_id;
  l_new_rec.date_start := :new.date_start;
  l_new_rec.date_end := :new.date_end;
  l_new_rec.date_projected_start := :new.date_projected_start;
--
  if INSERTING then
    ben_ext_chlg.log_abs_chg
    (p_event   => 'INSERT'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
  elsif DELETING then
    ben_ext_chlg.log_abs_chg
    (p_event   => 'DELETE'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
  elsif UPDATING then
    ben_ext_chlg.log_abs_chg
    (p_event   => 'UPDATE'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
  end if;
--
 --
 end if;
 --
end;

/
ALTER TRIGGER "APPS"."BEN_EXT_ABS_EVT" ENABLE;
