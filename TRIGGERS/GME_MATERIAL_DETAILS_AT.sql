--------------------------------------------------------
--  DDL for Trigger GME_MATERIAL_DETAILS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GME_MATERIAL_DETAILS_AT" BEFORE UPDATE OF MATERIAL_DETAIL_ID,ACTUAL_QTY,BATCH_ID,ITEM_UM,LINE_NO,LINE_TYPE,ORIGINAL_QTY,PLAN_QTY,WIP_PLAN_QTY ON "GME"."GME_MATERIAL_DETAILS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GME_MATERIAL_DETAILS_AT" ENABLE;
