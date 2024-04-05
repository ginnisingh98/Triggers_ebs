--------------------------------------------------------
--  DDL for Trigger PER_RECRUITMENT_ACTIVITIES_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_RECRUITMENT_ACTIVITIES_OVN" 
before insert or update on "HR"."PER_RECRUITMENT_ACTIVITIES" for each row

begin
 if hr_general.g_data_migrator_mode <> 'Y' then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
 end if;
end per_recruitment_activities_ovn;


/
ALTER TRIGGER "APPS"."PER_RECRUITMENT_ACTIVITIES_OVN" ENABLE;
