--------------------------------------------------------
--  DDL for Trigger ZX_PRODUCT_OPTIONS_ALL_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."ZX_PRODUCT_OPTIONS_ALL_AH" BEFORE INSERT ON "ZX"."ZX_PRODUCT_OPTIONS_ALL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."ZX_PRODUCT_OPTIONS_ALL_AH" ENABLE;
