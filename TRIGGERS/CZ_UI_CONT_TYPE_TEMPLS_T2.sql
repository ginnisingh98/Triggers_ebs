--------------------------------------------------------
--  DDL for Trigger CZ_UI_CONT_TYPE_TEMPLS_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_UI_CONT_TYPE_TEMPLS_T2" 
  BEFORE INSERT OR UPDATE ON "CZ"."CZ_UI_CONT_TYPE_TEMPLS"
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
BEGIN
  UPDATE CZ_UI_DEFS
  SET content_last_update_date = SYSDATE
  WHERE ui_def_id = :NEW.ui_def_id;
END;

/
ALTER TRIGGER "APPS"."CZ_UI_CONT_TYPE_TEMPLS_T2" ENABLE;
