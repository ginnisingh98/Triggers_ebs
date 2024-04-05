--------------------------------------------------------
--  DDL for Trigger IBY_EXT_BANK_ACCOUNTS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."IBY_EXT_BANK_ACCOUNTS_AT" BEFORE UPDATE OF EXT_BANK_ACCOUNT_ID,BANK_ACCOUNT_NUM,END_DATE,IBAN,START_DATE ON "IBY"."IBY_EXT_BANK_ACCOUNTS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."IBY_EXT_BANK_ACCOUNTS_AT" ENABLE;
