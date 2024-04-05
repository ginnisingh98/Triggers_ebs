--------------------------------------------------------
--  DDL for Trigger BEN_PERFORMANCE_REVIEW_EVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BEN_PERFORMANCE_REVIEW_EVT" 
after update or insert on "HR"."PER_PERFORMANCE_REVIEWS"
for each row
--
declare
--
  l_old_rec           ben_ppr_ler.g_ppr_ler_rec;
  l_new_rec           ben_ppr_ler.g_ppr_ler_rec;
  l_old_business_group_id per_all_people_f.business_group_id%TYPE;
  l_new_business_group_id per_all_people_f.business_group_id%TYPE;

  cursor get_bsns_grp_id(p_person_id in number) is
   select ppf.business_group_id
   from per_all_people_f ppf
   where ppf.person_id = p_person_id;
--
begin
 --
 -- Not to be called when Data Migrator is in progress
 if hr_general.g_data_migrator_mode not in ( 'Y','P') then
 --
  open get_bsns_grp_id(:old.person_id);
  fetch get_bsns_grp_id into l_old_business_group_id;
  close get_bsns_grp_id;

  l_old_rec.person_id  := :old.person_id;
  l_old_rec.performance_review_id  := :old.performance_review_id;
  l_old_rec.performance_rating  := :old.performance_rating;
  l_old_rec.business_group_id := l_old_business_group_id;
  l_old_rec.review_date := :old.review_date;
  l_old_rec.event_id := :old.event_id;


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
  l_old_rec.attribute21 :=:old.attribute21;
  l_old_rec.attribute22 :=:old.attribute22;
  l_old_rec.attribute23 :=:old.attribute23;
  l_old_rec.attribute24 :=:old.attribute24;
  l_old_rec.attribute25 :=:old.attribute25;
  l_old_rec.attribute26 :=:old.attribute26;
  l_old_rec.attribute27 :=:old.attribute27;
  l_old_rec.attribute28 :=:old.attribute28;
  l_old_rec.attribute29 :=:old.attribute29;
  l_old_rec.attribute30 :=:old.attribute30;



--
  open get_bsns_grp_id(:new.person_id);
  fetch get_bsns_grp_id into l_new_business_group_id;
  close get_bsns_grp_id;


  l_new_rec.person_id  := :new.person_id;
  l_new_rec.performance_review_id  := :new.performance_review_id;
  l_new_rec.performance_rating  := :new.performance_rating;
  l_new_rec.business_group_id := l_new_business_group_id;
  l_new_rec.review_date := :new.review_date;
  l_new_rec.event_id := :new.event_id;

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
  l_new_rec.attribute21 :=:new.attribute21;
  l_new_rec.attribute22 :=:new.attribute22;
  l_new_rec.attribute23 :=:new.attribute23;
  l_new_rec.attribute24 :=:new.attribute24;
  l_new_rec.attribute25 :=:new.attribute25;
  l_new_rec.attribute26 :=:new.attribute26;
  l_new_rec.attribute27 :=:new.attribute27;
  l_new_rec.attribute28 :=:new.attribute28;
  l_new_rec.attribute29 :=:new.attribute29;
  l_new_rec.attribute30 :=:new.attribute30;

--

  ben_ppr_ler.ler_chk(l_old_rec
                      ,l_new_rec
                      ,l_new_rec.review_date);
 --
 end if;
 --
end;



/
ALTER TRIGGER "APPS"."BEN_PERFORMANCE_REVIEW_EVT" ENABLE;
