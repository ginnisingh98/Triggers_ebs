--------------------------------------------------------
--  DDL for Trigger MTL_UOM_CONVERSIONS_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AI" AFTER INSERT ON "INV"."MTL_UOM_CONVERSIONS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN MTL_UOM_CONVERSIONS_AIP(:old.INVENTORY_ITEM_ID,:old.UNIT_OF_MEASURE,:old.CONVERSION_RATE,:old.DISABLE_DATE,:new.INVENTORY_ITEM_ID,:new.UNIT_OF_MEASURE,:new.CONVERSION_RATE,:new.DISABLE_DATE);END IF;END;

/
ALTER TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AI" ENABLE;
