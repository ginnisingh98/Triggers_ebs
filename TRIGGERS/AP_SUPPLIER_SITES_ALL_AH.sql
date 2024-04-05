--------------------------------------------------------
--  DDL for Trigger AP_SUPPLIER_SITES_ALL_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_SUPPLIER_SITES_ALL_AH" BEFORE INSERT ON "AP"."AP_SUPPLIER_SITES_ALL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."AP_SUPPLIER_SITES_ALL_AH" ENABLE;
