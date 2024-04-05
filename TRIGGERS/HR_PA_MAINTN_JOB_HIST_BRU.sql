--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_JOB_HIST_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_JOB_HIST_BRU" 
BEFORE UPDATE OF
JEI_ATTRIBUTE2
,JEI_INFORMATION3
,JEI_INFORMATION4
,JEI_INFORMATION6
ON "HR"."PER_JOB_EXTRA_INFO"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
  l_exists             VARCHAR2(1) := 'N';
BEGIN
      v_return_status := FND_API.G_RET_STS_SUCCESS;

       -- Add an additional OR to check whether job already in
       -- pa_resources_denorm.
       BEGIN
       SELECT 'Y'
       INTO   l_exists
       FROM   dual
       WHERE  exists (SELECT 'Y'
                      FROM   pa_resources_denorm
                      WHERE  job_id = :new.job_id
                      AND    rownum = 1);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             l_exists := 'N';
       END;

       IF (l_exists = 'Y' OR
           PA_INSTALL.is_prm_licensed = 'Y' OR
           PA_INSTALL.is_utilization_implemented = 'Y') THEN

          If (:new.information_type = 'Job Category' OR
              :old.information_type = 'Job Category') AND
      ((nvl(:old.jei_information2,'N') <> nvl(:new.jei_information2,'N')) OR
       (nvl(:old.jei_information3,'N') <> nvl(:new.jei_information3,'N')) OR
       (nvl(:old.jei_information4,'N') <> nvl(:new.jei_information4,'N')) OR
       (nvl(:old.jei_information6,'N') <> nvl(:new.jei_information6,'N')))  then
          -- call the work flow to update pa objects
          pa_hr_update_pa_entities.update_project_entities(
             p_calling_mode       => 'UPDATE'
            ,p_table_name         => 'PER_JOB_EXTRA_INFO'
            ,p_job_id_new         => :new.job_id
            ,p_jei_information2_new => :new.jei_information2
            ,p_jei_information2_old => :old.jei_information2
            ,p_jei_information3_new => :new.jei_information3
            ,p_jei_information3_old => :old.jei_information3
            ,p_jei_information4_new => :new.jei_information4
            ,p_jei_information4_old => :old.jei_information4
            ,p_jei_information6_new => :new.jei_information6
            ,p_jei_information6_old => :old.jei_information6
            ,x_return_status      => v_return_status
            ,x_error_message_code => v_error_message_code);

   end if;
  END IF;

Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_JOB_HIST_BRU" ENABLE;
