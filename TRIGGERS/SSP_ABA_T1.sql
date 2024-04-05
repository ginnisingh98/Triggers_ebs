--------------------------------------------------------
--  DDL for Trigger SSP_ABA_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_ABA_T1" 
BEFORE INSERT
ON "HR"."PER_ABSENCE_ATTENDANCES"
FOR EACH ROW
   WHEN (
new.sickness_start_date is not null
) DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if ssp_ssp_pkg.ssp_is_installed then
    :new.linked_absence_id := ssp_ssp_pkg.linked_absence_id (
  	p_person_id => :new.person_id,
  	p_sickness_start_date => :new.sickness_start_date,
  	p_sickness_end_date => :new.sickness_end_date);
  end if;
end if;
END;


/
ALTER TRIGGER "APPS"."SSP_ABA_T1" ENABLE;
