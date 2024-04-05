--------------------------------------------------------
--  DDL for Trigger FM_FORM_MST_B_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_FORM_MST_B_AI" AFTER INSERT ON "GMD"."FM_FORM_MST_B" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN FM_FORM_MST_B_AIP(:old.FORMULA_ID,:old.DELETE_MARK,:old.FORMULA_CLASS,:old.FORMULA_NO,:old.FORMULA_STATUS,:old.FORMULA_VERS,:old.ORGN_CODE,:old.OWNER_ID,:old.SCALE_TYPE,:new.FORMULA_ID,:new.DELETE_MARK,:new.FORMULA_CLASS,:new.FORMULA_NO,:new.FORMULA_STATUS,:new.FORMULA_VERS,:new.ORGN_CODE,:new.OWNER_ID,:new.SCALE_TYPE);END IF;END;

/
ALTER TRIGGER "APPS"."FM_FORM_MST_B_AI" ENABLE;
