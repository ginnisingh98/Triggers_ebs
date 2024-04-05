--------------------------------------------------------
--  DDL for Trigger BOM_BRDI_UNIQUE_ID_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."BOM_BRDI_UNIQUE_ID_T" 

BEFORE INSERT
    ON "BOM"."BOM_REF_DESGS_INTERFACE"
FOR EACH ROW

DECLARE
    l_date DATE := SYSDATE;
BEGIN
    :NEW.LAST_UPDATE_DATE   := l_date;
    :NEW.CREATION_DATE      := l_date;
    IF :NEW.INTERFACE_TABLE_UNIQUE_ID IS NULL THEN
        SELECT EGO_IMPORT_ROW_SEQ_S.NEXTVAL
        INTO :NEW.INTERFACE_TABLE_UNIQUE_ID
        FROM DUAL;
    END IF;

END BOM_BRDI_UNIQUE_ID_T;


/
ALTER TRIGGER "APPS"."BOM_BRDI_UNIQUE_ID_T" ENABLE;
