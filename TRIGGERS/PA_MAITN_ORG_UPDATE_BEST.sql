--------------------------------------------------------
--  DDL for Trigger PA_MAITN_ORG_UPDATE_BEST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_MAITN_ORG_UPDATE_BEST" 
BEFORE UPDATE
ON "HR"."PER_ORG_STRUCTURE_ELEMENTS"
DECLARE
BEGIN
 if hr_general.g_data_migrator_mode <> 'Y' then
  IF (pa_imp.pa_implemented_all) THEN
       pa_org_utils.newRows := pa_org_utils.empty;
  END IF;
 end if;
END;

/
ALTER TRIGGER "APPS"."PA_MAITN_ORG_UPDATE_BEST" ENABLE;
