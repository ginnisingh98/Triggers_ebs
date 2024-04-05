--------------------------------------------------------
--  DDL for Trigger SSP_WITHHOLDING_REASONS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_WITHHOLDING_REASONS_OVN" 
BEFORE INSERT OR UPDATE
ON "SSP"."SSP_WITHHOLDING_REASONS"
FOR EACH ROW

DECLARE
BEGIN
  if inserting then
    :new.object_version_number := 1;
  else
    :new.object_version_number := :old.object_version_number +1;
  end if;
END;



/
ALTER TRIGGER "APPS"."SSP_WITHHOLDING_REASONS_OVN" ENABLE;
