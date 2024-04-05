--------------------------------------------------------
--  DDL for Trigger PER_ESTABLISHMENT_ATTN_CHLG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_ESTABLISHMENT_ATTN_CHLG" 
before insert or update
   on "HR"."PER_ESTABLISHMENT_ATTENDANCES"
   for each row
--

declare
--
  l_old_rec           ben_ext_chlg.g_per_school_rec_type;
  l_new_rec           ben_ext_chlg.g_per_school_rec_type;
--
begin
 --
 hr_utility.set_location(' Entering Trigger per_establishment_attendances_chlg ' , 199 );
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.person_id          :=:old.person_id;
  l_old_rec.attended_start_date:=:old.attended_start_date ;
  l_old_rec.attended_end_date  :=:old.attended_end_date;
  l_old_rec.full_time          :=:old.full_time   ;
  l_old_rec.business_group_id  :=:old.business_group_id  ;
  l_old_rec.establishment_id   :=:old.establishment_id   ;
--
  l_new_rec.person_id          :=:new.person_id;
  l_new_rec.attended_start_date:=:new.attended_start_date ;
  l_new_rec.attended_end_date  :=:new.attended_end_date;
  l_new_rec.full_time          :=:new.full_time   ;
  l_new_rec.business_group_id  :=:new.business_group_id  ;
  l_new_rec.establishment_id   :=:new.establishment_id   ;
--
    l_new_rec.update_mode := 'UPDATE';
    l_old_rec.update_mode := 'UPDATE';
--
      ben_ext_chlg.log_school_chg
      (p_event   => 'UPDATE'
      ,p_old_rec => l_old_rec
      ,p_new_rec => l_new_rec
      );

 --
 end if;
 --
 hr_utility.set_location(' exiting Trigger per_establishment_attendances_chlg ' , 199 );
end;



/
ALTER TRIGGER "APPS"."PER_ESTABLISHMENT_ATTN_CHLG" ENABLE;
