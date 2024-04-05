--------------------------------------------------------
--  DDL for Trigger IC_ITEM_CNV_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IC_ITEM_CNV_AT" BEFORE UPDATE OF CONVERSION_ID,ITEM_ID,LOT_ID,TYPE_FACTOR,UM_TYPE ON "GMI"."IC_ITEM_CNV" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."IC_ITEM_CNV_AT" ENABLE;
