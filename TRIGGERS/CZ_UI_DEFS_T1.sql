--------------------------------------------------------
--  DDL for Trigger CZ_UI_DEFS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_UI_DEFS_T1" 
  BEFORE UPDATE OR INSERT
 ON "CZ"."CZ_UI_DEFS"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE
VAR_USER_ID INTEGER;
l_profile_value VARCHAR2(100);
BEGIN
VAR_USER_ID:=CZ_UTILS.SPX_UID;

IF INSERTING THEN
   :new.CREATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.CREATION_DATE:=SYSDATE;
   :new.LAST_UPDATE_DATE:=SYSDATE;
  l_profile_value := FND_PROFILE.value('CZ_EDIT_MODELS_NO_LOCK');
   IF (l_profile_value = 'N') THEN
     :new.checkout_user := FND_GLOBAL.user_name;
   END IF;
END IF;
IF UPDATING THEN
   :new.LAST_UPDATED_BY:=VAR_USER_ID;
   :new.LAST_UPDATE_DATE:=SYSDATE;
END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_UI_DEFS_T1" ENABLE;
