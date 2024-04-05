--------------------------------------------------------
--  DDL for Trigger PER_PAY_PROPOSALS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_PAY_PROPOSALS_OVN" 
BEFORE INSERT OR UPDATE ON "HR"."PER_PAY_PROPOSALS" for each row

begin
     if hr_general.g_data_migrator_mode <> 'Y' then
	  if not PER_PYP_shd.return_api_dml_status then
	   if inserting then
		:NEW.object_version_number := 1;
	   else
		:NEW.object_version_number := :OLD.object_version_number + 1;
	   end if;
	end if;
     end if;
end PER_PAY_PROPOSALS_OVN;


/
ALTER TRIGGER "APPS"."PER_PAY_PROPOSALS_OVN" ENABLE;
