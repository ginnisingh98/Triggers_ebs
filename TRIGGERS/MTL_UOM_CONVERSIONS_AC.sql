--------------------------------------------------------
--  DDL for Trigger MTL_UOM_CONVERSIONS_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AC" BEFORE DELETE ON "INV"."MTL_UOM_CONVERSIONS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."MTL_UOM_CONVERSIONS_AC" ENABLE;
