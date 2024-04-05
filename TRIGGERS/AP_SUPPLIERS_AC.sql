--------------------------------------------------------
--  DDL for Trigger AP_SUPPLIERS_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_SUPPLIERS_AC" BEFORE DELETE ON "AP"."AP_SUPPLIERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."AP_SUPPLIERS_AC" ENABLE;
