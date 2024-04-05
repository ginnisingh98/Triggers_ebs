--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ASSIN_HIST_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ASSIN_HIST_BRU" 
BEFORE UPDATE OF
	Effective_start_date
	,Effective_end_date
	,Organization_id
	,Supervisor_id
	,Primary_flag
	,Job_id
ON "HR"."PER_ALL_ASSIGNMENTS_F"
FOR EACH ROW
DECLARE
  v_return_status varchar2(2000);
  v_error_message_code varchar2(2000);
  l_exists             VARCHAR2(1) := 'N';

BEGIN

    v_return_status  := FND_API.G_RET_STS_SUCCESS ;
       -- Add an additional OR to check whether resource already in
       -- pa_resources_denorm.
       BEGIN
       SELECT 'Y'
       INTO   l_exists
       FROM   dual
       WHERE  exists (SELECT 'Y'
                      FROM   pa_resources_denorm
                      WHERE  person_id = :new.person_id
                      AND    rownum = 1);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             l_exists := 'N';
       END;

       IF (l_exists = 'Y' OR
           PA_INSTALL.is_prm_licensed = 'Y' OR
           PA_INSTALL.is_utilization_implemented = 'Y') THEN

       -- check for assignment type is of primary assignment
       -- Bug 2917985 - Added check for assignment type of Employee

       IF (:new.assignment_type in('E', 'C') OR
           :old.assignment_type in ('E', 'C')) THEN
          if :new.primary_flag = 'Y' or :old.primary_flag = 'Y' then

             -- Add check for job to prevent unnecessary WF's being spawned.
             -- Bug 4496062
             IF (:new.job_id IS NOT NULL or :old.job_id IS NOT NULL) THEN

                -- call the work flow to update pa objects

                pa_hr_update_pa_entities.update_project_entities (
                   p_calling_mode       => 'UPDATE'
                  ,p_table_name         => 'PER_ALL_ASSIGNMENTS_F'
                  ,p_person_id          => :new.person_id
                  ,p_start_date_new     => :new.effective_start_date
                  ,p_start_date_old     => :old.effective_start_date
                  ,p_end_date_new       => :new.effective_end_date
                  ,p_end_date_old       => :old.effective_end_date
                  ,p_job_id_new         => :new.job_id
                  ,p_job_id_old         => :old.job_id
                  ,p_org_id_new         => :new.organization_id
                  ,p_org_id_old         => :old.organization_id
                  ,p_supervisor_new     => :new.supervisor_id
                  ,p_supervisor_old     => :old.supervisor_id
                  ,p_primary_flag_new   => :new.primary_flag
                  ,p_primary_flag_old   => :old.primary_flag
                  ,x_return_status      => v_return_status
                  ,x_error_message_code => v_error_message_code);

             END IF;
          end if;
       END IF;
    END IF;
Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ASSIN_HIST_BRU" ENABLE;
