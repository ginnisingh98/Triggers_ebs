--------------------------------------------------------
--  DDL for Trigger IBY_ACCOUNT_OWNERS_AH
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IBY_ACCOUNT_OWNERS_AH" BEFORE INSERT ON "IBY"."IBY_ACCOUNT_OWNERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."IBY_ACCOUNT_OWNERS_AH" ENABLE;
