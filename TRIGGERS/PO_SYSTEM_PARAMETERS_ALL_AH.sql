--------------------------------------------------------
--  DDL for Trigger PO_SYSTEM_PARAMETERS_ALL_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PO_SYSTEM_PARAMETERS_ALL_AH" BEFORE INSERT ON "PO"."PO_SYSTEM_PARAMETERS_ALL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."PO_SYSTEM_PARAMETERS_ALL_AH" ENABLE;
