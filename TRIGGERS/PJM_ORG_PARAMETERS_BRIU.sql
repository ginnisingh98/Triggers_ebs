--------------------------------------------------------
--  DDL for Trigger PJM_ORG_PARAMETERS_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PJM_ORG_PARAMETERS_BRIU" 
/* $Header: pjmt001.sql 115.3 99/09/04 11:12:44 porting s $ */
BEFORE INSERT OR UPDATE ON "PJM"."PJM_ORG_PARAMETERS"
FOR EACH ROW
    WHEN (  nvl(old.project_reference_enabled,'@') <> nvl(new.project_reference_enabled,'@')
     OR nvl(old.project_control_level,0) <> nvl(new.project_control_level,0)
     OR nvl(old.payback_mat_var_account,0) <> nvl(new.payback_mat_var_account,0)
     OR nvl(old.payback_moh_var_account,0) <> nvl(new.payback_moh_var_account,0)
     OR nvl(old.payback_res_var_account,0) <> nvl(new.payback_res_var_account,0)
     OR nvl(old.payback_osp_var_account,0) <> nvl(new.payback_osp_var_account,0)
     OR nvl(old.payback_ovh_var_account,0) <> nvl(new.payback_ovh_var_account,0)
     ) DECLARE

  dummy number;
  record_lock_exception EXCEPTION;
  pragma exception_init(record_lock_exception,  -0054);

BEGIN

  SELECT project_reference_enabled
  INTO   dummy
  FROM   mtl_parameters
  WHERE  organization_id = :new.organization_id
  FOR UPDATE of project_reference_enabled NOWAIT;

  UPDATE mtl_parameters
  SET    project_reference_enabled =
           decode(:new.project_reference_enabled,'Y', 1, 2)
  ,      project_control_level    = :new.project_control_level
  ,      borrpay_matl_var_account = :new.payback_mat_var_account
  ,      borrpay_moh_var_account  = :new.payback_moh_var_account
  ,      borrpay_res_var_account  = :new.payback_res_var_account
  ,      borrpay_osp_var_account  = :new.payback_osp_var_account
  ,      borrpay_ovh_var_account  = :new.payback_ovh_var_account
  ,      last_update_date         = :new.last_update_date
  ,      last_updated_by          = :new.last_updated_by
  ,      last_update_login        = :new.last_update_login
  WHERE  organization_id = :new.organization_id;

EXCEPTION
  WHEN record_lock_exception THEN
    fnd_message.set_name('PJM', 'GEN-UNABLE TO LOCK INVPARAM');
    app_exception.raise_exception;

END;



/
ALTER TRIGGER "APPS"."PJM_ORG_PARAMETERS_BRIU" ENABLE;
