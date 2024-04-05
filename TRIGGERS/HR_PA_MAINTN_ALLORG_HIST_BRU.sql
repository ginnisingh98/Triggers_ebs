--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ALLORG_HIST_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ALLORG_HIST_BRU" 
BEFORE UPDATE OF
 INACTIVE_DATE
ON "PA"."PA_ALL_ORGANIZATIONS"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
BEGIN
         v_return_status := FND_API.G_RET_STS_SUCCESS;
        IF (PA_INSTALL.is_prm_licensed = 'Y' OR
            PA_INSTALL.is_utilization_implemented = 'Y') THEN

           -- call the work flow to update pa objects
           -- Bug 2917985 - only for expenditure organizations.

           IF (:new.pa_org_use_type = 'EXPENDITURES' OR
               :old.pa_org_use_type = 'EXPENDITURES') THEN

              pa_hr_update_pa_entities.update_project_entities
                (p_calling_mode          => 'UPDATE'
                ,p_table_name            => 'PA_ALL_ORGANIZATIONS'
                ,p_org_id_new            => :new.organization_id
                ,p_org_info1_old         => :old.org_id
                ,p_org_info1_new         => :new.org_id
                ,p_inactive_date_old     => :old.inactive_date
                ,p_inactive_date_new     => :new.inactive_date
                ,x_return_status         => v_return_status
                ,x_error_message_code    => v_error_message_code
                );
           END IF;
        END IF;

Exception
	When OTHERS then
          raise;
END;


/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ALLORG_HIST_BRU" ENABLE;
