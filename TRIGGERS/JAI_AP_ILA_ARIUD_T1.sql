--------------------------------------------------------
--  DDL for Trigger JAI_AP_ILA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AP_ILA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AP"."AP_INVOICE_LINES_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             AP_INVOICE_LINES_ALL%rowtype ;
  t_new_rec             AP_INVOICE_LINES_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.INVOICE_ID                               := :new.INVOICE_ID                                    ;
    t_new_rec.LINE_NUMBER                              := :new.LINE_NUMBER                                   ;
    t_new_rec.LINE_TYPE_LOOKUP_CODE                    := :new.LINE_TYPE_LOOKUP_CODE                         ;
    t_new_rec.REQUESTER_ID                             := :new.REQUESTER_ID                                  ;
    t_new_rec.DESCRIPTION                              := :new.DESCRIPTION                                   ;
    t_new_rec.LINE_SOURCE                              := :new.LINE_SOURCE                                   ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.LINE_GROUP_NUMBER                        := :new.LINE_GROUP_NUMBER                             ;
    t_new_rec.INVENTORY_ITEM_ID                        := :new.INVENTORY_ITEM_ID                             ;
    t_new_rec.ITEM_DESCRIPTION                         := :new.ITEM_DESCRIPTION                              ;
    t_new_rec.SERIAL_NUMBER                            := :new.SERIAL_NUMBER                                 ;
    t_new_rec.MANUFACTURER                             := :new.MANUFACTURER                                  ;
    t_new_rec.MODEL_NUMBER                             := :new.MODEL_NUMBER                                  ;
    t_new_rec.WARRANTY_NUMBER                          := :new.WARRANTY_NUMBER                               ;
    t_new_rec.GENERATE_DISTS                           := :new.GENERATE_DISTS                                ;
    t_new_rec.MATCH_TYPE                               := :new.MATCH_TYPE                                    ;
    t_new_rec.DISTRIBUTION_SET_ID                      := :new.DISTRIBUTION_SET_ID                           ;
    t_new_rec.ACCOUNT_SEGMENT                          := :new.ACCOUNT_SEGMENT                               ;
    t_new_rec.BALANCING_SEGMENT                        := :new.BALANCING_SEGMENT                             ;
    t_new_rec.COST_CENTER_SEGMENT                      := :new.COST_CENTER_SEGMENT                           ;
    t_new_rec.OVERLAY_DIST_CODE_CONCAT                 := :new.OVERLAY_DIST_CODE_CONCAT                      ;
    t_new_rec.DEFAULT_DIST_CCID                        := :new.DEFAULT_DIST_CCID                             ;
    t_new_rec.PRORATE_ACROSS_ALL_ITEMS                 := :new.PRORATE_ACROSS_ALL_ITEMS                      ;
    t_new_rec.ACCOUNTING_DATE                          := :new.ACCOUNTING_DATE                               ;
    t_new_rec.PERIOD_NAME                              := :new.PERIOD_NAME                                   ;
    t_new_rec.DEFERRED_ACCTG_FLAG                      := :new.DEFERRED_ACCTG_FLAG                           ;
    t_new_rec.DEF_ACCTG_START_DATE                     := :new.DEF_ACCTG_START_DATE                          ;
    t_new_rec.DEF_ACCTG_END_DATE                       := :new.DEF_ACCTG_END_DATE                            ;
    t_new_rec.DEF_ACCTG_NUMBER_OF_PERIODS              := :new.DEF_ACCTG_NUMBER_OF_PERIODS                   ;
    t_new_rec.DEF_ACCTG_PERIOD_TYPE                    := :new.DEF_ACCTG_PERIOD_TYPE                         ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.BASE_AMOUNT                              := :new.BASE_AMOUNT                                   ;
    t_new_rec.ROUNDING_AMT                             := :new.ROUNDING_AMT                                  ;
    t_new_rec.QUANTITY_INVOICED                        := :new.QUANTITY_INVOICED                             ;
    t_new_rec.UNIT_MEAS_LOOKUP_CODE                    := :new.UNIT_MEAS_LOOKUP_CODE                         ;
    t_new_rec.UNIT_PRICE                               := :new.UNIT_PRICE                                    ;
    t_new_rec.WFAPPROVAL_STATUS                        := :new.WFAPPROVAL_STATUS                             ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.DISCARDED_FLAG                           := :new.DISCARDED_FLAG                                ;
    t_new_rec.ORIGINAL_AMOUNT                          := :new.ORIGINAL_AMOUNT                               ;
    t_new_rec.ORIGINAL_BASE_AMOUNT                     := :new.ORIGINAL_BASE_AMOUNT                          ;
    t_new_rec.ORIGINAL_ROUNDING_AMT                    := :new.ORIGINAL_ROUNDING_AMT                         ;
    t_new_rec.CANCELLED_FLAG                           := :new.CANCELLED_FLAG                                ;
    t_new_rec.INCOME_TAX_REGION                        := :new.INCOME_TAX_REGION                             ;
    t_new_rec.TYPE_1099                                := :new.TYPE_1099                                     ;
    t_new_rec.STAT_AMOUNT                              := :new.STAT_AMOUNT                                   ;
    t_new_rec.PREPAY_INVOICE_ID                        := :new.PREPAY_INVOICE_ID                             ;
    t_new_rec.PREPAY_LINE_NUMBER                       := :new.PREPAY_LINE_NUMBER                            ;
    t_new_rec.INVOICE_INCLUDES_PREPAY_FLAG             := :new.INVOICE_INCLUDES_PREPAY_FLAG                  ;
    t_new_rec.CORRECTED_INV_ID                         := :new.CORRECTED_INV_ID                              ;
    t_new_rec.CORRECTED_LINE_NUMBER                    := :new.CORRECTED_LINE_NUMBER                         ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.PO_LINE_ID                               := :new.PO_LINE_ID                                    ;
    t_new_rec.PO_RELEASE_ID                            := :new.PO_RELEASE_ID                                 ;
    t_new_rec.PO_LINE_LOCATION_ID                      := :new.PO_LINE_LOCATION_ID                           ;
    t_new_rec.PO_DISTRIBUTION_ID                       := :new.PO_DISTRIBUTION_ID                            ;
    t_new_rec.RCV_TRANSACTION_ID                       := :new.RCV_TRANSACTION_ID                            ;
    t_new_rec.FINAL_MATCH_FLAG                         := :new.FINAL_MATCH_FLAG                              ;
    t_new_rec.ASSETS_TRACKING_FLAG                     := :new.ASSETS_TRACKING_FLAG                          ;
    t_new_rec.ASSET_BOOK_TYPE_CODE                     := :new.ASSET_BOOK_TYPE_CODE                          ;
    t_new_rec.ASSET_CATEGORY_ID                        := :new.ASSET_CATEGORY_ID                             ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
    t_new_rec.EXPENDITURE_TYPE                         := :new.EXPENDITURE_TYPE                              ;
    t_new_rec.EXPENDITURE_ITEM_DATE                    := :new.EXPENDITURE_ITEM_DATE                         ;
    t_new_rec.EXPENDITURE_ORGANIZATION_ID              := :new.EXPENDITURE_ORGANIZATION_ID                   ;
    t_new_rec.PA_QUANTITY                              := :new.PA_QUANTITY                                   ;
    t_new_rec.PA_CC_AR_INVOICE_ID                      := :new.PA_CC_AR_INVOICE_ID                           ;
    t_new_rec.PA_CC_AR_INVOICE_LINE_NUM                := :new.PA_CC_AR_INVOICE_LINE_NUM                     ;
    t_new_rec.PA_CC_PROCESSED_CODE                     := :new.PA_CC_PROCESSED_CODE                          ;
    t_new_rec.AWARD_ID                                 := :new.AWARD_ID                                      ;
    t_new_rec.AWT_GROUP_ID                             := :new.AWT_GROUP_ID                                  ;
    t_new_rec.REFERENCE_1                              := :new.REFERENCE_1                                   ;
    t_new_rec.REFERENCE_2                              := :new.REFERENCE_2                                   ;
    t_new_rec.RECEIPT_VERIFIED_FLAG                    := :new.RECEIPT_VERIFIED_FLAG                         ;
    t_new_rec.RECEIPT_REQUIRED_FLAG                    := :new.RECEIPT_REQUIRED_FLAG                         ;
    t_new_rec.RECEIPT_MISSING_FLAG                     := :new.RECEIPT_MISSING_FLAG                          ;
    t_new_rec.JUSTIFICATION                            := :new.JUSTIFICATION                                 ;
    t_new_rec.EXPENSE_GROUP                            := :new.EXPENSE_GROUP                                 ;
    t_new_rec.START_EXPENSE_DATE                       := :new.START_EXPENSE_DATE                            ;
    t_new_rec.END_EXPENSE_DATE                         := :new.END_EXPENSE_DATE                              ;
    t_new_rec.RECEIPT_CURRENCY_CODE                    := :new.RECEIPT_CURRENCY_CODE                         ;
    t_new_rec.RECEIPT_CONVERSION_RATE                  := :new.RECEIPT_CONVERSION_RATE                       ;
    t_new_rec.RECEIPT_CURRENCY_AMOUNT                  := :new.RECEIPT_CURRENCY_AMOUNT                       ;
    t_new_rec.DAILY_AMOUNT                             := :new.DAILY_AMOUNT                                  ;
    t_new_rec.WEB_PARAMETER_ID                         := :new.WEB_PARAMETER_ID                              ;
    t_new_rec.ADJUSTMENT_REASON                        := :new.ADJUSTMENT_REASON                             ;
    t_new_rec.MERCHANT_DOCUMENT_NUMBER                 := :new.MERCHANT_DOCUMENT_NUMBER                      ;
    t_new_rec.MERCHANT_NAME                            := :new.MERCHANT_NAME                                 ;
    t_new_rec.MERCHANT_REFERENCE                       := :new.MERCHANT_REFERENCE                            ;
    t_new_rec.MERCHANT_TAX_REG_NUMBER                  := :new.MERCHANT_TAX_REG_NUMBER                       ;
    t_new_rec.MERCHANT_TAXPAYER_ID                     := :new.MERCHANT_TAXPAYER_ID                          ;
    t_new_rec.COUNTRY_OF_SUPPLY                        := :new.COUNTRY_OF_SUPPLY                             ;
    t_new_rec.CREDIT_CARD_TRX_ID                       := :new.CREDIT_CARD_TRX_ID                            ;
    t_new_rec.COMPANY_PREPAID_INVOICE_ID               := :new.COMPANY_PREPAID_INVOICE_ID                    ;
    t_new_rec.CC_REVERSAL_FLAG                         := :new.CC_REVERSAL_FLAG                              ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.ATTRIBUTE_CATEGORY                       := :new.ATTRIBUTE_CATEGORY                            ;
    t_new_rec.ATTRIBUTE1                               := :new.ATTRIBUTE1                                    ;
    t_new_rec.ATTRIBUTE2                               := :new.ATTRIBUTE2                                    ;
    t_new_rec.ATTRIBUTE3                               := :new.ATTRIBUTE3                                    ;
    t_new_rec.ATTRIBUTE4                               := :new.ATTRIBUTE4                                    ;
    t_new_rec.ATTRIBUTE5                               := :new.ATTRIBUTE5                                    ;
    t_new_rec.ATTRIBUTE6                               := :new.ATTRIBUTE6                                    ;
    t_new_rec.ATTRIBUTE7                               := :new.ATTRIBUTE7                                    ;
    t_new_rec.ATTRIBUTE8                               := :new.ATTRIBUTE8                                    ;
    t_new_rec.ATTRIBUTE9                               := :new.ATTRIBUTE9                                    ;
    t_new_rec.ATTRIBUTE10                              := :new.ATTRIBUTE10                                   ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :new.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_new_rec.GLOBAL_ATTRIBUTE1                        := :new.GLOBAL_ATTRIBUTE1                             ;
    t_new_rec.GLOBAL_ATTRIBUTE2                        := :new.GLOBAL_ATTRIBUTE2                             ;
    t_new_rec.GLOBAL_ATTRIBUTE3                        := :new.GLOBAL_ATTRIBUTE3                             ;
    t_new_rec.GLOBAL_ATTRIBUTE4                        := :new.GLOBAL_ATTRIBUTE4                             ;
    t_new_rec.GLOBAL_ATTRIBUTE5                        := :new.GLOBAL_ATTRIBUTE5                             ;
    t_new_rec.GLOBAL_ATTRIBUTE6                        := :new.GLOBAL_ATTRIBUTE6                             ;
    t_new_rec.GLOBAL_ATTRIBUTE7                        := :new.GLOBAL_ATTRIBUTE7                             ;
    t_new_rec.GLOBAL_ATTRIBUTE8                        := :new.GLOBAL_ATTRIBUTE8                             ;
    t_new_rec.GLOBAL_ATTRIBUTE9                        := :new.GLOBAL_ATTRIBUTE9                             ;
    t_new_rec.GLOBAL_ATTRIBUTE10                       := :new.GLOBAL_ATTRIBUTE10                            ;
    t_new_rec.GLOBAL_ATTRIBUTE11                       := :new.GLOBAL_ATTRIBUTE11                            ;
    t_new_rec.GLOBAL_ATTRIBUTE12                       := :new.GLOBAL_ATTRIBUTE12                            ;
    t_new_rec.GLOBAL_ATTRIBUTE13                       := :new.GLOBAL_ATTRIBUTE13                            ;
    t_new_rec.GLOBAL_ATTRIBUTE14                       := :new.GLOBAL_ATTRIBUTE14                            ;
    t_new_rec.GLOBAL_ATTRIBUTE15                       := :new.GLOBAL_ATTRIBUTE15                            ;
    t_new_rec.GLOBAL_ATTRIBUTE16                       := :new.GLOBAL_ATTRIBUTE16                            ;
    t_new_rec.GLOBAL_ATTRIBUTE17                       := :new.GLOBAL_ATTRIBUTE17                            ;
    t_new_rec.GLOBAL_ATTRIBUTE18                       := :new.GLOBAL_ATTRIBUTE18                            ;
    t_new_rec.GLOBAL_ATTRIBUTE19                       := :new.GLOBAL_ATTRIBUTE19                            ;
    t_new_rec.GLOBAL_ATTRIBUTE20                       := :new.GLOBAL_ATTRIBUTE20                            ;
    t_new_rec.LINE_SELECTED_FOR_APPL_FLAG              := :new.LINE_SELECTED_FOR_APPL_FLAG                   ;
    t_new_rec.PREPAY_APPL_REQUEST_ID                   := :new.PREPAY_APPL_REQUEST_ID                        ;
    t_new_rec.APPLICATION_ID                           := :new.APPLICATION_ID                                ;
    t_new_rec.PRODUCT_TABLE                            := :new.PRODUCT_TABLE                                 ;
    t_new_rec.REFERENCE_KEY1                           := :new.REFERENCE_KEY1                                ;
    t_new_rec.REFERENCE_KEY2                           := :new.REFERENCE_KEY2                                ;
    t_new_rec.REFERENCE_KEY3                           := :new.REFERENCE_KEY3                                ;
    t_new_rec.REFERENCE_KEY4                           := :new.REFERENCE_KEY4                                ;
    t_new_rec.REFERENCE_KEY5                           := :new.REFERENCE_KEY5                                ;
    t_new_rec.PURCHASING_CATEGORY_ID                   := :new.PURCHASING_CATEGORY_ID                        ;
    t_new_rec.COST_FACTOR_ID                           := :new.COST_FACTOR_ID                                ;
    t_new_rec.CONTROL_AMOUNT                           := :new.CONTROL_AMOUNT                                ;
    t_new_rec.ASSESSABLE_VALUE                         := :new.ASSESSABLE_VALUE                              ;
    t_new_rec.TOTAL_REC_TAX_AMOUNT                     := :new.TOTAL_REC_TAX_AMOUNT                          ;
    t_new_rec.TOTAL_NREC_TAX_AMOUNT                    := :new.TOTAL_NREC_TAX_AMOUNT                         ;
    t_new_rec.TOTAL_REC_TAX_AMT_FUNCL_CURR             := :new.TOTAL_REC_TAX_AMT_FUNCL_CURR                  ;
    t_new_rec.TOTAL_NREC_TAX_AMT_FUNCL_CURR            := :new.TOTAL_NREC_TAX_AMT_FUNCL_CURR                 ;
    t_new_rec.INCLUDED_TAX_AMOUNT                      := :new.INCLUDED_TAX_AMOUNT                           ;
    t_new_rec.PRIMARY_INTENDED_USE                     := :new.PRIMARY_INTENDED_USE                          ;
    t_new_rec.TAX_ALREADY_CALCULATED_FLAG              := :new.TAX_ALREADY_CALCULATED_FLAG                   ;
    t_new_rec.SHIP_TO_LOCATION_ID                      := :new.SHIP_TO_LOCATION_ID                           ;
    t_new_rec.PRODUCT_TYPE                             := :new.PRODUCT_TYPE                                  ;
    t_new_rec.PRODUCT_CATEGORY                         := :new.PRODUCT_CATEGORY                              ;
    t_new_rec.PRODUCT_FISC_CLASSIFICATION              := :new.PRODUCT_FISC_CLASSIFICATION                   ;
    t_new_rec.USER_DEFINED_FISC_CLASS                  := :new.USER_DEFINED_FISC_CLASS                       ;
    t_new_rec.TRX_BUSINESS_CATEGORY                    := :new.TRX_BUSINESS_CATEGORY                         ;
    t_new_rec.SUMMARY_TAX_LINE_ID                      := :new.SUMMARY_TAX_LINE_ID                           ;
    t_new_rec.TAX_REGIME_CODE                          := :new.TAX_REGIME_CODE                               ;
    t_new_rec.TAX                                      := :new.TAX                                           ;
    t_new_rec.TAX_JURISDICTION_CODE                    := :new.TAX_JURISDICTION_CODE                         ;
    t_new_rec.TAX_STATUS_CODE                          := :new.TAX_STATUS_CODE                               ;
    t_new_rec.TAX_RATE_ID                              := :new.TAX_RATE_ID                                   ;
    t_new_rec.TAX_RATE_CODE                            := :new.TAX_RATE_CODE                                 ;
    t_new_rec.TAX_RATE                                 := :new.TAX_RATE                                      ;
    t_new_rec.TAX_CODE_ID                              := :new.TAX_CODE_ID                                   ;
    t_new_rec.HISTORICAL_FLAG                          := :new.HISTORICAL_FLAG                               ;
    t_new_rec.TAX_CLASSIFICATION_CODE                  := :new.TAX_CLASSIFICATION_CODE                       ;
    t_new_rec.SOURCE_APPLICATION_ID                    := :new.SOURCE_APPLICATION_ID                         ;
    t_new_rec.SOURCE_EVENT_CLASS_CODE                  := :new.SOURCE_EVENT_CLASS_CODE                       ;
    t_new_rec.SOURCE_ENTITY_CODE                       := :new.SOURCE_ENTITY_CODE                            ;
    t_new_rec.SOURCE_TRX_ID                            := :new.SOURCE_TRX_ID                                 ;
    t_new_rec.SOURCE_LINE_ID                           := :new.SOURCE_LINE_ID                                ;
    t_new_rec.SOURCE_TRX_LEVEL_TYPE                    := :new.SOURCE_TRX_LEVEL_TYPE                         ;
    t_new_rec.RETAINED_AMOUNT                          := :new.RETAINED_AMOUNT                               ;
    t_new_rec.RETAINED_AMOUNT_REMAINING                := :new.RETAINED_AMOUNT_REMAINING                     ;
    t_new_rec.RETAINED_INVOICE_ID                      := :new.RETAINED_INVOICE_ID                           ;
    t_new_rec.RETAINED_LINE_NUMBER                     := :new.RETAINED_LINE_NUMBER                          ;
    t_new_rec.LINE_SELECTED_FOR_RELEASE_FLAG           := :new.LINE_SELECTED_FOR_RELEASE_FLAG                ;
    t_new_rec.LINE_OWNER_ROLE                          := :new.LINE_OWNER_ROLE                               ;
    t_new_rec.DISPUTABLE_FLAG                          := :new.DISPUTABLE_FLAG                               ;
    t_new_rec.RCV_SHIPMENT_LINE_ID                     := :new.RCV_SHIPMENT_LINE_ID                          ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.INVOICE_ID                               := :old.INVOICE_ID                                    ;
    t_old_rec.LINE_NUMBER                              := :old.LINE_NUMBER                                   ;
    t_old_rec.LINE_TYPE_LOOKUP_CODE                    := :old.LINE_TYPE_LOOKUP_CODE                         ;
    t_old_rec.REQUESTER_ID                             := :old.REQUESTER_ID                                  ;
    t_old_rec.DESCRIPTION                              := :old.DESCRIPTION                                   ;
    t_old_rec.LINE_SOURCE                              := :old.LINE_SOURCE                                   ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.LINE_GROUP_NUMBER                        := :old.LINE_GROUP_NUMBER                             ;
    t_old_rec.INVENTORY_ITEM_ID                        := :old.INVENTORY_ITEM_ID                             ;
    t_old_rec.ITEM_DESCRIPTION                         := :old.ITEM_DESCRIPTION                              ;
    t_old_rec.SERIAL_NUMBER                            := :old.SERIAL_NUMBER                                 ;
    t_old_rec.MANUFACTURER                             := :old.MANUFACTURER                                  ;
    t_old_rec.MODEL_NUMBER                             := :old.MODEL_NUMBER                                  ;
    t_old_rec.WARRANTY_NUMBER                          := :old.WARRANTY_NUMBER                               ;
    t_old_rec.GENERATE_DISTS                           := :old.GENERATE_DISTS                                ;
    t_old_rec.MATCH_TYPE                               := :old.MATCH_TYPE                                    ;
    t_old_rec.DISTRIBUTION_SET_ID                      := :old.DISTRIBUTION_SET_ID                           ;
    t_old_rec.ACCOUNT_SEGMENT                          := :old.ACCOUNT_SEGMENT                               ;
    t_old_rec.BALANCING_SEGMENT                        := :old.BALANCING_SEGMENT                             ;
    t_old_rec.COST_CENTER_SEGMENT                      := :old.COST_CENTER_SEGMENT                           ;
    t_old_rec.OVERLAY_DIST_CODE_CONCAT                 := :old.OVERLAY_DIST_CODE_CONCAT                      ;
    t_old_rec.DEFAULT_DIST_CCID                        := :old.DEFAULT_DIST_CCID                             ;
    t_old_rec.PRORATE_ACROSS_ALL_ITEMS                 := :old.PRORATE_ACROSS_ALL_ITEMS                      ;
    t_old_rec.ACCOUNTING_DATE                          := :old.ACCOUNTING_DATE                               ;
    t_old_rec.PERIOD_NAME                              := :old.PERIOD_NAME                                   ;
    t_old_rec.DEFERRED_ACCTG_FLAG                      := :old.DEFERRED_ACCTG_FLAG                           ;
    t_old_rec.DEF_ACCTG_START_DATE                     := :old.DEF_ACCTG_START_DATE                          ;
    t_old_rec.DEF_ACCTG_END_DATE                       := :old.DEF_ACCTG_END_DATE                            ;
    t_old_rec.DEF_ACCTG_NUMBER_OF_PERIODS              := :old.DEF_ACCTG_NUMBER_OF_PERIODS                   ;
    t_old_rec.DEF_ACCTG_PERIOD_TYPE                    := :old.DEF_ACCTG_PERIOD_TYPE                         ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.BASE_AMOUNT                              := :old.BASE_AMOUNT                                   ;
    t_old_rec.ROUNDING_AMT                             := :old.ROUNDING_AMT                                  ;
    t_old_rec.QUANTITY_INVOICED                        := :old.QUANTITY_INVOICED                             ;
    t_old_rec.UNIT_MEAS_LOOKUP_CODE                    := :old.UNIT_MEAS_LOOKUP_CODE                         ;
    t_old_rec.UNIT_PRICE                               := :old.UNIT_PRICE                                    ;
    t_old_rec.WFAPPROVAL_STATUS                        := :old.WFAPPROVAL_STATUS                             ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.DISCARDED_FLAG                           := :old.DISCARDED_FLAG                                ;
    t_old_rec.ORIGINAL_AMOUNT                          := :old.ORIGINAL_AMOUNT                               ;
    t_old_rec.ORIGINAL_BASE_AMOUNT                     := :old.ORIGINAL_BASE_AMOUNT                          ;
    t_old_rec.ORIGINAL_ROUNDING_AMT                    := :old.ORIGINAL_ROUNDING_AMT                         ;
    t_old_rec.CANCELLED_FLAG                           := :old.CANCELLED_FLAG                                ;
    t_old_rec.INCOME_TAX_REGION                        := :old.INCOME_TAX_REGION                             ;
    t_old_rec.TYPE_1099                                := :old.TYPE_1099                                     ;
    t_old_rec.STAT_AMOUNT                              := :old.STAT_AMOUNT                                   ;
    t_old_rec.PREPAY_INVOICE_ID                        := :old.PREPAY_INVOICE_ID                             ;
    t_old_rec.PREPAY_LINE_NUMBER                       := :old.PREPAY_LINE_NUMBER                            ;
    t_old_rec.INVOICE_INCLUDES_PREPAY_FLAG             := :old.INVOICE_INCLUDES_PREPAY_FLAG                  ;
    t_old_rec.CORRECTED_INV_ID                         := :old.CORRECTED_INV_ID                              ;
    t_old_rec.CORRECTED_LINE_NUMBER                    := :old.CORRECTED_LINE_NUMBER                         ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.PO_LINE_ID                               := :old.PO_LINE_ID                                    ;
    t_old_rec.PO_RELEASE_ID                            := :old.PO_RELEASE_ID                                 ;
    t_old_rec.PO_LINE_LOCATION_ID                      := :old.PO_LINE_LOCATION_ID                           ;
    t_old_rec.PO_DISTRIBUTION_ID                       := :old.PO_DISTRIBUTION_ID                            ;
    t_old_rec.RCV_TRANSACTION_ID                       := :old.RCV_TRANSACTION_ID                            ;
    t_old_rec.FINAL_MATCH_FLAG                         := :old.FINAL_MATCH_FLAG                              ;
    t_old_rec.ASSETS_TRACKING_FLAG                     := :old.ASSETS_TRACKING_FLAG                          ;
    t_old_rec.ASSET_BOOK_TYPE_CODE                     := :old.ASSET_BOOK_TYPE_CODE                          ;
    t_old_rec.ASSET_CATEGORY_ID                        := :old.ASSET_CATEGORY_ID                             ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
    t_old_rec.EXPENDITURE_TYPE                         := :old.EXPENDITURE_TYPE                              ;
    t_old_rec.EXPENDITURE_ITEM_DATE                    := :old.EXPENDITURE_ITEM_DATE                         ;
    t_old_rec.EXPENDITURE_ORGANIZATION_ID              := :old.EXPENDITURE_ORGANIZATION_ID                   ;
    t_old_rec.PA_QUANTITY                              := :old.PA_QUANTITY                                   ;
    t_old_rec.PA_CC_AR_INVOICE_ID                      := :old.PA_CC_AR_INVOICE_ID                           ;
    t_old_rec.PA_CC_AR_INVOICE_LINE_NUM                := :old.PA_CC_AR_INVOICE_LINE_NUM                     ;
    t_old_rec.PA_CC_PROCESSED_CODE                     := :old.PA_CC_PROCESSED_CODE                          ;
    t_old_rec.AWARD_ID                                 := :old.AWARD_ID                                      ;
    t_old_rec.AWT_GROUP_ID                             := :old.AWT_GROUP_ID                                  ;
    t_old_rec.REFERENCE_1                              := :old.REFERENCE_1                                   ;
    t_old_rec.REFERENCE_2                              := :old.REFERENCE_2                                   ;
    t_old_rec.RECEIPT_VERIFIED_FLAG                    := :old.RECEIPT_VERIFIED_FLAG                         ;
    t_old_rec.RECEIPT_REQUIRED_FLAG                    := :old.RECEIPT_REQUIRED_FLAG                         ;
    t_old_rec.RECEIPT_MISSING_FLAG                     := :old.RECEIPT_MISSING_FLAG                          ;
    t_old_rec.JUSTIFICATION                            := :old.JUSTIFICATION                                 ;
    t_old_rec.EXPENSE_GROUP                            := :old.EXPENSE_GROUP                                 ;
    t_old_rec.START_EXPENSE_DATE                       := :old.START_EXPENSE_DATE                            ;
    t_old_rec.END_EXPENSE_DATE                         := :old.END_EXPENSE_DATE                              ;
    t_old_rec.RECEIPT_CURRENCY_CODE                    := :old.RECEIPT_CURRENCY_CODE                         ;
    t_old_rec.RECEIPT_CONVERSION_RATE                  := :old.RECEIPT_CONVERSION_RATE                       ;
    t_old_rec.RECEIPT_CURRENCY_AMOUNT                  := :old.RECEIPT_CURRENCY_AMOUNT                       ;
    t_old_rec.DAILY_AMOUNT                             := :old.DAILY_AMOUNT                                  ;
    t_old_rec.WEB_PARAMETER_ID                         := :old.WEB_PARAMETER_ID                              ;
    t_old_rec.ADJUSTMENT_REASON                        := :old.ADJUSTMENT_REASON                             ;
    t_old_rec.MERCHANT_DOCUMENT_NUMBER                 := :old.MERCHANT_DOCUMENT_NUMBER                      ;
    t_old_rec.MERCHANT_NAME                            := :old.MERCHANT_NAME                                 ;
    t_old_rec.MERCHANT_REFERENCE                       := :old.MERCHANT_REFERENCE                            ;
    t_old_rec.MERCHANT_TAX_REG_NUMBER                  := :old.MERCHANT_TAX_REG_NUMBER                       ;
    t_old_rec.MERCHANT_TAXPAYER_ID                     := :old.MERCHANT_TAXPAYER_ID                          ;
    t_old_rec.COUNTRY_OF_SUPPLY                        := :old.COUNTRY_OF_SUPPLY                             ;
    t_old_rec.CREDIT_CARD_TRX_ID                       := :old.CREDIT_CARD_TRX_ID                            ;
    t_old_rec.COMPANY_PREPAID_INVOICE_ID               := :old.COMPANY_PREPAID_INVOICE_ID                    ;
    t_old_rec.CC_REVERSAL_FLAG                         := :old.CC_REVERSAL_FLAG                              ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.ATTRIBUTE_CATEGORY                       := :old.ATTRIBUTE_CATEGORY                            ;
    t_old_rec.ATTRIBUTE1                               := :old.ATTRIBUTE1                                    ;
    t_old_rec.ATTRIBUTE2                               := :old.ATTRIBUTE2                                    ;
    t_old_rec.ATTRIBUTE3                               := :old.ATTRIBUTE3                                    ;
    t_old_rec.ATTRIBUTE4                               := :old.ATTRIBUTE4                                    ;
    t_old_rec.ATTRIBUTE5                               := :old.ATTRIBUTE5                                    ;
    t_old_rec.ATTRIBUTE6                               := :old.ATTRIBUTE6                                    ;
    t_old_rec.ATTRIBUTE7                               := :old.ATTRIBUTE7                                    ;
    t_old_rec.ATTRIBUTE8                               := :old.ATTRIBUTE8                                    ;
    t_old_rec.ATTRIBUTE9                               := :old.ATTRIBUTE9                                    ;
    t_old_rec.ATTRIBUTE10                              := :old.ATTRIBUTE10                                   ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :old.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_old_rec.GLOBAL_ATTRIBUTE1                        := :old.GLOBAL_ATTRIBUTE1                             ;
    t_old_rec.GLOBAL_ATTRIBUTE2                        := :old.GLOBAL_ATTRIBUTE2                             ;
    t_old_rec.GLOBAL_ATTRIBUTE3                        := :old.GLOBAL_ATTRIBUTE3                             ;
    t_old_rec.GLOBAL_ATTRIBUTE4                        := :old.GLOBAL_ATTRIBUTE4                             ;
    t_old_rec.GLOBAL_ATTRIBUTE5                        := :old.GLOBAL_ATTRIBUTE5                             ;
    t_old_rec.GLOBAL_ATTRIBUTE6                        := :old.GLOBAL_ATTRIBUTE6                             ;
    t_old_rec.GLOBAL_ATTRIBUTE7                        := :old.GLOBAL_ATTRIBUTE7                             ;
    t_old_rec.GLOBAL_ATTRIBUTE8                        := :old.GLOBAL_ATTRIBUTE8                             ;
    t_old_rec.GLOBAL_ATTRIBUTE9                        := :old.GLOBAL_ATTRIBUTE9                             ;
    t_old_rec.GLOBAL_ATTRIBUTE10                       := :old.GLOBAL_ATTRIBUTE10                            ;
    t_old_rec.GLOBAL_ATTRIBUTE11                       := :old.GLOBAL_ATTRIBUTE11                            ;
    t_old_rec.GLOBAL_ATTRIBUTE12                       := :old.GLOBAL_ATTRIBUTE12                            ;
    t_old_rec.GLOBAL_ATTRIBUTE13                       := :old.GLOBAL_ATTRIBUTE13                            ;
    t_old_rec.GLOBAL_ATTRIBUTE14                       := :old.GLOBAL_ATTRIBUTE14                            ;
    t_old_rec.GLOBAL_ATTRIBUTE15                       := :old.GLOBAL_ATTRIBUTE15                            ;
    t_old_rec.GLOBAL_ATTRIBUTE16                       := :old.GLOBAL_ATTRIBUTE16                            ;
    t_old_rec.GLOBAL_ATTRIBUTE17                       := :old.GLOBAL_ATTRIBUTE17                            ;
    t_old_rec.GLOBAL_ATTRIBUTE18                       := :old.GLOBAL_ATTRIBUTE18                            ;
    t_old_rec.GLOBAL_ATTRIBUTE19                       := :old.GLOBAL_ATTRIBUTE19                            ;
    t_old_rec.GLOBAL_ATTRIBUTE20                       := :old.GLOBAL_ATTRIBUTE20                            ;
    t_old_rec.LINE_SELECTED_FOR_APPL_FLAG              := :old.LINE_SELECTED_FOR_APPL_FLAG                   ;
    t_old_rec.PREPAY_APPL_REQUEST_ID                   := :old.PREPAY_APPL_REQUEST_ID                        ;
    t_old_rec.APPLICATION_ID                           := :old.APPLICATION_ID                                ;
    t_old_rec.PRODUCT_TABLE                            := :old.PRODUCT_TABLE                                 ;
    t_old_rec.REFERENCE_KEY1                           := :old.REFERENCE_KEY1                                ;
    t_old_rec.REFERENCE_KEY2                           := :old.REFERENCE_KEY2                                ;
    t_old_rec.REFERENCE_KEY3                           := :old.REFERENCE_KEY3                                ;
    t_old_rec.REFERENCE_KEY4                           := :old.REFERENCE_KEY4                                ;
    t_old_rec.REFERENCE_KEY5                           := :old.REFERENCE_KEY5                                ;
    t_old_rec.PURCHASING_CATEGORY_ID                   := :old.PURCHASING_CATEGORY_ID                        ;
    t_old_rec.COST_FACTOR_ID                           := :old.COST_FACTOR_ID                                ;
    t_old_rec.CONTROL_AMOUNT                           := :old.CONTROL_AMOUNT                                ;
    t_old_rec.ASSESSABLE_VALUE                         := :old.ASSESSABLE_VALUE                              ;
    t_old_rec.TOTAL_REC_TAX_AMOUNT                     := :old.TOTAL_REC_TAX_AMOUNT                          ;
    t_old_rec.TOTAL_NREC_TAX_AMOUNT                    := :old.TOTAL_NREC_TAX_AMOUNT                         ;
    t_old_rec.TOTAL_REC_TAX_AMT_FUNCL_CURR             := :old.TOTAL_REC_TAX_AMT_FUNCL_CURR                  ;
    t_old_rec.TOTAL_NREC_TAX_AMT_FUNCL_CURR            := :old.TOTAL_NREC_TAX_AMT_FUNCL_CURR                 ;
    t_old_rec.INCLUDED_TAX_AMOUNT                      := :old.INCLUDED_TAX_AMOUNT                           ;
    t_old_rec.PRIMARY_INTENDED_USE                     := :old.PRIMARY_INTENDED_USE                          ;
    t_old_rec.TAX_ALREADY_CALCULATED_FLAG              := :old.TAX_ALREADY_CALCULATED_FLAG                   ;
    t_old_rec.SHIP_TO_LOCATION_ID                      := :old.SHIP_TO_LOCATION_ID                           ;
    t_old_rec.PRODUCT_TYPE                             := :old.PRODUCT_TYPE                                  ;
    t_old_rec.PRODUCT_CATEGORY                         := :old.PRODUCT_CATEGORY                              ;
    t_old_rec.PRODUCT_FISC_CLASSIFICATION              := :old.PRODUCT_FISC_CLASSIFICATION                   ;
    t_old_rec.USER_DEFINED_FISC_CLASS                  := :old.USER_DEFINED_FISC_CLASS                       ;
    t_old_rec.TRX_BUSINESS_CATEGORY                    := :old.TRX_BUSINESS_CATEGORY                         ;
    t_old_rec.SUMMARY_TAX_LINE_ID                      := :old.SUMMARY_TAX_LINE_ID                           ;
    t_old_rec.TAX_REGIME_CODE                          := :old.TAX_REGIME_CODE                               ;
    t_old_rec.TAX                                      := :old.TAX                                           ;
    t_old_rec.TAX_JURISDICTION_CODE                    := :old.TAX_JURISDICTION_CODE                         ;
    t_old_rec.TAX_STATUS_CODE                          := :old.TAX_STATUS_CODE                               ;
    t_old_rec.TAX_RATE_ID                              := :old.TAX_RATE_ID                                   ;
    t_old_rec.TAX_RATE_CODE                            := :old.TAX_RATE_CODE                                 ;
    t_old_rec.TAX_RATE                                 := :old.TAX_RATE                                      ;
    t_old_rec.TAX_CODE_ID                              := :old.TAX_CODE_ID                                   ;
    t_old_rec.HISTORICAL_FLAG                          := :old.HISTORICAL_FLAG                               ;
    t_old_rec.TAX_CLASSIFICATION_CODE                  := :old.TAX_CLASSIFICATION_CODE                       ;
    t_old_rec.SOURCE_APPLICATION_ID                    := :old.SOURCE_APPLICATION_ID                         ;
    t_old_rec.SOURCE_EVENT_CLASS_CODE                  := :old.SOURCE_EVENT_CLASS_CODE                       ;
    t_old_rec.SOURCE_ENTITY_CODE                       := :old.SOURCE_ENTITY_CODE                            ;
    t_old_rec.SOURCE_TRX_ID                            := :old.SOURCE_TRX_ID                                 ;
    t_old_rec.SOURCE_LINE_ID                           := :old.SOURCE_LINE_ID                                ;
    t_old_rec.SOURCE_TRX_LEVEL_TYPE                    := :old.SOURCE_TRX_LEVEL_TYPE                         ;
    t_old_rec.RETAINED_AMOUNT                          := :old.RETAINED_AMOUNT                               ;
    t_old_rec.RETAINED_AMOUNT_REMAINING                := :old.RETAINED_AMOUNT_REMAINING                     ;
    t_old_rec.RETAINED_INVOICE_ID                      := :old.RETAINED_INVOICE_ID                           ;
    t_old_rec.RETAINED_LINE_NUMBER                     := :old.RETAINED_LINE_NUMBER                          ;
    t_old_rec.LINE_SELECTED_FOR_RELEASE_FLAG           := :old.LINE_SELECTED_FOR_RELEASE_FLAG                ;
    t_old_rec.LINE_OWNER_ROLE                          := :old.LINE_OWNER_ROLE                               ;
    t_old_rec.DISPUTABLE_FLAG                          := :old.DISPUTABLE_FLAG                               ;
    t_old_rec.RCV_SHIPMENT_LINE_ID                     := :old.RCV_SHIPMENT_LINE_ID                          ;
  END populate_old ;

BEGIN
/*---------------------------------------------------------------------------------------------------------
FILENAME: jai_ap_ila_t.sql
CHANGE HISTORY:

S.No      Date          Author and Details
----------------------------------------------
1         07-Jan-2008   Jason Liu
                        Modified for Retroactive Price
---------------------------------------------------------------------------------------------------------*/
  /*
  || assign the new values depending upon the triggering event.
  */
  IF UPDATING OR INSERTING THEN
     populate_new;
  END IF;


  /*
  || assign the old values depending upon the triggering event.
  */

  IF UPDATING OR DELETING THEN
     populate_old;
  END IF;


  /*
  || make a call to the INR check package.
  */
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AP_ILA_ARIUD_T1', p_set_of_books_id => :new.set_of_books_id ) = FALSE THEN
       RETURN;
  END IF;

  /*
  || check for action in trigger and pass the same to the procedure
  */
  IF    INSERTING THEN
        lv_action := jai_constants.inserting ;
  ELSIF UPDATING THEN
        lv_action := jai_constants.updating ;
  ELSIF DELETING THEN
        lv_action := jai_constants.deleting ;
  END IF ;

  IF INSERTING THEN
    -- Modified by Jason Liu for retroactive price on 2008/01/07
    -- Added RETROITEM
    IF (:NEW.line_type_lookup_code IN ('ITEM' , 'ACCRUAL' , 'RETROITEM')) THEN

      JAI_AP_ILA_TRIGGER_PKG.ARI_T1 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );

      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;

    END IF ;

  -- Added by Jeffsen for standalone invoice on 2007/08/27

  ----------------------------------------------------------------------------
  ELSIF UPDATING
  THEN
    IF (:NEW.line_type_lookup_code = 'ITEM')
    THEN
      UPDATE jai_ap_invoice_lines
      SET    parent_invoice_line_number = :NEW.line_number
      WHERE  parent_invoice_line_number = :OLD.line_number
        AND  invoice_id = :NEW.invoice_id;
      UPDATE jai_ap_invoice_lines
      SET    invoice_line_number = :NEW.line_number
      WHERE  invoice_line_number = :OLD.line_number
        AND  invoice_id = :NEW.invoice_id;
    END IF; -- (:NEW.line_type_loopup_code = 'ITEM')

    -- Added by Jason Liu for retroactive price on 2008/01/07
    ----------------------------------------------------------------------
    IF (:NEW.line_type_lookup_code IN ('ITEM' , 'ACCRUAL' , 'RETROITEM')
          AND :old.po_distribution_id IS NULL
          AND :new.po_distribution_id IS NOT NULL
          AND :new.match_type IN ('ITEM_TO_PO' ,'PO_PRICE_ADJUSTMENT'))
    THEN
      JAI_AP_ILA_TRIGGER_PKG.ARU_T1
                             ( pr_old            => t_old_rec
                             , pr_new            => t_new_rec
                             , pv_action         => lv_action
                             , pv_return_code    => lv_return_code
                             , pv_return_message => lv_return_message
                             );
      IF (lv_return_code <> jai_constants.successful)
      THEN
        RAISE le_error;
      END IF; -- (lv_return_code <> jai_constants.successful)
    END IF; -- (:NEW.line_type_lookup_code IN ('ITEM' , 'ACCRUAL' , 'RETROITEM')
    ----------------------------------------------------------------------
  END IF; -- (INSERTING)
  ----------------------------------------------------------------------------

EXCEPTION

  WHEN le_error THEN

     app_exception.raise_exception (
                                     EXCEPTION_TYPE  => 'APP'  ,
                                     EXCEPTION_CODE  => -20110 ,
                                     EXCEPTION_TEXT  => lv_return_message
                                   );

  WHEN OTHERS THEN

      app_exception.raise_exception (
                                      EXCEPTION_TYPE  => 'APP',
                                      EXCEPTION_CODE  => -20110 ,
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AP_ILA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AP_ILA_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_AP_ILA_ARIUD_T1" DISABLE;
