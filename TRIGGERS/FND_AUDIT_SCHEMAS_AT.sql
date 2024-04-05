--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_SCHEMAS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_SCHEMAS_AT" BEFORE UPDATE OF SCHEMA_ID,STATE ON "APPLSYS"."FND_AUDIT_SCHEMAS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_SCHEMAS_AT" ENABLE;
