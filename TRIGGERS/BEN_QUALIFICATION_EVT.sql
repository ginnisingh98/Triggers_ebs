--------------------------------------------------------
--  DDL for Trigger BEN_QUALIFICATION_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_QUALIFICATION_EVT" 
after update or insert on "HR"."PER_QUALIFICATIONS"
for each row
--
declare
--
  l_old_rec           ben_qua_ler.g_qua_ler_rec;
  l_new_rec           ben_qua_ler.g_qua_ler_rec;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode not in ( 'Y','P') then

 --

  l_old_rec.person_id  := :old.person_id;
  l_old_rec.qualification_id  := :old.qualification_id;
  l_old_rec.business_group_id  := :old.business_group_id;
  l_old_rec.start_date := :old.start_date;
  l_old_rec.end_date := :old.end_date;
  l_old_rec.qualification_type_id := :old.qualification_type_id;
  l_old_rec.title := :old.title;

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
-- Bug 2850744 Adding new columns.
  l_old_rec.attendance_id := :old.attendance_id;
  l_old_rec.party_id      := :old.party_id;


--
  l_new_rec.person_id  := :new.person_id;
  l_new_rec.qualification_id  := :new.qualification_id;
  l_new_rec.business_group_id  := :new.business_group_id;
  l_new_rec.start_date := :new.start_date;
  l_new_rec.end_date := :new.end_date;
  l_new_rec.qualification_type_id := :new.qualification_type_id;
  l_new_rec.title := :new.title;

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
-- Bug 2850744 Adding new columns.
  l_new_rec.attendance_id := :new.attendance_id;
  l_new_rec.party_id      := :new.party_id;
--

  ben_qua_ler.ler_chk(l_old_rec
                      ,l_new_rec
                      ,l_new_rec.start_date);
 --
 end if;
 --
end;



/
ALTER TRIGGER "APPS"."BEN_QUALIFICATION_EVT" ENABLE;
