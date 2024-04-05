--------------------------------------------------------
--  DDL for Trigger CZ_PERSISTENT_REC_IDS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_PERSISTENT_REC_IDS_T1" 
  BEFORE UPDATE OR INSERT
 ON "CZ"."CZ_PERSISTENT_REC_IDS"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE
  VAR_USER_ID  INTEGER;
BEGIN
VAR_USER_ID:=CZ_UTILS.SPX_UID;
IF INSERTING THEN
   :new.CREATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.CREATION_DATE:=SYSDATE;
   :new.LAST_UPDATE_DATE:=SYSDATE;
   :new.last_update_login:=VAR_USER_ID;
END IF;
IF UPDATING THEN
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATE_DATE:=SYSDATE;
   :new.last_update_login:=VAR_USER_ID;
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_PERSISTENT_REC_IDS_T1" ENABLE;
