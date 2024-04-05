--------------------------------------------------------
--  DDL for Trigger FA_SYSTEM_CONTROLS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_SYSTEM_CONTROLS_AH" BEFORE INSERT ON "FA"."FA_SYSTEM_CONTROLS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FA_SYSTEM_CONTROLS_AH" ENABLE;
