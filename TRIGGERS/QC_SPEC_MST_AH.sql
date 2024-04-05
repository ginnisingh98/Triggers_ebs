--------------------------------------------------------
--  DDL for Trigger QC_SPEC_MST_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."QC_SPEC_MST_AH" BEFORE INSERT ON "GMD"."QC_SPEC_MST" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."QC_SPEC_MST_AH" ENABLE;
