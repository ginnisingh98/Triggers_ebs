--------------------------------------------------------
--  DDL for Trigger CZ_LOCALIZED_TEXTS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_T1" 
  BEFORE UPDATE OR INSERT
 ON "CZ"."CZ_LOCALIZED_TEXTS"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE
VAR_USER_ID INTEGER;
BEGIN
VAR_USER_ID:=CZ_UTILS.SPX_UID;
IF INSERTING THEN
   :new.CREATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.CREATION_DATE:=SYSDATE;
   :new.LAST_UPDATE_DATE:=SYSDATE;
END IF;
IF UPDATING THEN
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATE_DATE:=SYSDATE;
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_T1" ENABLE;
