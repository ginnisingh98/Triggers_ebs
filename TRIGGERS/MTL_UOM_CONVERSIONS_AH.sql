--------------------------------------------------------
--  DDL for Trigger MTL_UOM_CONVERSIONS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AH" BEFORE INSERT ON "INV"."MTL_UOM_CONVERSIONS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AH" ENABLE;
