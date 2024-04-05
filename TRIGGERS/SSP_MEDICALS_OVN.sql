--------------------------------------------------------
--  DDL for Trigger SSP_MEDICALS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_MEDICALS_OVN" 
BEFORE INSERT OR UPDATE
ON "SSP"."SSP_MEDICALS"
FOR EACH ROW

DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if inserting then
    :new.object_version_number := 1;
  else
    :new.object_version_number := :old.object_version_number +1;
  end if;
end if;
END;



/
ALTER TRIGGER "APPS"."SSP_MEDICALS_OVN" ENABLE;
