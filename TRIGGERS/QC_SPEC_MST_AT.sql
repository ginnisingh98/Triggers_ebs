--------------------------------------------------------
--  DDL for Trigger QC_SPEC_MST_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."QC_SPEC_MST_AT" BEFORE UPDATE OF QC_SPEC_ID,ASSAY_CODE,DELETE_MARK,FROM_DATE,ITEM_ID,LOCATION,LOT_ID,MAX_SPEC,MIN_SPEC,OUTACTION_CODE,OUTACTION_INTERVAL,PREFERENCE,TARGET_SPEC,TEXT_SPEC,TO_DATE,WHSE_CODE ON "GMD"."QC_SPEC_MST" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."QC_SPEC_MST_AT" ENABLE;
