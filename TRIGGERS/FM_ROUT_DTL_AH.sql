--------------------------------------------------------
--  DDL for Trigger FM_ROUT_DTL_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_ROUT_DTL_AH" BEFORE INSERT ON "GMD"."FM_ROUT_DTL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FM_ROUT_DTL_AH" ENABLE;
