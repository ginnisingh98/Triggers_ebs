--------------------------------------------------------
--  DDL for Trigger PER_JOBS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_JOBS_OVN" 
before insert or update on "HR"."PER_JOBS" for each row

begin
 if hr_general.g_data_migrator_mode <> 'Y' then
  if not per_job_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
 end if;
end per_jobs_ovn;


/
ALTER TRIGGER "APPS"."PER_JOBS_OVN" ENABLE;
