--------------------------------------------------------
--  DDL for Trigger BEN_EXT_ADD_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_ADD_EVT" 
after insert or update or delete on "HR"."PER_ADDRESSES"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_add_rec_type;
  l_new_rec           ben_ext_chlg.g_add_rec_type;
--
begin
--
-- Irec: Party Id bug 2945236.
-- Don't care about old address its already in DB
-- if new address does not have both set do nothing.
--
 if ((:new.business_group_id is not null)
and  (:new.person_id is not null) ) then
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
  l_old_rec.address_id := :old.address_id;
  l_old_rec.primary_flag := :old.primary_flag;
  l_old_rec.person_id := :old.person_id;
  l_old_rec.business_group_id := :old.business_group_id;
  l_old_rec.address_line1 := :old.address_line1;
  l_old_rec.address_line2 := :old.address_line2;
  l_old_rec.address_line3 := :old.address_line3;
  l_old_rec.country := :old.country;
  l_old_rec.postal_code := :old.postal_code;
  l_old_rec.region_1 := :old.region_1;
  l_old_rec.region_2 := :old.region_2;
  l_old_rec.region_3 := :old.region_3;
  l_old_rec.town_or_city := :old.town_or_city;
  l_old_rec.address_type := :old.address_type;
  l_old_rec.date_from :=:old.date_from;
  l_old_rec.date_to := :old.date_to;
--
  l_new_rec.address_id := :new.address_id;
  l_new_rec.primary_flag := :new.primary_flag;
  l_new_rec.person_id := :new.person_id;
  l_new_rec.business_group_id := :new.business_group_id;
  l_new_rec.address_line1 := :new.address_line1;
  l_new_rec.address_line2 := :new.address_line2;
  l_new_rec.address_line3 := :new.address_line3;
  l_new_rec.country := :new.country;
  l_new_rec.postal_code := :new.postal_code;
  l_new_rec.region_1 := :new.region_1;
  l_new_rec.region_2 := :new.region_2;
  l_new_rec.region_3 := :new.region_3;
  l_new_rec.town_or_city := :new.town_or_city;
  l_new_rec.address_type := :new.address_type;
  l_new_rec.date_from :=:new.date_from;
  l_new_rec.date_to := :new.date_to;
--
  if INSERTING then
    ben_ext_chlg.log_add_chg
    (p_event   => 'INSERT'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
  elsif DELETING then
    ben_ext_chlg.log_add_chg
    (p_event   => 'DELETE'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
  elsif UPDATING then
    ben_ext_chlg.log_add_chg
    (p_event   => 'UPDATE'
    ,p_old_rec => l_old_rec
    ,p_new_rec => l_new_rec
    );
  end if;
--
 end if;
end if;
--
end;


/
ALTER TRIGGER "APPS"."BEN_EXT_ADD_EVT" ENABLE;
