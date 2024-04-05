--------------------------------------------------------
--  DDL for Trigger GL_LEDGERS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GL_LEDGERS_AH" BEFORE INSERT ON "GL"."GL_LEDGERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GL_LEDGERS_AH" ENABLE;
