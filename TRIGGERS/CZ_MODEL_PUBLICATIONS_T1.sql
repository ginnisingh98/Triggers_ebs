--------------------------------------------------------
--  DDL for Trigger CZ_MODEL_PUBLICATIONS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_MODEL_PUBLICATIONS_T1" 
BEFORE INSERT OR UPDATE
ON "CZ"."CZ_MODEL_PUBLICATIONS"
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
VAR_USER_ID INTEGER;
VAR_PERS_PROJ_ID  CZ_DEVL_PROJECTS.PERSISTENT_PROJECT_ID%TYPE;
BEGIN
VAR_USER_ID:=CZ_UTILS.SPX_UID;

IF INSERTING THEN
   IF (:NEW.OBJECT_TYPE = 'PRJ') THEN
       	SELECT last_logic_update,
               last_struct_update,
               last_update_date,
               persistent_project_id
        INTO :new.model_last_logic_update,
             :new.model_last_struct_update,
             :new.model_last_updated,
             var_pers_proj_id
        FROM cz_devl_projects
     	WHERE cz_devl_projects.devl_project_id = :NEW.OBJECT_ID;

        IF :NEW.MODEL_PERSISTENT_ID IS NULL THEN
           :new.MODEL_PERSISTENT_ID:=var_pers_proj_id;
        END IF;

   ELSIF (:NEW.OBJECT_TYPE = 'TMP') THEN
     SELECT last_update_date
     INTO  :new.model_last_updated
     FROM  cz_ui_templates
     WHERE cz_ui_templates.template_id = :NEW.OBJECT_ID;
   END IF;

   :NEW.CREATED_BY:=VAR_USER_ID;
   :NEW.LAST_UPDATED_BY:=VAR_USER_ID;
   :NEW.CREATION_DATE:=SYSDATE;
   :NEW.LAST_UPDATE_DATE:=SYSDATE;
END IF;

IF UPDATING THEN
   :NEW.LAST_UPDATED_BY:=VAR_USER_ID;
   :NEW.LAST_UPDATE_DATE:=SYSDATE;
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_MODEL_PUBLICATIONS_T1" ENABLE;
