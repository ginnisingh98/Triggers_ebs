--------------------------------------------------------
--  DDL for Trigger HR_PA_MAINTN_ORG_HIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAINTN_ORG_HIST_BRI" 
-- $Header: pahrorg.sql 120.3.12010000.2 2008/08/22 16:20:48 mumohan ship $
BEFORE INSERT
ON "HR"."HR_ORGANIZATION_INFORMATION"
FOR EACH ROW
DECLARE
  v_return_status      VARCHAR2(2000);
  v_error_message_code VARCHAR2(2000);
  l_pa_class           VARCHAR2(1) := 'N';
BEGIN

       v_return_status := FND_API.G_RET_STS_SUCCESS;

       -- Bug 2917985 - Added check for use of PJR/Utilization

       IF (PA_INSTALL.is_prm_licensed = 'Y' OR
           PA_INSTALL.is_utilization_implemented = 'Y') THEN

          -- if the organization is of type Expenditure type
          -- or Project Resource Job Group then
          -- call the work flow to update pa objects

          -- Add a check to see if the organization has a classification
          -- of PA Exp Org, since in R12, the OU can be entered for
          -- HR orgs also.  Only want to update if the info context is
          -- Exp Organization Defaults and the class of PA Exp Org
          -- exists, even if the update is happening via the HR class.

-- Commenting this check for bug 5410918: To avoid mutation errors.
-- This was done for update and delete triggers earlier.
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
          l_pa_class := 'Y'; -- Added for bug 5410918

          If (:new.org_information_context = 'Exp Organization Defaults' AND
              l_pa_class = 'Y') OR
             (:new.org_information_context = 'Project Resource Job Group') then

             pa_hr_update_pa_entities.update_project_entities(
                 p_calling_mode       => 'INSERT'
                ,p_table_name         => 'HR_ORGANIZATION_INFORMATION'
                ,p_org_id_new         => :new.organization_id
                ,p_org_info1_new      => :new.org_information1
                ,p_org_info1_old      => null
                ,p_org_info_context   => :new.org_information_context
                ,x_return_status      => v_return_status
                ,x_error_message_code => v_error_message_code);

          end if;
       END IF;

Exception
	When OTHERS then
          raise;
END;

/
ALTER TRIGGER "APPS"."HR_PA_MAINTN_ORG_HIST_BRI" ENABLE;
