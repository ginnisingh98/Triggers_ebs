--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_TABLES_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_TABLES_AI" AFTER INSERT ON "APPLSYS"."FND_AUDIT_TABLES" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN FND_AUDIT_TABLES_AIP(:old.AUDIT_GROUP_APP_ID,:old.AUDIT_GROUP_ID,:old.TABLE_APP_ID,:old.TABLE_ID,:old.STATE,:new.AUDIT_GROUP_APP_ID,:new.AUDIT_GROUP_ID,:new.TABLE_APP_ID,:new.TABLE_ID,:new.STATE);END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_TABLES_AI" ENABLE;
