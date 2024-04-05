--------------------------------------------------------
--  DDL for Trigger GMD_RECIPES_B_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RECIPES_B_AT" BEFORE UPDATE OF RECIPE_ID,DELETE_MARK,FORMULA_ID,OWNER_ID,RECIPE_NO,RECIPE_STATUS,RECIPE_VERSION,ROUTING_ID ON "GMD"."GMD_RECIPES_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_RECIPES_B_AT" ENABLE;
