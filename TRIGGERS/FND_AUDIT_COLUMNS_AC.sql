--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_COLUMNS_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_COLUMNS_AC" BEFORE DELETE ON "APPLSYS"."FND_AUDIT_COLUMNS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_COLUMNS_AC" ENABLE;
