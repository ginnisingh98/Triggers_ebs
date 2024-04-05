--------------------------------------------------------
--  DDL for Trigger AP_PRODUCT_SETUP_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_PRODUCT_SETUP_AH" BEFORE INSERT ON "AP"."AP_PRODUCT_SETUP" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."AP_PRODUCT_SETUP_AH" ENABLE;
