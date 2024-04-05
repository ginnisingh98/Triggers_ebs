--------------------------------------------------------
--  DDL for Trigger FINANCIALS_SYSTEM_PARAMS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FINANCIALS_SYSTEM_PARAMS_AH" BEFORE INSERT ON "AP"."FINANCIALS_SYSTEM_PARAMS_ALL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."FINANCIALS_SYSTEM_PARAMS_AH" ENABLE;
