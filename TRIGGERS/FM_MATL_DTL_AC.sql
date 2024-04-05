--------------------------------------------------------
--  DDL for Trigger FM_MATL_DTL_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_MATL_DTL_AC" BEFORE DELETE ON "GMD"."FM_MATL_DTL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FM_MATL_DTL_AC" ENABLE;
