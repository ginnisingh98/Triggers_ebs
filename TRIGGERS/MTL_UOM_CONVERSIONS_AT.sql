--------------------------------------------------------
--  DDL for Trigger MTL_UOM_CONVERSIONS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AT" BEFORE UPDATE OF INVENTORY_ITEM_ID,UNIT_OF_MEASURE,CONVERSION_RATE,DISABLE_DATE ON "INV"."MTL_UOM_CONVERSIONS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AT" ENABLE;
