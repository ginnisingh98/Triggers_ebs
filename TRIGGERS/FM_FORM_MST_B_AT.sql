--------------------------------------------------------
--  DDL for Trigger FM_FORM_MST_B_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_FORM_MST_B_AT" BEFORE UPDATE OF FORMULA_ID,DELETE_MARK,FORMULA_CLASS,FORMULA_NO,FORMULA_STATUS,FORMULA_VERS,ORGN_CODE,OWNER_ID,SCALE_TYPE ON "GMD"."FM_FORM_MST_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FM_FORM_MST_B_AT" ENABLE;
