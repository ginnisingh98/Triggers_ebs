--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ASSIN_HIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ASSIN_HIST_BRI" 
-- $Header: pahrassn.sql 120.1.12010000.2 2008/08/22 16:20:26 mumohan ship $
BEFORE INSERT
ON "HR"."PER_ALL_ASSIGNMENTS_F"
FOR EACH ROW
DECLARE
  v_return_status varchar2(2000);
  v_error_message_code varchar2(2000);
BEGIN

    v_return_status  := FND_API.G_RET_STS_SUCCESS ;

    IF (PA_INSTALL.is_prm_licensed = 'Y' OR
        PA_INSTALL.is_utilization_implemented = 'Y') THEN

       -- check for assignment type is of primary assignment
       -- Bug 2917985 - Added check for assignment type of Employee
       -- and job_id not null.

       if (:new.primary_flag = 'Y' AND :new.assignment_type in ('E', 'C') AND
           :new.job_id is NOT NULL) then

          -- call the work flow to update pa objects

          pa_hr_update_pa_entities.update_project_entities(
             p_calling_mode       => 'INSERT'
            ,p_table_name         => 'PER_ALL_ASSIGNMENTS_F'
            ,p_person_id          => :new.person_id
            ,p_start_date_new     => :new.effective_start_date
            ,p_start_date_old     =>  NULL
            ,p_end_date_new       => :new.effective_end_date
            ,p_end_date_old       =>  NULL
            ,p_job_id_new         => :new.job_id
            ,p_job_id_old         =>  NULL
            ,p_org_id_new         => :new.organization_id
            ,p_org_id_old         =>  NULL
            ,p_supervisor_new     => :new.supervisor_id
            ,p_supervisor_old     => NULL
            ,p_primary_flag_new   => :new.primary_flag
            ,p_primary_flag_old   => NULL
            ,x_return_status      => v_return_status
            ,x_error_message_code => v_error_message_code);

       end if;
    END IF;

Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ASSIN_HIST_BRI" ENABLE;
