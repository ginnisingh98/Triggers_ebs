--------------------------------------------------------
--  DDL for Trigger BEN_COMPETENCE_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_COMPETENCE_EVT" 
after update or insert on "HR"."PER_COMPETENCE_ELEMENTS"
for each row
--
declare
--

  l_old_rec           ben_cel_ler.g_cel_ler_rec;
  l_new_rec           ben_cel_ler.g_cel_ler_rec;

--

--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode not in ( 'Y','P') then
 --

  l_old_rec.competence_id  := :old.competence_id;
  l_old_rec.proficiency_level_id  := :old.proficiency_level_id;
  l_old_rec.competence_element_id  := :old.competence_element_id;
  l_old_rec.business_group_id := :old.business_group_id;
  l_old_rec.person_id := :old.person_id;
  l_old_rec.effective_date_from := :old.effective_date_from;
  l_old_rec.effective_date_to := :old.effective_date_to;

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
  l_old_rec.attribute11 :=:old.attribute11;
  l_old_rec.attribute12 :=:old.attribute12;
  l_old_rec.attribute13 :=:old.attribute13;
  l_old_rec.attribute14 :=:old.attribute14;
  l_old_rec.attribute15 :=:old.attribute15;
  l_old_rec.attribute16 :=:old.attribute16;
  l_old_rec.attribute17 :=:old.attribute17;
  l_old_rec.attribute18 :=:old.attribute18;
  l_old_rec.attribute19 :=:old.attribute19;
  l_old_rec.attribute20 :=:old.attribute20;

--
  l_new_rec.competence_id  := :new.competence_id;
  l_new_rec.proficiency_level_id  := :new.proficiency_level_id;
  l_new_rec.competence_element_id  := :new.competence_element_id;
  l_new_rec.business_group_id := :new.business_group_id;
  l_new_rec.person_id := :new.person_id;
  l_new_rec.effective_date_from := :new.effective_date_from;
  l_new_rec.effective_date_to := :new.effective_date_to;

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
  l_new_rec.attribute11 :=:new.attribute11;
  l_new_rec.attribute12 :=:new.attribute12;
  l_new_rec.attribute13 :=:new.attribute13;
  l_new_rec.attribute14 :=:new.attribute14;
  l_new_rec.attribute15 :=:new.attribute15;
  l_new_rec.attribute16 :=:new.attribute16;
  l_new_rec.attribute17 :=:new.attribute17;
  l_new_rec.attribute18 :=:new.attribute18;
  l_new_rec.attribute19 :=:new.attribute19;
  l_new_rec.attribute20 :=:new.attribute20;
--
  -- bug 2862886
  if :new.type = 'PERSONAL' then
    ben_cel_ler.ler_chk(l_old_rec
                        ,l_new_rec
                        ,l_new_rec.effective_date_from);
  end if;

 --
 end if;
 --
end;



/
ALTER TRIGGER "APPS"."BEN_COMPETENCE_EVT" ENABLE;
