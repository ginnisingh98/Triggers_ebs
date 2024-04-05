--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_SCHEMAS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_SCHEMAS_AH" BEFORE INSERT ON "APPLSYS"."FND_AUDIT_SCHEMAS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_SCHEMAS_AH" ENABLE;
