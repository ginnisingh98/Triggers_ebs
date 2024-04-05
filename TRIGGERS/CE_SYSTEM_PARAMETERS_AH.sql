--------------------------------------------------------
--  DDL for Trigger CE_SYSTEM_PARAMETERS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CE_SYSTEM_PARAMETERS_AH" BEFORE INSERT ON "CE"."CE_SYSTEM_PARAMETERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."CE_SYSTEM_PARAMETERS_AH" ENABLE;
