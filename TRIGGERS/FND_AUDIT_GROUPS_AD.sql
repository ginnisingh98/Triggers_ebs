--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_GROUPS_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_GROUPS_AD" AFTER DELETE ON "APPLSYS"."FND_AUDIT_GROUPS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN FND_AUDIT_GROUPS_ADP(:old.APPLICATION_ID,:old.AUDIT_GROUP_ID,:old.GROUP_NAME,:old.STATE,:new.APPLICATION_ID,:new.AUDIT_GROUP_ID,:new.GROUP_NAME,:new.STATE);END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_GROUPS_AD" ENABLE;
