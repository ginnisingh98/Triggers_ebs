--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ASSIN_HIST_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ASSIN_HIST_BRD" 
BEFORE DELETE
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
                      WHERE  person_id = :old.person_id
                      AND    rownum = 1);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             l_exists := 'N';
       END;

       /*Commenting below for bug 7118880*/
--       IF (l_exists = 'Y' OR
--           PA_INSTALL.is_prm_licensed = 'Y' OR
--           PA_INSTALL.is_utilization_implemented = 'Y') THEN


       IF (l_exists = 'Y') THEN -- changed IF condn for Bug 7118880

       -- check for assignment type is of primary assignment

       IF (:old.assignment_type in ('E', 'C')) THEN
          if :old.primary_flag = 'Y' then

             -- call the work flow to delete pa entry

             pa_hr_update_pa_entities.update_project_entities (
                p_calling_mode       => 'DELETE'
               ,p_table_name         => 'PER_ALL_ASSIGNMENTS_F'
               ,p_person_id          => :old.person_id
               ,p_start_date_old     => :old.effective_start_date
               ,p_end_date_old       => :old.effective_end_date
               ,x_return_status      => v_return_status
               ,x_error_message_code => v_error_message_code);

          end if;
       END IF;
    END IF;
Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ASSIN_HIST_BRD" ENABLE;
