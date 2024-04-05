--------------------------------------------------------
--  DDL for Trigger IC_ITEM_MST_B_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IC_ITEM_MST_B_AI" AFTER INSERT ON "GMI"."IC_ITEM_MST_B" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN IC_ITEM_MST_B_AIP(:old.ITEM_ID,:old.DELETE_MARK,:old.EXPERIMENTAL_IND,:old.INACTIVE_IND,:old.ITEM_NO,:old.LOT_STATUS,:old.QC_GRADE,:old.RETEST_INTERVAL,:old.SHELF_LIFE,:new.ITEM_ID,:new.DELETE_MARK,:new.EXPERIMENTAL_IND,:new.INACTIVE_IND,:new.ITEM_NO,:new.LOT_STATUS,:new.QC_GRADE,:new.RETEST_INTERVAL,:new.SHELF_LIFE);END IF;END;

/
ALTER TRIGGER "APPS"."IC_ITEM_MST_B_AI" ENABLE;
