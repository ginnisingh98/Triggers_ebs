--------------------------------------------------------
--  DDL for Trigger FND_AUDIT_GROUPS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_AUDIT_GROUPS_AH" BEFORE INSERT ON "APPLSYS"."FND_AUDIT_GROUPS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FND_AUDIT_GROUPS_AH" ENABLE;
