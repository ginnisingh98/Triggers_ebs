--------------------------------------------------------
--  DDL for Trigger RCV_PARAMETERS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."RCV_PARAMETERS_AH" BEFORE INSERT ON "PO"."RCV_PARAMETERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."RCV_PARAMETERS_AH" ENABLE;
