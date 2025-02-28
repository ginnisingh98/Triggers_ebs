--------------------------------------------------------
--  DDL for Trigger CZ_MODEL_USAGES_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_MODEL_USAGES_T3" 
 BEFORE UPDATE OF NAME, NOTE, DESCRIPTION, IN_USE
 ON "CZ"."CZ_MODEL_USAGES"
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
DECLARE
  NAME_CHANGED	INTEGER := 0;
  NOTE_CHANGED	INTEGER := 0;
  DESCR_CHANGED	INTEGER := 0;
  IN_USE_CHANGED	INTEGER := 0;
BEGIN
  IF :OLD.NAME <> :NEW.NAME THEN
    NAME_CHANGED := 1;
  END IF;
  IF ( ( (:old.note IS NULL)<>(:new.note IS NULL) ) OR (:old.note <>:new.note) ) THEN
    NOTE_CHANGED := 1;
  END IF;
  IF ( ( (:old.description IS NULL)<>(:new.description IS NULL) ) OR (:old.description <>:new.description) ) THEN
    DESCR_CHANGED := 1;
  END IF;
  IF :OLD.IN_USE <> :NEW.IN_USE THEN
    IN_USE_CHANGED := 1;
  END IF;
-- Check if there are any of 4 columns being updated
  IF NAME_CHANGED+NOTE_CHANGED+DESCR_CHANGED+IN_USE_CHANGED > 0 THEN
    UPDATE CZ_RP_ENTRIES SET
       NAME		= DECODE(NAME_CHANGED, 1, :NEW.NAME, CZ_RP_ENTRIES.NAME),
       NOTES		= DECODE(NOTE_CHANGED, 1, :NEW.NOTE, CZ_RP_ENTRIES.NOTES),
       DESCRIPTION	= DECODE(DESCR_CHANGED, 1, :NEW.DESCRIPTION, CZ_RP_ENTRIES.DESCRIPTION),
       DELETED_FLAG	= DECODE(IN_USE_CHANGED, 1, DECODE(:NEW.IN_USE, 'X', '1', '0'),
                           CZ_RP_ENTRIES.DELETED_FLAG)
    WHERE OBJECT_TYPE='USG' AND OBJECT_ID=:OLD.MODEL_USAGE_ID;
  END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_MODEL_USAGES_T3" ENABLE;
