--------------------------------------------------------
--  DDL for Trigger CZ_EFFECTIVITY_SETS_T3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_EFFECTIVITY_SETS_T3" 
   BEFORE UPDATE OF NAME, NOTE, DESCRIPTION, DELETED_FLAG
  ON "CZ"."CZ_EFFECTIVITY_SETS"
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
 DECLARE
   NAME_CHANGED INTEGER := 0;
   NOTE_CHANGED INTEGER := 0;
   DESCR_CHANGED INTEGER := 0;
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
   IF :OLD.DELETED_FLAG <> :NEW.DELETED_FLAG AND :NEW.DELETED_FLAG = '1' THEN
     DELETE FROM CZ_RP_ENTRIES
       WHERE OBJECT_TYPE = 'EFF' AND OBJECT_ID = :OLD.EFFECTIVITY_SET_ID;
   -- Check if there are any of 3 columns being updated
   ELSIF NAME_CHANGED+NOTE_CHANGED+DESCR_CHANGED > 0 THEN
     UPDATE CZ_RP_ENTRIES SET
        NAME   = DECODE(NAME_CHANGED, 1, :NEW.NAME, CZ_RP_ENTRIES.NAME),
        NOTES  = DECODE(NOTE_CHANGED, 1, :NEW.NOTE, CZ_RP_ENTRIES.NOTES),
        DESCRIPTION = DECODE(DESCR_CHANGED, 1, :NEW.DESCRIPTION, CZ_RP_ENTRIES.DESCRIPTION)
     WHERE OBJECT_TYPE='EFF' AND OBJECT_ID=:OLD.EFFECTIVITY_SET_ID;
   END IF;
 END;

/
ALTER TRIGGER "APPS"."CZ_EFFECTIVITY_SETS_T3" ENABLE;
