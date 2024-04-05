--------------------------------------------------------
--  DDL for Trigger CZ_CONFIG_HDRS_TP1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_CONFIG_HDRS_TP1" 
BEFORE INSERT
ON "CZ"."CZ_CONFIG_HDRS"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN
	IF :NEW.PERSISTENT_COMPONENT_ID IS NULL THEN
   :new.PERSISTENT_COMPONENT_ID:=:NEW.COMPONENT_ID;
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_CONFIG_HDRS_TP1" ENABLE;
