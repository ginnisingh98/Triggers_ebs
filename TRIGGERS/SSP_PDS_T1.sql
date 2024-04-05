--------------------------------------------------------
--  DDL for Trigger SSP_PDS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_PDS_T1" 
AFTER UPDATE
OF PRIOR_EMPLOYMENT_SSP_PAID_TO
,  PRIOR_EMPLOYMENT_SSP_WEEKS
ON "HR"."PER_PERIODS_OF_SERVICE"
FOR EACH ROW
   WHEN (
(old.prior_employment_ssp_weeks
        <> new.prior_employment_ssp_weeks
or old.prior_employment_ssp_paid_to
      <> new.prior_employment_ssp_paid_to)
) DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if ssp_ssp_pkg.ssp_is_installed then
    ssp_ssp_pkg.SSP1L_control (:new.person_id, :new.date_start);
  end if;
end if;
END;


/
ALTER TRIGGER "APPS"."SSP_PDS_T1" ENABLE;
