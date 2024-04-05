--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_COLUMNS_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_COLUMNS_AI" AFTER INSERT ON "APPLSYS"."FND_AUDIT_COLUMNS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN FND_AUDIT_COLUMNS_AIP(:old.COLUMN_ID,:old.SCHEMA_ID,:old.TABLE_APP_ID,:old.TABLE_ID,:old.STATE,:new.COLUMN_ID,:new.SCHEMA_ID,:new.TABLE_APP_ID,:new.TABLE_ID,:new.STATE);END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_COLUMNS_AI" ENABLE;
