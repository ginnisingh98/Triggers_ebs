--------------------------------------------------------
--  DDL for Trigger PER_PROPOSAL_COMPS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_PROPOSAL_COMPS_OVN" 
BEFORE INSERT OR UPDATE ON "HR"."PER_PAY_PROPOSAL_COMPONENTS" for each row

begin
    if hr_general.g_data_migrator_mode <> 'Y' then
	  if not PER_PPC_shd.return_api_dml_status then
	   if inserting then
		:NEW.object_version_number := 1;
	   else
		:NEW.object_version_number := :OLD.object_version_number + 1;
	   end if;
	end if;
    end if;
end PER__PROPOSAL_COMPS_OVN;


/
ALTER TRIGGER "APPS"."PER_PROPOSAL_COMPS_OVN" ENABLE;
