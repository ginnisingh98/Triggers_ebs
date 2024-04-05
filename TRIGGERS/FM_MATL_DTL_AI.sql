--------------------------------------------------------
--  DDL for Trigger FM_MATL_DTL_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_MATL_DTL_AI" AFTER INSERT ON "GMD"."FM_MATL_DTL" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN FM_MATL_DTL_AIP(:old.FORMULALINE_ID,:old.CONTRIBUTE_STEP_QTY_IND,:old.FORMULA_ID,:old.ITEM_ID,:old.ITEM_UM,:old.LINE_NO,:old.LINE_TYPE,:old.PHANTOM_TYPE,:old.QTY,:old.RELEASE_TYPE,:old.SCALE_TYPE,:old.SCRAP_FACTOR,:new.FORMULALINE_ID,:new.CONTRIBUTE_STEP_QTY_IND,:new.FORMULA_ID,:new.ITEM_ID,:new.ITEM_UM,:new.LINE_NO,:new.LINE_TYPE,:new.PHANTOM_TYPE,:new.QTY,:new.RELEASE_TYPE,:new.SCALE_TYPE,:new.SCRAP_FACTOR);END IF;END;

/
ALTER TRIGGER "APPS"."FM_MATL_DTL_AI" ENABLE;
