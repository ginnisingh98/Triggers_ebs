--------------------------------------------------------
--  DDL for Trigger PER_REC_ACTIVITY_FOR_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_REC_ACTIVITY_FOR_OVN" 
before insert or update on "HR"."PER_RECRUITMENT_ACTIVITY_FOR" for each row

begin
 if hr_general.g_data_migrator_mode <> 'Y' then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
 end if;
end per_rec_activity_for_ovn;



/
ALTER TRIGGER "APPS"."PER_REC_ACTIVITY_FOR_OVN" ENABLE;
