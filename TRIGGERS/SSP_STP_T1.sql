--------------------------------------------------------
--  DDL for Trigger SSP_STP_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_STP_T1" 
AFTER INSERT OR UPDATE
OF OVERRIDE_STOPPAGE
,  WITHHOLD_FROM
,  WITHHOLD_TO
ON "SSP"."SSP_STOPPAGES"
FOR EACH ROW
    WHEN (
new.user_entered = 'Y'
or (new.override_stoppage <> old.override_stoppage)
) DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if ssp_ssp_pkg.ssp_is_installed then
    ssp_ssp_pkg.stoppage_control (:new.absence_attendance_id);
    ssp_smp_pkg.stoppage_control (:new.maternity_id);
  end if;
end if;
END;



/
ALTER TRIGGER "APPS"."SSP_STP_T1" ENABLE;
