--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ORG_HIST_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ORG_HIST_BRD" 
BEFORE DELETE
ON "HR"."HR_ORGANIZATION_INFORMATION"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
  l_exists             VARCHAR2(1) := 'N';
  l_pa_class           VARCHAR2(1) := 'N';
BEGIN

       v_return_status := FND_API.G_RET_STS_SUCCESS;

       -- Bug 2917985 - Added check for use of PJR/Utilization
       -- Add an additional OR to check whether resource's organization
       -- already in pa_resources_denorm.
       BEGIN
       SELECT 'Y'
       INTO   l_exists
       FROM   dual
       WHERE  exists (SELECT 'Y'
                      FROM   pa_resources_denorm
                      WHERE  resource_organization_id = :old.organization_id
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

          -- if the organization is of type Expenditure type then
          -- call the work flow to update pa objects

          -- Add a check to see if the organization has a classification
          -- of PA Exp Org, since in R12, the OU can be entered for
          -- HR orgs also.  Only want to update if the info context is
          -- Exp Organization Defaults and the class of PA Exp Org
          -- exists, even if the update is happening via the HR class.

          -- Fixed bug 4669716 - Have to comment out this check
          -- because of mutation errors. Cannot select from the
          -- same table that is being updated.

          /*
          BEGIN
          SELECT 'Y'
          INTO   l_pa_class
          FROM   hr_organization_information
          WHERE  organization_id = :new.organization_id
          AND    org_information1 = 'PA_EXPENDITURE_ORG'
          AND    org_information_context = 'CLASS'
          AND    rownum = 1;

          EXCEPTION WHEN NO_DATA_FOUND THEN
             l_pa_class := 'N';
          END;
          */

          l_pa_class := 'Y';

          If (:old.org_information_context = 'Exp Organization Defaults' AND
              l_pa_class = 'Y') OR
             :old.org_information_context = 'Project Resource Job Group' Then

            pa_hr_update_pa_entities.update_project_entities(
                p_calling_mode       => 'DELETE'
               ,p_table_name         => 'HR_ORGANIZATION_INFORMATION'
               ,p_org_id_new         => :old.organization_id
               ,p_org_info1_new      => NULL
               ,p_org_info1_old      => :old.org_information1
               ,p_org_info_context   => :old.org_information_context
               ,x_return_status      => v_return_status
               ,x_error_message_code => v_error_message_code);

          end if;
       END IF;
Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ORG_HIST_BRD" ENABLE;
