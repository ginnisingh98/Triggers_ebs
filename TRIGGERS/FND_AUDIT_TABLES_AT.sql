--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_TABLES_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_TABLES_AT" BEFORE UPDATE OF AUDIT_GROUP_APP_ID,AUDIT_GROUP_ID,TABLE_APP_ID,TABLE_ID,STATE ON "APPLSYS"."FND_AUDIT_TABLES" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_TABLES_AT" ENABLE;
