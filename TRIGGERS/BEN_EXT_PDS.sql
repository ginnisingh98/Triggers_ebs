--------------------------------------------------------
--  DDL for Trigger BEN_EXT_PDS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_PDS" 
before insert or delete or update on "HR"."PER_PERIODS_OF_SERVICE"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_pos_rec_type;
  l_new_rec           ben_ext_chlg.g_pos_rec_type;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
  if hr_general.g_data_migrator_mode <> 'Y' then
 --
      l_old_rec.period_of_service_id := :old.period_of_service_id;
      l_old_rec.person_id := :old.person_id;
      l_old_rec.business_group_id := :old.business_group_id;
      l_old_rec.date_start := :old.date_start;
      l_old_rec.actual_termination_date := :old.actual_termination_date;
      l_old_rec.leaving_reason := :old.leaving_reason;
      ---
      l_new_rec.period_of_service_id := :new.period_of_service_id;
      l_new_rec.person_id := :new.person_id;
      l_new_rec.business_group_id := :new.business_group_id;
      l_new_rec.date_start := :new.date_start;
      l_new_rec.actual_termination_date := :new.actual_termination_date;
      l_new_rec.leaving_reason := :new.leaving_reason;
      l_new_rec.last_update_date := :new.last_update_date;


--
  if UPDATING then
    if :new.date_start = :old.date_start then
      l_new_rec.update_mode := 'CORRECTION';
      l_old_rec.update_mode := 'CORRECTION';
    else
      l_new_rec.update_mode := 'UPDATE';
      l_old_rec.update_mode := 'UPDATE';
    end if;
  --
    ben_ext_chlg.log_pos_chg
    (p_event   => 'UPDATE'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
  --
  elsif INSERTING then
    ben_ext_chlg.log_pos_chg
    (p_event   => 'INSERT'
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
ALTER TRIGGER "APPS"."BEN_EXT_PDS" ENABLE;
