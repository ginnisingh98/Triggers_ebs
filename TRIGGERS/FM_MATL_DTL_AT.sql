--------------------------------------------------------
--  DDL for Trigger FM_MATL_DTL_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FM_MATL_DTL_AT" BEFORE UPDATE OF FORMULALINE_ID,CONTRIBUTE_STEP_QTY_IND,FORMULA_ID,ITEM_ID,ITEM_UM,LINE_NO,LINE_TYPE,PHANTOM_TYPE,QTY,RELEASE_TYPE,SCALE_TYPE,SCRAP_FACTOR ON "GMD"."FM_MATL_DTL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FM_MATL_DTL_AT" ENABLE;
