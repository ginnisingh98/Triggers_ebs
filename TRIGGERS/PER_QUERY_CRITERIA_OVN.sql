--------------------------------------------------------
--  DDL for Trigger PER_QUERY_CRITERIA_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_QUERY_CRITERIA_OVN" 
BEFORE INSERT OR UPDATE ON "HR"."PER_QUERY_CRITERIA" for each row
begin
     if hr_general.g_data_migrator_mode <> 'Y' then
	   if inserting then
		:NEW.object_version_number := 1;
	   else
		:NEW.object_version_number := :OLD.object_version_number + 1;
	   end if;
     end if;
end PER_QUERY_CRITERIA_OVN;


/
ALTER TRIGGER "APPS"."PER_QUERY_CRITERIA_OVN" ENABLE;
