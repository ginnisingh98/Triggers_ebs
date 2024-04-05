--------------------------------------------------------
--  DDL for Trigger CZ_LOCALIZED_TEXTS_TP1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_TP1" 
BEFORE INSERT
ON "CZ"."CZ_LOCALIZED_TEXTS"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE

  v_persistent_id   cz_localized_texts.persistent_intl_text_id%TYPE;

BEGIN
  IF(:NEW.PERSISTENT_INTL_TEXT_ID IS NULL )THEN
    :new.PERSISTENT_INTL_TEXT_ID:=:new.INTL_TEXT_ID;
  END IF;

  v_persistent_id := :new.PERSISTENT_INTL_TEXT_ID;
  cz_model_migration_pvt.allocate_persistent_id(:new.MODEL_ID, v_persistent_id);
  :new.PERSISTENT_INTL_TEXT_ID := v_persistent_id;
END;

/
ALTER TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_TP1" ENABLE;
