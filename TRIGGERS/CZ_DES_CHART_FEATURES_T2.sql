--------------------------------------------------------
--  DDL for Trigger CZ_DES_CHART_FEATURES_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_DES_CHART_FEATURES_T2" 
  BEFORE UPDATE OR INSERT
 ON "CZ"."CZ_DES_CHART_FEATURES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN
IF INSERTING THEN
   UPDATE cz_devl_projects
   SET    last_logic_update = sysdate,
          post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
   WHERE  devl_project_id IN (SELECT model_id
			   FROM   cz_model_ref_expls
			   WHERE  model_ref_expl_id = :NEW.MODEL_REF_EXPL_ID
			   AND    deleted_flag = '0');
END IF;
IF UPDATING THEN
   UPDATE cz_devl_projects
   SET    last_logic_update = sysdate,
          post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
   WHERE  devl_project_id IN (SELECT model_id
			   FROM   cz_model_ref_expls
			   WHERE  model_ref_expl_id = :OLD.MODEL_REF_EXPL_ID
			   AND    deleted_flag = '0');
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_DES_CHART_FEATURES_T2" ENABLE;
