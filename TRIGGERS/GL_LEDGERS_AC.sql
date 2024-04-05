--------------------------------------------------------
--  DDL for Trigger GL_LEDGERS_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GL_LEDGERS_AC" BEFORE DELETE ON "GL"."GL_LEDGERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GL_LEDGERS_AC" ENABLE;
