--------------------------------------------------------
--  DDL for Trigger BEN_EXT_CONT_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_EXT_CONT_EVT" 
before update on "HR"."PER_CONTACT_RELATIONSHIPS"
for each row
--
declare
--
  l_old_rec           ben_ext_chlg.g_cont_rec_type;
  l_new_rec           ben_ext_chlg.g_cont_rec_type;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.contact_relationship_id := :old.contact_relationship_id;
  l_old_rec.contact_type := :old.contact_type;
  l_old_rec.person_id := :old.person_id;
  l_old_rec.contact_person_id := :old.contact_person_id;
  l_old_rec.business_group_id := :old.business_group_id;
  l_old_rec.date_start := :old.date_start;

--
  l_new_rec.contact_relationship_id := :new.contact_relationship_id;
  l_new_rec.contact_type := :new.contact_type;
  l_new_rec.person_id := :new.person_id;
  l_new_rec.contact_person_id := :new.contact_person_id;
  l_new_rec.business_group_id := :new.business_group_id;
  l_new_rec.date_start := :new.date_start;
--
  if nvl(:new.contact_type,'$$') <> nvl(:old.contact_type,'$$') then
  ben_ext_chlg.log_cont_chg
  (
  p_old_rec => l_old_rec
  ,p_new_rec => l_new_rec
  );
 end if;
 --
end if;
end;

/
ALTER TRIGGER "APPS"."BEN_EXT_CONT_EVT" ENABLE;
