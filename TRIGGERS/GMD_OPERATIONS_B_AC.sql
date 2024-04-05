--------------------------------------------------------
--  DDL for Trigger GMD_OPERATIONS_B_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_OPERATIONS_B_AC" BEFORE DELETE ON "GMD"."GMD_OPERATIONS_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_OPERATIONS_B_AC" ENABLE;
