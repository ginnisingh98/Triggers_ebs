--------------------------------------------------------
--  DDL for Trigger SSP_PER_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."SSP_PER_T1" 
AFTER INSERT OR UPDATE
OF DATE_OF_BIRTH
,  DATE_OF_DEATH
ON "HR"."PER_ALL_PEOPLE_F"
FOR EACH ROW
DECLARE
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
  if ssp_ssp_pkg.ssp_is_installed then

    ssp_smp_pkg.person_control (:new.person_id,
  			:new.date_of_death);

    ssp_ssp_pkg.person_control (:new.person_id,
  			:new.date_of_death,
  			:new.date_of_birth);

  end if;
end if;
END;


/
ALTER TRIGGER "APPS"."SSP_PER_T1" ENABLE;
