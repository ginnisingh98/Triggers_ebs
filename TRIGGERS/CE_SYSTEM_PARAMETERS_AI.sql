--------------------------------------------------------
--  DDL for Trigger CE_SYSTEM_PARAMETERS_AI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CE_SYSTEM_PARAMETERS_AI" AFTER INSERT ON "CE"."CE_SYSTEM_PARAMETERS" FOR EACH ROW BEGIN IF fnd_audit_pkg.audit_on THEN CE_SYSTEM_PARAMETERS_AIP(:old.LEGAL_ENTITY_ID,:old.SET_OF_BOOKS_ID,:old.ATTRIBUTE1,:old.ATTRIBUTE10,:old.ATTRIBUTE11,:old.ATTRIBUTE12,:old.ATTRIBUTE13,:old.ATTRIBUTE14,:old.ATTRIBUTE15,:old.ATTRIBUTE2,:old.ATTRIBUTE3,:old.ATTRIBUTE4,:old.ATTRIBUTE5,:old.ATTRIBUTE6,:old.ATTRIBUTE7,:old.ATTRIBUTE8,:old.ATTRIBUTE9,:old.ATTRIBUTE_CATEGORY,:old.AUTHORIZATION_BAT,:old.BAT_EXCHANGE_DATE_TYPE,:old.BSC_EXCHANGE_DATE_TYPE,:old.CASHBOOK_BEGIN_DATE,:old.CASHFLOW_EXCHANGE_RATE_TYPE,:old.CREATED_BY,:old.CREATION_DATE,:old.INTERFACE_ARCHIVE_FLAG,:old.INTERFACE_PURGE_FLAG,:old.LAST_UPDATED_BY,:old.LAST_UPDATE_DATE,:old.LAST_UPDATE_LOGIN,:old.LINES_PER_COMMIT,:old.LINE_AUTOCREATION_FLAG,:old.SHOW_CLEARED_FLAG,:old.SHOW_VOID_PAYMENT_FLAG,:old.SIGNING_AUTHORITY_APPR_FLAG,:new.LEGAL_ENTITY_ID,:new.SET_OF_BOOKS_ID,:new.ATTRIBUTE1,:new.ATTRIBUTE10,:new.ATTRIBUTE11,:new.ATTRIBUTE12,:new.ATTRIBUTE13,:new.ATTRIBUTE14,:new.ATTRIBUTE15,:new.ATTRIBUTE2,:new.ATTRIBUTE3,:new.ATTRIBUTE4,:new.ATTRIBUTE5,:new.ATTRIBUTE6,:new.ATTRIBUTE7,:new.ATTRIBUTE8,:new.ATTRIBUTE9,:new.ATTRIBUTE_CATEGORY,:new.AUTHORIZATION_BAT,:new.BAT_EXCHANGE_DATE_TYPE,:new.BSC_EXCHANGE_DATE_TYPE,:new.CASHBOOK_BEGIN_DATE,:new.CASHFLOW_EXCHANGE_RATE_TYPE,:new.CREATED_BY,:new.CREATION_DATE,:new.INTERFACE_ARCHIVE_FLAG,:new.INTERFACE_PURGE_FLAG,:new.LAST_UPDATED_BY,:new.LAST_UPDATE_DATE,:new.LAST_UPDATE_LOGIN,:new.LINES_PER_COMMIT,:new.LINE_AUTOCREATION_FLAG,:new.SHOW_CLEARED_FLAG,:new.SHOW_VOID_PAYMENT_FLAG,:new.SIGNING_AUTHORITY_APPR_FLAG);END IF;END;

/
ALTER TRIGGER "APPS"."CE_SYSTEM_PARAMETERS_AI" ENABLE;
