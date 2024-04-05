--------------------------------------------------------
--  DDL for Trigger HR_PA_MAIN_ORG_INFO_HIST_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_PA_MAIN_ORG_INFO_HIST_BRI" 
-- $Header: perpaorg.sql 115.0 2001/02/21 02:46:50 pkm ship        $
BEFORE INSERT OR UPDATE
OF org_information2
ON "HR"."HR_ORGANIZATION_INFORMATION"
FOR EACH ROW

DECLARE
  v_err_code number;
  v_err_stage varchar2(300);
  v_err_stack varchar2(300);
BEGIN

   IF (:new.org_information_context = 'CLASS'
     and   (:new.org_information1 = 'PA_PROJECT_ORG'
           or   :new.org_information1 = 'PA_EXPENDITURE_ORG')) Then
   IF (pa_imp.pa_implemented_all) THEN

      pa_org_utils.maintain_org_info_hist_bri (	:new.organization_id,
				       :new.org_information1,
				       :new.org_information_context,
				       :new.org_information2,
				       v_err_code,
				       v_err_stage,
				       v_err_stack);
    if  v_err_code < 0 then
      fnd_message.set_name('PA', 'PA_ALL_ORACLE_ERROR');
      fnd_message.set_token('errno', to_char(v_err_code));
      fnd_message.set_token('stage', v_err_stage);
      app_exception.raise_exception;
    elsif v_err_code > 0 then
      fnd_message.set_name('PA', v_err_stage);
      app_exception.raise_exception;
    end if;

  END IF;
 end if;
END;



/
ALTER TRIGGER "APPS"."HR_PA_MAIN_ORG_INFO_HIST_BRI" ENABLE;
