--------------------------------------------------------
--  DDL for Trigger GMD_RECIPES_B_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RECIPES_B_AI" AFTER INSERT ON "GMD"."GMD_RECIPES_B" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN GMD_RECIPES_B_AIP(:old.RECIPE_ID,:old.DELETE_MARK,:old.FORMULA_ID,:old.OWNER_ID,:old.RECIPE_NO,:old.RECIPE_STATUS,:old.RECIPE_VERSION,:old.ROUTING_ID,:new.RECIPE_ID,:new.DELETE_MARK,:new.FORMULA_ID,:new.OWNER_ID,:new.RECIPE_NO,:new.RECIPE_STATUS,:new.RECIPE_VERSION,:new.ROUTING_ID);END IF;END;

/
ALTER TRIGGER "APPS"."GMD_RECIPES_B_AI" ENABLE;
