--------------------------------------------------------
--  DDL for Trigger IC_ITEM_CNV_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IC_ITEM_CNV_AD" AFTER DELETE ON "GMI"."IC_ITEM_CNV" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN IC_ITEM_CNV_ADP(:old.CONVERSION_ID,:old.ITEM_ID,:old.LOT_ID,:old.TYPE_FACTOR,:old.UM_TYPE,:new.CONVERSION_ID,:new.ITEM_ID,:new.LOT_ID,:new.TYPE_FACTOR,:new.UM_TYPE);END IF;END;

/
ALTER TRIGGER "APPS"."IC_ITEM_CNV_AD" ENABLE;
