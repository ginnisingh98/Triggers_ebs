--------------------------------------------------------
--  DDL for Trigger IBY_ACCOUNT_OWNERS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IBY_ACCOUNT_OWNERS_AT" BEFORE UPDATE OF ACCOUNT_OWNER_ID,ACCOUNT_OWNER_PARTY_ID,END_DATE,EXT_BANK_ACCOUNT_ID ON "IBY"."IBY_ACCOUNT_OWNERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."IBY_ACCOUNT_OWNERS_AT" ENABLE;
