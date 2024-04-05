--------------------------------------------------------
--  DDL for Trigger CZ_RULE_FOLDERS_TP1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_RULE_FOLDERS_TP1" 
BEFORE INSERT
ON "CZ"."CZ_RULE_FOLDERS"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN
	IF :NEW.PERSISTENT_RULE_FOLDER_ID IS NULL THEN
   :new.PERSISTENT_RULE_FOLDER_ID:=:NEW.RULE_FOLDER_ID;
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_RULE_FOLDERS_TP1" ENABLE;
