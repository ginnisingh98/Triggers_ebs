--------------------------------------------------------
--  DDL for Trigger IC_ITEM_MST_B_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IC_ITEM_MST_B_AC" BEFORE DELETE ON "GMI"."IC_ITEM_MST_B" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."IC_ITEM_MST_B_AC" ENABLE;
