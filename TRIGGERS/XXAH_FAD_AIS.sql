--------------------------------------------------------
--  DDL for Trigger XXAH_FAD_AIS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XXAH_FAD_AIS" 
AFTER INSERT ON "APPLSYS"."FND_ATTACHED_DOCUMENTS"
BEGIN
  xxah_attch_pkg.clear_fad_rowid;
EXCEPTION WHEN OTHERS THEN
  NULL;
END;


/
ALTER TRIGGER "APPS"."XXAH_FAD_AIS" ENABLE;
