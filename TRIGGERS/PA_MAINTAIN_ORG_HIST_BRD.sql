--------------------------------------------------------
--  DDL for Trigger PA_MAINTAIN_ORG_HIST_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PA_MAINTAIN_ORG_HIST_BRD" 
BEFORE DELETE
ON "HR"."PER_ORG_STRUCTURE_ELEMENTS"
FOR EACH ROW
DECLARE
  v_err_code number;
  v_err_stage varchar2(300);
  v_err_stack varchar2(300);
BEGIN
 if hr_general.g_data_migrator_mode <> 'Y' then
  IF (pa_imp.pa_implemented_all) THEN

    pa_org_utils.maintain_org_hist_brd(:old.org_structure_version_id,
				       :old.organization_id_child,
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
ALTER TRIGGER "APPS"."PA_MAINTAIN_ORG_HIST_BRD" ENABLE;
