--------------------------------------------------------
--  DDL for Trigger CZ_PS_NODES_T6
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PS_NODES_T6" 
 BEFORE UPDATE OF name ON "CZ"."CZ_PS_NODES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN
 IF(((:old.name IS NULL) <> (:new.name IS NULL)) OR (:old.name <> :new.name))THEN

       UPDATE CZ_DEVL_PROJECTS SET
         post_migr_change_flag = DECODE(post_migr_change_flag, 'N', 'R', 'Z', 'R', post_migr_change_flag)
       WHERE
         DEVL_PROJECT_ID=:new.DEVL_PROJECT_ID;
 END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PS_NODES_T6" ENABLE;
