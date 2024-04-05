--------------------------------------------------------
--  DDL for Trigger AP_SUPPLIER_SITES_ALL_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_SUPPLIER_SITES_ALL_AT" BEFORE UPDATE OF VENDOR_SITE_ID,ACCTS_PAY_CODE_COMBINATION_ID,ALLOW_AWT_FLAG,ALWAYS_TAKE_DISC_FLAG,AWT_GROUP_ID,BANK_CHARGE_BEARER,BILL_TO_LOCATION_ID,FOB_LOOKUP_CODE,FREIGHT_TERMS_LOOKUP_CODE,FUTURE_DATED_PAYMENT_CCID,HOLD_UNMATCHED_INVOICES_FLAG,INVOICE_CURRENCY_CODE,MATCH_OPTION,PAYMENT_CURRENCY_CODE,PAYMENT_METHOD_LOOKUP_CODE,PAY_DATE_BASIS_LOOKUP_CODE,PREPAY_CODE_COMBINATION_ID,SHIP_TO_LOCATION_ID,SHIP_VIA_LOOKUP_CODE,TERMS_DATE_BASIS,TERMS_ID,VALIDATION_NUMBER,VENDOR_ID,VENDOR_SITE_CODE ON "AP"."AP_SUPPLIER_SITES_ALL" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."AP_SUPPLIER_SITES_ALL_AT" ENABLE;
