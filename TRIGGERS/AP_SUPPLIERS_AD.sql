--------------------------------------------------------
--  DDL for Trigger AP_SUPPLIERS_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_SUPPLIERS_AD" AFTER DELETE ON "AP"."AP_SUPPLIERS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN AP_SUPPLIERS_ADP(:old.VENDOR_ID,:old.ALLOW_AWT_FLAG,:old.ALLOW_SUBSTITUTE_RECEIPTS_FLAG,:old.ALLOW_UNORDERED_RECEIPTS_FLAG,:old.ALWAYS_TAKE_DISC_FLAG,:old.AUTO_CALCULATE_INTEREST_FLAG,:old.AWT_GROUP_ID,:old.BANK_CHARGE_BEARER,:old.DAYS_EARLY_RECEIPT_ALLOWED,:old.DAYS_LATE_RECEIPT_ALLOWED,:old.ENFORCE_SHIP_TO_LOCATION_CODE,:old.HOLD_UNMATCHED_INVOICES_FLAG,:old.INVOICE_CURRENCY_CODE,:old.MATCH_OPTION,:old.PAYMENT_CURRENCY_CODE,:old.PAY_DATE_BASIS_LOOKUP_CODE,:old.QTY_RCV_EXCEPTION_CODE,:old.QTY_RCV_TOLERANCE,:old.RECEIPT_DAYS_EXCEPTION_CODE,:old.RECEIVING_ROUTING_ID,:old.SET_OF_BOOKS_ID,:old.TERMS_DATE_BASIS,:old.TERMS_ID,:old.VALIDATION_NUMBER,:new.VENDOR_ID,:new.ALLOW_AWT_FLAG,:new.ALLOW_SUBSTITUTE_RECEIPTS_FLAG,:new.ALLOW_UNORDERED_RECEIPTS_FLAG,:new.ALWAYS_TAKE_DISC_FLAG,:new.AUTO_CALCULATE_INTEREST_FLAG,:new.AWT_GROUP_ID,:new.BANK_CHARGE_BEARER,:new.DAYS_EARLY_RECEIPT_ALLOWED,:new.DAYS_LATE_RECEIPT_ALLOWED,:new.ENFORCE_SHIP_TO_LOCATION_CODE,:new.HOLD_UNMATCHED_INVOICES_FLAG,:new.INVOICE_CURRENCY_CODE,:new.MATCH_OPTION,:new.PAYMENT_CURRENCY_CODE,:new.PAY_DATE_BASIS_LOOKUP_CODE,:new.QTY_RCV_EXCEPTION_CODE,:new.QTY_RCV_TOLERANCE,:new.RECEIPT_DAYS_EXCEPTION_CODE,:new.RECEIVING_ROUTING_ID,:new.SET_OF_BOOKS_ID,:new.TERMS_DATE_BASIS,:new.TERMS_ID,:new.VALIDATION_NUMBER);END IF;END;

/
ALTER TRIGGER "APPS"."AP_SUPPLIERS_AD" ENABLE;
