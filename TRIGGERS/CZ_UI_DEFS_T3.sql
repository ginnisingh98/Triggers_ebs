--------------------------------------------------------
--  DDL for Trigger CZ_UI_DEFS_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_UI_DEFS_T3" 
  BEFORE INSERT OR UPDATE ON "CZ"."CZ_UI_DEFS"
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
DECLARE
  l_migration_flag  CZ_DEVL_PROJECTS.post_migr_change_flag%TYPE;
BEGIN
  IF :NEW.seeded_flag = '1' OR :NEW.master_template_flag = '1' THEN
    RETURN;
  END IF;

  SELECT NVL(post_migr_change_flag, 'L') INTO l_migration_flag
  FROM CZ_DEVL_PROJECTS
  WHERE devl_project_id = :NEW.devl_project_id;

  IF l_migration_flag = 'N' THEN
    UPDATE cz_devl_projects
    SET post_migr_change_flag = 'R'
    WHERE devl_project_id = :NEW.devl_project_id;
  END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_UI_DEFS_T3" ENABLE;
