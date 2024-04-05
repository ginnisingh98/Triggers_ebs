--------------------------------------------------------
--  DDL for Trigger GMD_RECIPE_VALIDITY_RULE_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULE_AT" BEFORE UPDATE OF RECIPE_VALIDITY_RULE_ID,END_DATE,ITEM_ID,MAX_QTY,MIN_QTY,ORGN_CODE,RECIPE_USE,START_DATE,STD_QTY ON "GMD"."GMD_RECIPE_VALIDITY_RULES" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULE_AT" ENABLE;
