--------------------------------------------------------
--  DDL for Trigger PER_WPM_PLAN_HIERARCHY_WHO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_WPM_PLAN_HIERARCHY_WHO" 
before insert or update on "HR"."PER_WPM_PLAN_HIERARCHY"
for each row
declare
 l_sysdate DATE := sysdate;
begin
  -- Trigger generated by hrcretrg.sql at 2013/08/29 21:54:52.
 if hr_general.g_data_migrator_mode <> 'Y' then 
  if inserting and 
      :new.created_by    is null and 
      :new.creation_date is null then
    :new.created_by      := fnd_global.user_id;
    :new.creation_date   := l_sysdate;
   end if;
   if :new.last_update_date is null 
      or :new.last_update_date = nvl(:old.last_update_date,
                                     hr_general.start_of_time) 
      or :new.last_update_date = trunc(:new.last_update_date)
   then 
      :new.last_update_date  := l_sysdate;
  end if;
  :new.last_updated_by   := fnd_global.user_id;
  :new.last_update_login := fnd_global.login_id;
 end if;
end;

/
ALTER TRIGGER "APPS"."PER_WPM_PLAN_HIERARCHY_WHO" ENABLE;
