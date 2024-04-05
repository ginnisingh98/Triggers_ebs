--------------------------------------------------------
--  DDL for Trigger BEN_EXT_PHN_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_PHN_EVT" 
before update or insert or delete on "HR"."PER_PHONES"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_phn_rec_type;
  l_new_rec           ben_ext_chlg.g_phn_rec_type;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.phone_id := :old.phone_id;
  l_old_rec.date_from :=:old.date_from;
  l_old_rec.date_to := :old.date_to; --Bug 1554477
  l_old_rec.phone_type :=:old.phone_type;
  l_old_rec.phone_number :=:old.phone_number;
  l_old_rec.parent_table :=:old.parent_table;
  l_old_rec.parent_id :=:old.parent_id;
--
  l_new_rec.phone_id := :new.phone_id;
  l_new_rec.date_from :=:new.date_from;
  l_new_rec.date_to := :new.date_to; --Bug 1554477
  l_new_rec.phone_type :=:new.phone_type;
  l_new_rec.phone_number :=:new.phone_number;
  l_new_rec.parent_table :=:new.parent_table;
  l_new_rec.parent_id :=:new.parent_id;
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
 if INSERTING then 	 	--Bug 1554477
    ben_ext_chlg.log_phn_chg
    (p_event   => 'INSERT'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
 elsif UPDATING then
    ben_ext_chlg.log_phn_chg
    (p_event   => 'UPDATE'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
 elsif DELETING then            --Bug 1554477
    ben_ext_chlg.log_phn_chg
    (p_event   => 'DELETE'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
 end if;
--
 --
 end if;
end;



/
ALTER TRIGGER "APPS"."BEN_EXT_PHN_EVT" ENABLE;
