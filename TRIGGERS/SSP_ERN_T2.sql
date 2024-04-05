--------------------------------------------------------
--  DDL for Trigger SSP_ERN_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_ERN_T2" 
AFTER INSERT OR DELETE OR UPDATE
OF AVERAGE_EARNINGS_AMOUNT
ON "SSP"."SSP_EARNINGS_CALCULATIONS"

DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  ssp_smp_support_pkg.recalculate_ssp_and_smp;
end if;
END;



/
ALTER TRIGGER "APPS"."SSP_ERN_T2" ENABLE;
