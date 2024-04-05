--------------------------------------------------------
--  DDL for Trigger GMD_SPECIFICATIONS_B_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_SPECIFICATIONS_B_AT" BEFORE UPDATE OF SPEC_ID,ITEM_ID,SPEC_NAME,SPEC_STATUS,SPEC_VERS ON "GMD"."GMD_SPECIFICATIONS_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_SPECIFICATIONS_B_AT" ENABLE;
