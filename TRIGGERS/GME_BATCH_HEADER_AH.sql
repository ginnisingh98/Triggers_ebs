--------------------------------------------------------
--  DDL for Trigger GME_BATCH_HEADER_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GME_BATCH_HEADER_AH" BEFORE INSERT ON "GME"."GME_BATCH_HEADER" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GME_BATCH_HEADER_AH" ENABLE;
