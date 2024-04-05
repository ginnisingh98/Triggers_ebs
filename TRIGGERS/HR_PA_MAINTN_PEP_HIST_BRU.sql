--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_PEP_HIST_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_PEP_HIST_BRU" 
-- $Header: pahrpep.sql 120.1 2005/06/16 18:15:23 appldev  $
BEFORE UPDATE OF
FULL_NAME
ON "HR"."PER_ALL_PEOPLE_F"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
  l_exists             VARCHAR2(1) := 'N';
BEGIN

          v_return_status := FND_API.G_RET_STS_SUCCESS ;
       -- Add an additional OR to check whether person already in
       -- pa_resources_denorm.
       BEGIN
       SELECT 'Y'
       INTO   l_exists
       FROM   dual
       WHERE  exists (SELECT 'Y'
                      FROM   pa_resources_denorm
                      WHERE  person_id = :new.person_id
                      AND    rownum = 1)
          OR  exists (SELECT 'Y'
                      FROM   pa_resources_denorm
                      WHERE  manager_id = :new.person_id
                      AND    rownum = 1)
          OR  exists (SELECT 'Y'
                      FROM   pa_resource_txn_attributes
                      WHERE  person_id = :new.person_id
                      AND    rownum = 1);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
             l_exists := 'N';
       END;

       IF (l_exists = 'Y') THEN  -- Bug 4387456 - only update if person exists
           -- PA_INSTALL.is_prm_licensed = 'Y' OR
           -- PA_INSTALL.is_utilization_implemented = 'Y') THEN

          -- call the work flow to update pa objects
         pa_hr_update_pa_entities.update_project_entities(
             p_calling_mode       => 'UPDATE'
            ,p_table_name         => 'PER_ALL_PEOPLE_F'
            ,p_person_id          => :new.person_id
            ,p_full_name_new      => :new.full_Name
            ,p_full_name_old      => :old.full_Name
            ,x_return_status      => v_return_status
            ,x_error_message_code => v_error_message_code);
      END IF;


Exception
	When OTHERS then
          raise;
END;


/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_PEP_HIST_BRU" ENABLE;
