--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_PJR_HIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_PJR_HIST_BRI" 
-- $Header: pahrpjr.sql 115.6 2002/07/09 13:41:12 amksingh ship $
BEFORE INSERT
ON "PA"."PA_JOB_RELATIONSHIPS"
FOR EACH ROW

DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
BEGIN

       v_return_status := FND_API.G_RET_STS_SUCCESS;
  IF (PA_INSTALL.is_prm_licensed = 'Y' OR PA_INSTALL.is_utilization_implemented = 'Y') THEN

        -- call the work flow to update pa objects
        pa_hr_update_pa_entities.update_project_entities(
             p_calling_mode              => 'INSERT'
            ,p_table_name                =>'PA_JOB_RELATIONSHIPS'
            ,p_to_job_id_new             => :new.to_job_id
            ,p_to_job_id_old             => NULL
            ,p_from_job_id_new           => :new.from_job_id
            ,p_from_job_id_old           => NULL
            ,p_to_job_group_id           => :new.to_job_group_id
            ,p_from_job_group_id         => :new.from_job_group_id
            ,x_return_status             => v_return_status
            ,x_error_message_code        => v_error_message_code);
  END IF;


Exception
	When OTHERS then
          raise;
END;



/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_PJR_HIST_BRI" ENABLE;
