--------------------------------------------------------
--  DDL for Trigger FND_PROFILE_OPTION_VALUE_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_PROFILE_OPTION_VALUE_AH" BEFORE INSERT ON "APPLSYS"."FND_PROFILE_OPTION_VALUES" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FND_PROFILE_OPTION_VALUE_AH" ENABLE;
