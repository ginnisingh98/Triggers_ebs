--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_JOB_HIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_JOB_HIST_BRI" 
-- $Header: pahrjob.sql 120.0.12010000.4 2010/03/11 11:27:23 vgovvala ship $
BEFORE INSERT
ON "HR"."PER_JOB_EXTRA_INFO"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
BEGIN

    v_return_status := FND_API.G_RET_STS_SUCCESS;
   IF (PA_INSTALL.is_prm_licensed = 'Y' OR PA_INSTALL.is_utilization_implemented = 'Y') THEN
    --If :new.information_type = 'Job Category' then  /* Bug 6883041 */
    If :new.information_type = 'Job Category' and
       :new.jei_information3 = 'Y'  then
          -- call the work flow to update pa objects
         pa_hr_update_pa_entities.update_project_entities(
             p_calling_mode       => 'INSERT'
            ,p_table_name         => 'PER_JOB_EXTRA_INFO'
            ,p_job_id_new         => :new.job_id
            ,p_jei_information2_new => :new.jei_information2
            ,p_jei_information2_old => null
            ,p_jei_information3_old => null
            ,p_jei_information3_new => :new.jei_information3
            ,p_jei_information4_old => null
            ,p_jei_information4_new => :new.jei_information4
            ,p_jei_information6_old => null
            ,p_jei_information6_new => :new.jei_information6
            ,x_return_status      => v_return_status
            ,x_error_message_code => v_error_message_code);

   end if;
  END IF;



Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_JOB_HIST_BRI" ENABLE;
