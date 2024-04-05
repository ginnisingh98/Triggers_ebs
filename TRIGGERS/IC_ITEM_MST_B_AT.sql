--------------------------------------------------------
--  DDL for Trigger IC_ITEM_MST_B_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IC_ITEM_MST_B_AT" BEFORE UPDATE OF ITEM_ID,DELETE_MARK,EXPERIMENTAL_IND,INACTIVE_IND,ITEM_NO,LOT_STATUS,QC_GRADE,RETEST_INTERVAL,SHELF_LIFE ON "GMI"."IC_ITEM_MST_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."IC_ITEM_MST_B_AT" ENABLE;
