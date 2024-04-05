--------------------------------------------------------
--  DDL for Trigger IBY_EXT_BANK_ACCOUNTS_AC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IBY_EXT_BANK_ACCOUNTS_AC" BEFORE DELETE ON "IBY"."IBY_EXT_BANK_ACCOUNTS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."IBY_EXT_BANK_ACCOUNTS_AC" ENABLE;
