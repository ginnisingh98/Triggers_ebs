--------------------------------------------------------
--  DDL for Trigger CZ_LOCALIZED_TEXTS_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_T2" 
BEFORE UPDATE OR INSERT
ON "CZ"."CZ_LOCALIZED_TEXTS"
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
BEGIN
     IF INSERTING THEN
          IF :new.MODEL_ID IS NULL THEN
             raise_application_error(-20101, ' CZ_LOCALIZED_TEXTS.MODEL_ID CANNOT BE NULL on INSERT');
          END IF;
     END IF;
     IF UPDATING AND :new.deleted_flag = '0' THEN
          IF :new.MODEL_ID IS NULL THEN
             raise_application_error(-20101, ' CZ_LOCALIZED_TEXTS.MODEL_ID CANNOT BE NULL on UPDATE');
          END IF;
     END IF;
END;

/
ALTER TRIGGER "APPS"."CZ_LOCALIZED_TEXTS_T2" ENABLE;
