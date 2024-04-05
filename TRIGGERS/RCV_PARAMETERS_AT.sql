--------------------------------------------------------
--  DDL for Trigger RCV_PARAMETERS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."RCV_PARAMETERS_AT" BEFORE UPDATE OF ORGANIZATION_ID,ALLOW_CASCADE_TRANSACTIONS,ALLOW_EXPRESS_DELIVERY_FLAG,ALLOW_SUBSTITUTE_RECEIPTS_FLAG,ALLOW_UNORDERED_RECEIPTS_FLAG,BLIND_RECEIVING_FLAG,CLEARING_ACCOUNT_ID,CREATED_BY,CREATION_DATE,DAYS_EARLY_RECEIPT_ALLOWED,DAYS_LATE_RECEIPT_ALLOWED,ENFORCE_RMA_LOT_NUM,ENFORCE_RMA_SERIAL_NUM,ENFORCE_SHIP_TO_LOCATION_CODE,GLOBAL_ATTRIBUTE1,GLOBAL_ATTRIBUTE10,GLOBAL_ATTRIBUTE11,GLOBAL_ATTRIBUTE12,GLOBAL_ATTRIBUTE13,GLOBAL_ATTRIBUTE14,GLOBAL_ATTRIBUTE15,GLOBAL_ATTRIBUTE16,GLOBAL_ATTRIBUTE17,GLOBAL_ATTRIBUTE18,GLOBAL_ATTRIBUTE19,GLOBAL_ATTRIBUTE2,GLOBAL_ATTRIBUTE20,GLOBAL_ATTRIBUTE3,GLOBAL_ATTRIBUTE4,GLOBAL_ATTRIBUTE5,GLOBAL_ATTRIBUTE6,GLOBAL_ATTRIBUTE7,GLOBAL_ATTRIBUTE8,GLOBAL_ATTRIBUTE9,GLOBAL_ATTRIBUTE_CATEGORY,LAST_UPDATED_BY,LAST_UPDATED_LOGIN,LAST_UPDATE_DATE,MANUAL_RECEIPT_NUM_TYPE,PROGRAM_APPLICATION_ID,PROGRAM_ID,PROGRAM_UPDATE_DATE,QTY_RCV_EXCEPTION_CODE,QTY_RCV_TOLERANCE,RECEIPT_ASN_EXISTS_CODE,RECEIPT_DAYS_EXCEPTION_CODE,RECEIVING_ACCOUNT_ID,RECEIVING_ROUTING_ID,REQUEST_ID,RETROPRICE_ADJ_ACCOUNT_ID,RMA_RECEIPT_ROUTING_ID,USER_DEFINED_RECEIPT_NUM_CODE ON "PO"."RCV_PARAMETERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."RCV_PARAMETERS_AT" ENABLE;
