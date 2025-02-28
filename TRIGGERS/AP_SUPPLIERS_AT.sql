--------------------------------------------------------
--  DDL for Trigger AP_SUPPLIERS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_SUPPLIERS_AT" BEFORE UPDATE OF VENDOR_ID,ALLOW_AWT_FLAG,ALLOW_SUBSTITUTE_RECEIPTS_FLAG,ALLOW_UNORDERED_RECEIPTS_FLAG,ALWAYS_TAKE_DISC_FLAG,AUTO_CALCULATE_INTEREST_FLAG,AWT_GROUP_ID,BANK_CHARGE_BEARER,DAYS_EARLY_RECEIPT_ALLOWED,DAYS_LATE_RECEIPT_ALLOWED,ENFORCE_SHIP_TO_LOCATION_CODE,HOLD_UNMATCHED_INVOICES_FLAG,INVOICE_CURRENCY_CODE,MATCH_OPTION,PAYMENT_CURRENCY_CODE,PAY_DATE_BASIS_LOOKUP_CODE,QTY_RCV_EXCEPTION_CODE,QTY_RCV_TOLERANCE,RECEIPT_DAYS_EXCEPTION_CODE,RECEIVING_ROUTING_ID,SET_OF_BOOKS_ID,TERMS_DATE_BASIS,TERMS_ID,VALIDATION_NUMBER ON "AP"."AP_SUPPLIERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."AP_SUPPLIERS_AT" ENABLE;
