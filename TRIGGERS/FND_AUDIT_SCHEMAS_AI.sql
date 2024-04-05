--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_SCHEMAS_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_SCHEMAS_AI" AFTER INSERT ON "APPLSYS"."FND_AUDIT_SCHEMAS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN FND_AUDIT_SCHEMAS_AIP(:old.SCHEMA_ID,:old.STATE,:new.SCHEMA_ID,:new.STATE);END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_SCHEMAS_AI" ENABLE;
