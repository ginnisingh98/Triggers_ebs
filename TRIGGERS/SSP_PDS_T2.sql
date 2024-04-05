--------------------------------------------------------
--  DDL for Trigger SSP_PDS_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_PDS_T2" 
AFTER UPDATE
ON "HR"."PER_PERIODS_OF_SERVICE"

DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  ssp_smp_support_pkg.recalculate_ssp_and_smp;
end if;
END;


/
ALTER TRIGGER "APPS"."SSP_PDS_T2" ENABLE;
