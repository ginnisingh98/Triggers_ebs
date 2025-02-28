--------------------------------------------------------
--  DDL for Trigger GL_LEDGERS_AT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GL_LEDGERS_AT" BEFORE UPDATE OF LEDGER_ID,ACCOUNTED_PERIOD_TYPE,ALC_LEDGER_TYPE_CODE,ALLOW_INTERCOMPANY_POST_FLAG,ATTRIBUTE1,ATTRIBUTE10,ATTRIBUTE11,ATTRIBUTE12,ATTRIBUTE13,ATTRIBUTE14,ATTRIBUTE15,ATTRIBUTE2,ATTRIBUTE3,ATTRIBUTE4,ATTRIBUTE5,ATTRIBUTE6,ATTRIBUTE7,ATTRIBUTE8,ATTRIBUTE9,CHART_OF_ACCOUNTS_ID,CONSOLIDATION_LEDGER_FLAG,CONTEXT,CUM_TRANS_CODE_COMBINATION_ID,CURRENCY_CODE,DAILY_TRANSLATION_RATE_TYPE,DESCRIPTION,ENABLE_AUTOMATIC_TAX_FLAG,ENABLE_AVERAGE_BALANCES_FLAG,ENABLE_BUDGETARY_CONTROL_FLAG,ENABLE_JE_APPROVAL_FLAG,FUTURE_ENTERABLE_PERIODS_LIMIT,LATEST_ENCUMBRANCE_YEAR,LATEST_OPENED_PERIOD_NAME,NAME,NET_INCOME_CODE_COMBINATION_ID,PERIOD_SET_NAME,REQUIRE_BUDGET_JOURNALS_FLAG,RES_ENCUMB_CODE_COMBINATION_ID,RET_EARN_CODE_COMBINATION_ID,ROUNDING_CODE_COMBINATION_ID,SHORT_NAME,SLA_LEDGER_CASH_BASIS_FLAG,SUSPENSE_ALLOWED_FLAG,TRACK_ROUNDING_IMBALANCE_FLAG,TRANSACTION_CALENDAR_ID,TRANSLATE_EOD_FLAG,TRANSLATE_QATD_FLAG,TRANSLATE_YATD_FLAG ON "GL"."GL_LEDGERS" BEGIN IF fnd_global.audit_active THEN fnd_audit_pkg.audit_on := TRUE;ELSE fnd_audit_pkg.audit_on := FALSE;END IF;END;

/
ALTER TRIGGER "APPS"."GL_LEDGERS_AT" ENABLE;
