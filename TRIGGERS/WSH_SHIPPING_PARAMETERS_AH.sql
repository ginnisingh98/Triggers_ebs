--------------------------------------------------------
--  DDL for Trigger WSH_SHIPPING_PARAMETERS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."WSH_SHIPPING_PARAMETERS_AH" BEFORE INSERT ON "WSH"."WSH_SHIPPING_PARAMETERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."WSH_SHIPPING_PARAMETERS_AH" ENABLE;
