--------------------------------------------------------
--  DDL for Trigger XXAH_FAD_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_FAD_BI" 
BEFORE INSERT ON "APPLSYS"."FND_ATTACHED_DOCUMENTS"
FOR EACH ROW
BEGIN
  xxah_attch_pkg.add_fad_rowid( :NEW.attached_document_id );
EXCEPTION WHEN OTHERS THEN
  NULL;
END;


/
ALTER TRIGGER "APPS"."XXAH_FAD_BI" ENABLE;
