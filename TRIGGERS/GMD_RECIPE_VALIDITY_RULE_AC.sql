--------------------------------------------------------
--  DDL for Trigger GMD_RECIPE_VALIDITY_RULE_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULE_AC" BEFORE DELETE ON "GMD"."GMD_RECIPE_VALIDITY_RULES" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GMD_RECIPE_VALIDITY_RULE_AC" ENABLE;
