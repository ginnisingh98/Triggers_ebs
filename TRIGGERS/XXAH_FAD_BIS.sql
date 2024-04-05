--------------------------------------------------------
--  DDL for Trigger XXAH_FAD_BIS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_FAD_BIS" 
BEFORE INSERT ON "APPLSYS"."FND_ATTACHED_DOCUMENTS"
BEGIN
  xxah_attch_pkg.init_fad_rowid;
EXCEPTION WHEN OTHERS THEN
  NULL;
END;


/
ALTER TRIGGER "APPS"."XXAH_FAD_BIS" ENABLE;
