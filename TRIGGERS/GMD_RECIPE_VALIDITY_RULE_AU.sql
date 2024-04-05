--------------------------------------------------------
--  DDL for Trigger GMD_RECIPE_VALIDITY_RULE_AU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULE_AU" AFTER UPDATE OF RECIPE_VALIDITY_RULE_ID,END_DATE,ITEM_ID,MAX_QTY,MIN_QTY,ORGN_CODE,RECIPE_USE,START_DATE,STD_QTY ON "GMD"."GMD_RECIPE_VALIDITY_RULES" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN GMD_RECIPE_VALIDITY_RULE_AUP(:old.RECIPE_VALIDITY_RULE_ID,:old.END_DATE,:old.ITEM_ID,:old.MAX_QTY,:old.MIN_QTY,:old.ORGN_CODE,:old.RECIPE_USE,:old.START_DATE,:old.STD_QTY,:new.RECIPE_VALIDITY_RULE_ID,:new.END_DATE,:new.ITEM_ID,:new.MAX_QTY,:new.MIN_QTY,:new.ORGN_CODE,:new.RECIPE_USE,:new.START_DATE,:new.STD_QTY);END IF;END;

/
ALTER TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULE_AU" ENABLE;
