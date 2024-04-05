--------------------------------------------------------
--  DDL for Trigger BEN_EXT_APL_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_APL_EVT" 
before update on "HR"."PER_APPLICATIONS"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_apl_rec_type;
  l_new_rec           ben_ext_chlg.g_apl_rec_type;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.application_id := :old.application_id;
  l_old_rec.termination_reason :=:old.termination_reason;
  l_old_rec.date_received :=:old.date_received;
  l_old_rec.date_end :=:old.date_end;
  l_old_rec.person_id :=:old.person_id;
  l_old_rec.business_group_id :=:old.business_group_id;
--
  l_new_rec.application_id := :new.application_id;
  l_new_rec.termination_reason :=:new.termination_reason;
  l_new_rec.date_received :=:new.date_received;
  l_new_rec.date_end :=:new.date_end;
  l_new_rec.person_id :=:new.person_id;
  l_new_rec.business_group_id :=:new.business_group_id;
--
/*  if :new.effective_start_date = :old.effective_start_date then
    l_new_rec.update_mode := 'CORRECTION';
    l_old_rec.update_mode := 'CORRECTION';
  else
    l_new_rec.update_mode := 'UPDATE';
    l_old_rec.update_mode := 'UPDATE';
  end if;  */
--
  l_new_rec.update_mode := 'CORRECTION';
  l_old_rec.update_mode := 'CORRECTION';
--
  ben_ext_chlg.log_apl_chg
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
ALTER TRIGGER "APPS"."BEN_EXT_APL_EVT" ENABLE;
