--------------------------------------------------------
--  DDL for Trigger CZ_PS_NODES_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PS_NODES_T3" 
BEFORE UPDATE OF accumulator_flag
    ON "CZ"."CZ_PS_NODES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN
 IF (((:old.accumulator_flag IS NULL) <> (:new.accumulator_flag IS NULL)) OR
     (:old.accumulator_flag <> :new.accumulator_flag))THEN

   UPDATE CZ_DEVL_PROJECTS SET LAST_UPDATE_DATE = SYSDATE
   WHERE DEVL_PROJECT_ID=:new.DEVL_PROJECT_ID;
 END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PS_NODES_T3" ENABLE;
