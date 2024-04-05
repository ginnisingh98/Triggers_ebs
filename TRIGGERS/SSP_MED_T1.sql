--------------------------------------------------------
--  DDL for Trigger SSP_MED_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_MED_T1" 
AFTER INSERT OR DELETE OR UPDATE
OF ACCEPT_LATE_EVIDENCE_FLAG
,  EVIDENCE_RECEIVED_DATE
,  EVIDENCE_STATUS
ON "SSP"."SSP_MEDICALS"
FOR EACH ROW
   WHEN (
(old.evidence_status = 'CURRENT'
         or new.evidence_status = 'CURRENT')
) DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if ssp_ssp_pkg.ssp_is_installed then
    ssp_smp_pkg.medical_control (nvl (:old.maternity_id,:new.maternity_id));
    ssp_ssp_pkg.medical_control (nvl (:old.absence_attendance_id,
                                      :new.absence_attendance_id));
  end if;
end if;
END;


/
ALTER TRIGGER "APPS"."SSP_MED_T1" ENABLE;
