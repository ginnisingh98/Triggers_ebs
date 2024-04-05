--------------------------------------------------------
--  DDL for Trigger GMD_ROUTINGS_B_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_ROUTINGS_B_AH" BEFORE INSERT ON "GMD"."GMD_ROUTINGS_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_ROUTINGS_B_AH" ENABLE;
