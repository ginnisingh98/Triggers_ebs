--------------------------------------------------------
--  DDL for Trigger PER_PAY_PROPOSALS_CHLG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_PAY_PROPOSALS_CHLG" 
before insert or update
   on "HR"."PER_PAY_PROPOSALS"
   for each row
     WHEN ( new.approved = 'Y'  ) declare
--
  l_old_rec           ben_ext_chlg.g_per_pay_rec_type;
  l_new_rec           ben_ext_chlg.g_per_pay_rec_type;
  l_event             varchar2(20) ;
--
begin
 --
 hr_utility.set_location(' Entering Trigger per_pay_proposals do nothing' , 199 );
 -- Not to be called when Data Migrator is in progress
/*
 if hr_general.g_data_migrator_mode <> 'Y' then
 --
  l_old_rec.assignment_id      := :old.assignment_id;
  l_old_rec.change_date        :=:old.change_date;
  l_old_rec.last_change_date   :=:old.last_change_date;
  l_old_rec.proposed_salary_n  :=:old.proposed_salary_n ;
  l_old_rec.approved           :=:old.approved ;
--
  l_new_rec.assignment_id      :=:new.assignment_id;
  l_new_rec.change_date        :=:new.change_date;
  l_new_rec.last_change_date   :=:new.last_change_date;
  l_new_rec.proposed_salary_n  :=:new.proposed_salary_n ;
  l_new_rec.approved           :=:new.approved ;
  if INSERTING then
     l_event := 'INSERT' ;
  else
     l_event := 'UPDATE' ;
  end if ;
--
  if :new.last_change_date = :old.last_change_date  then
    l_new_rec.update_mode := 'CORRECTION';
    l_old_rec.update_mode := 'CORRECTION';
  else
    l_new_rec.update_mode := 'UPDATE';
    l_old_rec.update_mode := 'UPDATE';
  end if;

--
      ben_ext_chlg.log_per_pay_chg
      (p_event   => l_event
      ,p_old_rec => l_old_rec
      ,p_new_rec => l_new_rec
      );

 --
 end if;
*/
 --
 hr_utility.set_location(' exiting Trigger per_pay_proposals ' , 199 );
end;

/
ALTER TRIGGER "APPS"."PER_PAY_PROPOSALS_CHLG" ENABLE;
