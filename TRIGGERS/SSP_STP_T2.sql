--------------------------------------------------------
--  DDL for Trigger SSP_STP_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_STP_T2" 
AFTER DELETE
ON "SSP"."SSP_STOPPAGES"
FOR EACH ROW
    WHEN (
old.user_entered = 'Y'
) DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if ssp_ssp_pkg.ssp_is_installed then
    ssp_ssp_pkg.stoppage_control (:old.absence_attendance_id);
    ssp_smp_pkg.stoppage_control (:old.maternity_id);
  end if;
end if;
END;



/
ALTER TRIGGER "APPS"."SSP_STP_T2" ENABLE;
