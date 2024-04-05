--------------------------------------------------------
--  DDL for Trigger JAI_AP_IDA_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AP_IDA_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "AP"."AP_INVOICE_DISTRIBUTIONS_ALL"
FOR EACH ROW
/* Change History
 -------------------------------------------------------------------------------
 S.No      Date         Author and Details
 -------------------------------------------------------------------------------
 1.        16/05/2008   JMEENA for bug#6995295.
 			Issue: :new.org_id and :new.set_of_books_id is passed in call of jai_cmn_utils_pkg.check_jai_exists
 			in case of delete instead of :old.org_id and :old.set_of_books_id
 			Resolution:Resolution: Added the IF DELETING condition and assigned :old.org_id and :old.set_of_books_id to lv_org_id and lv_set_of_books_id in case of DELETING.
*/
DECLARE
  t_old_rec             AP_INVOICE_DISTRIBUTIONS_ALL%rowtype ;
  t_new_rec             AP_INVOICE_DISTRIBUTIONS_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;
  --Added for 6995295 by JMEENA
  lv_org_id		NUMBER(15);
  lv_set_of_books_id	NUMBER(15);


  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

  /* S.no   Bug .No    Date        Author
      1     6493858    4-Dec-2007  Added by Nitin Prashar , In order to display messages */

    t_new_rec.ACCOUNTING_DATE                          := :new.ACCOUNTING_DATE                               ;
    t_new_rec.ACCRUAL_POSTED_FLAG                      := :new.ACCRUAL_POSTED_FLAG                           ;
    t_new_rec.ASSETS_ADDITION_FLAG                     := :new.ASSETS_ADDITION_FLAG                          ;
    t_new_rec.ASSETS_TRACKING_FLAG                     := :new.ASSETS_TRACKING_FLAG                          ;
    t_new_rec.CASH_POSTED_FLAG                         := :new.CASH_POSTED_FLAG                              ;
    t_new_rec.DISTRIBUTION_LINE_NUMBER                 := :new.DISTRIBUTION_LINE_NUMBER                      ;
    t_new_rec.DIST_CODE_COMBINATION_ID                 := :new.DIST_CODE_COMBINATION_ID                      ;
    t_new_rec.INVOICE_ID                               := :new.INVOICE_ID                                    ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LINE_TYPE_LOOKUP_CODE                    := :new.LINE_TYPE_LOOKUP_CODE                         ;
    t_new_rec.PERIOD_NAME                              := :new.PERIOD_NAME                                   ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :new.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.BASE_AMOUNT                              := :new.BASE_AMOUNT                                   ;
    t_new_rec.BASE_INVOICE_PRICE_VARIANCE              := :new.BASE_INVOICE_PRICE_VARIANCE                   ;
    t_new_rec.BATCH_ID                                 := :new.BATCH_ID                                      ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.DESCRIPTION                              := :new.DESCRIPTION                                   ;
    t_new_rec.EXCHANGE_RATE_VARIANCE                   := :new.EXCHANGE_RATE_VARIANCE                        ;
    t_new_rec.FINAL_MATCH_FLAG                         := :new.FINAL_MATCH_FLAG                              ;
    t_new_rec.INCOME_TAX_REGION                        := :new.INCOME_TAX_REGION                             ;
    t_new_rec.INVOICE_PRICE_VARIANCE                   := :new.INVOICE_PRICE_VARIANCE                        ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.MATCH_STATUS_FLAG                        := :new.MATCH_STATUS_FLAG                             ;
    t_new_rec.POSTED_FLAG                              := :new.POSTED_FLAG                                   ;
    t_new_rec.PO_DISTRIBUTION_ID                       := :new.PO_DISTRIBUTION_ID                            ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.QUANTITY_INVOICED                        := :new.QUANTITY_INVOICED                             ;
    t_new_rec.RATE_VAR_CODE_COMBINATION_ID             := :new.RATE_VAR_CODE_COMBINATION_ID                  ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.REVERSAL_FLAG                            := :new.REVERSAL_FLAG                                 ;
    t_new_rec.TYPE_1099                                := :new.TYPE_1099                                     ;
    t_new_rec.UNIT_PRICE                               := :new.UNIT_PRICE                                    ;
    t_new_rec.AMOUNT_ENCUMBERED                        := :new.AMOUNT_ENCUMBERED                             ;
    t_new_rec.BASE_AMOUNT_ENCUMBERED                   := :new.BASE_AMOUNT_ENCUMBERED                        ;
    t_new_rec.ENCUMBERED_FLAG                          := :new.ENCUMBERED_FLAG                               ;
    t_new_rec.EXCHANGE_DATE                            := :new.EXCHANGE_DATE                                 ;
    t_new_rec.EXCHANGE_RATE                            := :new.EXCHANGE_RATE                                 ;
    t_new_rec.EXCHANGE_RATE_TYPE                       := :new.EXCHANGE_RATE_TYPE                            ;
    t_new_rec.PRICE_ADJUSTMENT_FLAG                    := :new.PRICE_ADJUSTMENT_FLAG                         ;
    t_new_rec.PRICE_VAR_CODE_COMBINATION_ID            := :new.PRICE_VAR_CODE_COMBINATION_ID                 ;
    t_new_rec.QUANTITY_UNENCUMBERED                    := :new.QUANTITY_UNENCUMBERED                         ;
    t_new_rec.STAT_AMOUNT                              := :new.STAT_AMOUNT                                   ;
    t_new_rec.AMOUNT_TO_POST                           := :new.AMOUNT_TO_POST                                ;
    t_new_rec.ATTRIBUTE1                               := :new.ATTRIBUTE1                                    ;
    t_new_rec.ATTRIBUTE10                              := :new.ATTRIBUTE10                                   ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.ATTRIBUTE2                               := :new.ATTRIBUTE2                                    ;
    t_new_rec.ATTRIBUTE3                               := :new.ATTRIBUTE3                                    ;
    t_new_rec.ATTRIBUTE4                               := :new.ATTRIBUTE4                                    ;
    t_new_rec.ATTRIBUTE5                               := :new.ATTRIBUTE5                                    ;
    t_new_rec.ATTRIBUTE6                               := :new.ATTRIBUTE6                                    ;
    t_new_rec.ATTRIBUTE7                               := :new.ATTRIBUTE7                                    ;
    t_new_rec.ATTRIBUTE8                               := :new.ATTRIBUTE8                                    ;
    t_new_rec.ATTRIBUTE9                               := :new.ATTRIBUTE9                                    ;
    t_new_rec.ATTRIBUTE_CATEGORY                       := :new.ATTRIBUTE_CATEGORY                            ;
    t_new_rec.BASE_AMOUNT_TO_POST                      := :new.BASE_AMOUNT_TO_POST                           ;
    t_new_rec.CASH_JE_BATCH_ID                         := :new.CASH_JE_BATCH_ID                              ;
    t_new_rec.EXPENDITURE_ITEM_DATE                    := :new.EXPENDITURE_ITEM_DATE                         ;
    t_new_rec.EXPENDITURE_ORGANIZATION_ID              := :new.EXPENDITURE_ORGANIZATION_ID                   ;
    t_new_rec.EXPENDITURE_TYPE                         := :new.EXPENDITURE_TYPE                              ;
    t_new_rec.JE_BATCH_ID                              := :new.JE_BATCH_ID                                   ;
    t_new_rec.PARENT_INVOICE_ID                        := :new.PARENT_INVOICE_ID                             ;
    t_new_rec.PA_ADDITION_FLAG                         := :new.PA_ADDITION_FLAG                              ;
    t_new_rec.PA_QUANTITY                              := :new.PA_QUANTITY                                   ;
    t_new_rec.POSTED_AMOUNT                            := :new.POSTED_AMOUNT                                 ;
    t_new_rec.POSTED_BASE_AMOUNT                       := :new.POSTED_BASE_AMOUNT                            ;
    t_new_rec.PREPAY_AMOUNT_REMAINING                  := :new.PREPAY_AMOUNT_REMAINING                       ;
    t_new_rec.PROJECT_ACCOUNTING_CONTEXT               := :new.PROJECT_ACCOUNTING_CONTEXT                    ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.USSGL_TRX_CODE_CONTEXT                   := :new.USSGL_TRX_CODE_CONTEXT                        ;
    t_new_rec.EARLIEST_SETTLEMENT_DATE                 := :new.EARLIEST_SETTLEMENT_DATE                      ;
    t_new_rec.REQ_DISTRIBUTION_ID                      := :new.REQ_DISTRIBUTION_ID                           ;
    t_new_rec.QUANTITY_VARIANCE                        := :new.QUANTITY_VARIANCE                             ;
    t_new_rec.BASE_QUANTITY_VARIANCE                   := :new.BASE_QUANTITY_VARIANCE                        ;
    t_new_rec.PACKET_ID                                := :new.PACKET_ID                                     ;
    t_new_rec.AWT_FLAG                                 := :new.AWT_FLAG                                      ;
    t_new_rec.AWT_GROUP_ID                             := :new.AWT_GROUP_ID                                  ;
    t_new_rec.AWT_TAX_RATE_ID                          := :new.AWT_TAX_RATE_ID                               ;
    t_new_rec.AWT_GROSS_AMOUNT                         := :new.AWT_GROSS_AMOUNT                              ;
    t_new_rec.AWT_INVOICE_ID                           := :new.AWT_INVOICE_ID                                ;
    t_new_rec.AWT_ORIGIN_GROUP_ID                      := :new.AWT_ORIGIN_GROUP_ID                           ;
    t_new_rec.REFERENCE_1                              := :new.REFERENCE_1                                   ;
    t_new_rec.REFERENCE_2                              := :new.REFERENCE_2                                   ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.OTHER_INVOICE_ID                         := :new.OTHER_INVOICE_ID                              ;
    t_new_rec.AWT_INVOICE_PAYMENT_ID                   := :new.AWT_INVOICE_PAYMENT_ID                        ;
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
    t_new_rec.LINE_GROUP_NUMBER                        := :new.LINE_GROUP_NUMBER                             ;
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
    t_new_rec.AWARD_ID                                 := :new.AWARD_ID                                      ;
    t_new_rec.MRC_ACCRUAL_POSTED_FLAG                  := :new.MRC_ACCRUAL_POSTED_FLAG                       ;
    t_new_rec.MRC_CASH_POSTED_FLAG                     := :new.MRC_CASH_POSTED_FLAG                          ;
    t_new_rec.MRC_DIST_CODE_COMBINATION_ID             := :new.MRC_DIST_CODE_COMBINATION_ID                  ;
    t_new_rec.MRC_AMOUNT                               := :new.MRC_AMOUNT                                    ;
    t_new_rec.MRC_BASE_AMOUNT                          := :new.MRC_BASE_AMOUNT                               ;
    t_new_rec.MRC_BASE_INV_PRICE_VARIANCE              := :new.MRC_BASE_INV_PRICE_VARIANCE                   ;
    t_new_rec.MRC_EXCHANGE_RATE_VARIANCE               := :new.MRC_EXCHANGE_RATE_VARIANCE                    ;
    t_new_rec.MRC_POSTED_FLAG                          := :new.MRC_POSTED_FLAG                               ;
    t_new_rec.MRC_PROGRAM_APPLICATION_ID               := :new.MRC_PROGRAM_APPLICATION_ID                    ;
    t_new_rec.MRC_PROGRAM_ID                           := :new.MRC_PROGRAM_ID                                ;
    t_new_rec.MRC_PROGRAM_UPDATE_DATE                  := :new.MRC_PROGRAM_UPDATE_DATE                       ;
    t_new_rec.MRC_RATE_VAR_CCID                        := :new.MRC_RATE_VAR_CCID                             ;
    t_new_rec.MRC_REQUEST_ID                           := :new.MRC_REQUEST_ID                                ;
    t_new_rec.MRC_EXCHANGE_DATE                        := :new.MRC_EXCHANGE_DATE                             ;
    t_new_rec.MRC_EXCHANGE_RATE                        := :new.MRC_EXCHANGE_RATE                             ;
    t_new_rec.MRC_EXCHANGE_RATE_TYPE                   := :new.MRC_EXCHANGE_RATE_TYPE                        ;
    t_new_rec.MRC_AMOUNT_TO_POST                       := :new.MRC_AMOUNT_TO_POST                            ;
    t_new_rec.MRC_BASE_AMOUNT_TO_POST                  := :new.MRC_BASE_AMOUNT_TO_POST                       ;
    t_new_rec.MRC_CASH_JE_BATCH_ID                     := :new.MRC_CASH_JE_BATCH_ID                          ;
    t_new_rec.MRC_JE_BATCH_ID                          := :new.MRC_JE_BATCH_ID                               ;
    t_new_rec.MRC_POSTED_AMOUNT                        := :new.MRC_POSTED_AMOUNT                             ;
    t_new_rec.MRC_POSTED_BASE_AMOUNT                   := :new.MRC_POSTED_BASE_AMOUNT                        ;
    t_new_rec.MRC_RECEIPT_CONVERSION_RATE              := :new.MRC_RECEIPT_CONVERSION_RATE                   ;
    t_new_rec.CREDIT_CARD_TRX_ID                       := :new.CREDIT_CARD_TRX_ID                            ;
    t_new_rec.DIST_MATCH_TYPE                          := :new.DIST_MATCH_TYPE                               ;
    t_new_rec.RCV_TRANSACTION_ID                       := :new.RCV_TRANSACTION_ID                            ;
    t_new_rec.INVOICE_DISTRIBUTION_ID                  := :new.INVOICE_DISTRIBUTION_ID                       ;
    t_new_rec.PARENT_REVERSAL_ID                       := :new.PARENT_REVERSAL_ID                            ;
    t_new_rec.TAX_RECOVERABLE_FLAG                     := :new.TAX_RECOVERABLE_FLAG                          ;
    t_new_rec.PA_CC_AR_INVOICE_ID                      := :new.PA_CC_AR_INVOICE_ID                           ;
    t_new_rec.PA_CC_AR_INVOICE_LINE_NUM                := :new.PA_CC_AR_INVOICE_LINE_NUM                     ;
    t_new_rec.PA_CC_PROCESSED_CODE                     := :new.PA_CC_PROCESSED_CODE                          ;
    t_new_rec.MERCHANT_DOCUMENT_NUMBER                 := :new.MERCHANT_DOCUMENT_NUMBER                      ;
    t_new_rec.MERCHANT_NAME                            := :new.MERCHANT_NAME                                 ;
    t_new_rec.MERCHANT_REFERENCE                       := :new.MERCHANT_REFERENCE                            ;
    t_new_rec.MERCHANT_TAX_REG_NUMBER                  := :new.MERCHANT_TAX_REG_NUMBER                       ;
    t_new_rec.MERCHANT_TAXPAYER_ID                     := :new.MERCHANT_TAXPAYER_ID                          ;
    t_new_rec.COUNTRY_OF_SUPPLY                        := :new.COUNTRY_OF_SUPPLY                             ;
    t_new_rec.MATCHED_UOM_LOOKUP_CODE                  := :new.MATCHED_UOM_LOOKUP_CODE                       ;
    t_new_rec.GMS_BURDENABLE_RAW_COST                  := :new.GMS_BURDENABLE_RAW_COST                       ;
    t_new_rec.ACCOUNTING_EVENT_ID                      := :new.ACCOUNTING_EVENT_ID                           ;
    t_new_rec.PREPAY_DISTRIBUTION_ID                   := :new.PREPAY_DISTRIBUTION_ID                        ;
    t_new_rec.UPGRADE_POSTED_AMT                       := :new.UPGRADE_POSTED_AMT                            ;
    t_new_rec.UPGRADE_BASE_POSTED_AMT                  := :new.UPGRADE_BASE_POSTED_AMT                       ;
    t_new_rec.INVENTORY_TRANSFER_STATUS                := :new.INVENTORY_TRANSFER_STATUS                     ;
    t_new_rec.COMPANY_PREPAID_INVOICE_ID               := :new.COMPANY_PREPAID_INVOICE_ID                    ;
    t_new_rec.CC_REVERSAL_FLAG                         := :new.CC_REVERSAL_FLAG                              ;
    t_new_rec.AWT_WITHHELD_AMT                         := :new.AWT_WITHHELD_AMT                              ;
    t_new_rec.INVOICE_INCLUDES_PREPAY_FLAG             := :new.INVOICE_INCLUDES_PREPAY_FLAG                  ;
    t_new_rec.PRICE_CORRECT_INV_ID                     := :new.PRICE_CORRECT_INV_ID                          ;
    t_new_rec.PRICE_CORRECT_QTY                        := :new.PRICE_CORRECT_QTY                             ;
    t_new_rec.PA_CMT_XFACE_FLAG                        := :new.PA_CMT_XFACE_FLAG                             ;
    t_new_rec.CANCELLATION_FLAG                        := :new.CANCELLATION_FLAG                             ;
    t_new_rec.INVOICE_LINE_NUMBER                      := :new.INVOICE_LINE_NUMBER                           ;
    t_new_rec.CORRECTED_INVOICE_DIST_ID                := :new.CORRECTED_INVOICE_DIST_ID                     ;
    t_new_rec.ROUNDING_AMT                             := :new.ROUNDING_AMT                                  ;
    t_new_rec.CHARGE_APPLICABLE_TO_DIST_ID             := :new.CHARGE_APPLICABLE_TO_DIST_ID                  ;
    t_new_rec.CORRECTED_QUANTITY                       := :new.CORRECTED_QUANTITY                            ;
    t_new_rec.RELATED_ID                               := :new.RELATED_ID                                    ;
    t_new_rec.ASSET_BOOK_TYPE_CODE                     := :new.ASSET_BOOK_TYPE_CODE                          ;
    t_new_rec.ASSET_CATEGORY_ID                        := :new.ASSET_CATEGORY_ID                             ;
    t_new_rec.DISTRIBUTION_CLASS                       := :new.DISTRIBUTION_CLASS                            ;
    t_new_rec.FINAL_PAYMENT_ROUNDING                   := :new.FINAL_PAYMENT_ROUNDING                        ;
    t_new_rec.FINAL_APPLICATION_ROUNDING               := :new.FINAL_APPLICATION_ROUNDING                    ;
    t_new_rec.AMOUNT_AT_PREPAY_XRATE                   := :new.AMOUNT_AT_PREPAY_XRATE                        ;
    t_new_rec.CASH_BASIS_FINAL_APP_ROUNDING            := :new.CASH_BASIS_FINAL_APP_ROUNDING                 ;
    t_new_rec.AMOUNT_AT_PREPAY_PAY_XRATE               := :new.AMOUNT_AT_PREPAY_PAY_XRATE                    ;
    t_new_rec.INTENDED_USE                             := :new.INTENDED_USE                                  ;
    t_new_rec.DETAIL_TAX_DIST_ID                       := :new.DETAIL_TAX_DIST_ID                            ;
    t_new_rec.REC_NREC_RATE                            := :new.REC_NREC_RATE                                 ;
    t_new_rec.RECOVERY_RATE_ID                         := :new.RECOVERY_RATE_ID                              ;
    t_new_rec.RECOVERY_RATE_NAME                       := :new.RECOVERY_RATE_NAME                            ;
    t_new_rec.RECOVERY_TYPE_CODE                       := :new.RECOVERY_TYPE_CODE                            ;
    t_new_rec.RECOVERY_RATE_CODE                       := :new.RECOVERY_RATE_CODE                            ;
    t_new_rec.WITHHOLDING_TAX_CODE_ID                  := :new.WITHHOLDING_TAX_CODE_ID                       ;
    t_new_rec.TAX_ALREADY_DISTRIBUTED_FLAG             := :new.TAX_ALREADY_DISTRIBUTED_FLAG                  ;
    t_new_rec.SUMMARY_TAX_LINE_ID                      := :new.SUMMARY_TAX_LINE_ID                           ;
    t_new_rec.TAXABLE_AMOUNT                           := :new.TAXABLE_AMOUNT                                ;
    t_new_rec.TAXABLE_BASE_AMOUNT                      := :new.TAXABLE_BASE_AMOUNT                           ;
    t_new_rec.EXTRA_PO_ERV                             := :new.EXTRA_PO_ERV                                  ;
    t_new_rec.PREPAY_TAX_DIFF_AMOUNT                   := :new.PREPAY_TAX_DIFF_AMOUNT                        ;
    t_new_rec.TAX_CODE_ID                              := :new.TAX_CODE_ID                                   ;
    t_new_rec.VAT_CODE                                 := :new.VAT_CODE                                      ;
    t_new_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :new.AMOUNT_INCLUDES_TAX_FLAG                      ;
    t_new_rec.TAX_CALCULATED_FLAG                      := :new.TAX_CALCULATED_FLAG                           ;
    t_new_rec.TAX_RECOVERY_RATE                        := :new.TAX_RECOVERY_RATE                             ;
    t_new_rec.TAX_RECOVERY_OVERRIDE_FLAG               := :new.TAX_RECOVERY_OVERRIDE_FLAG                    ;
    t_new_rec.TAX_CODE_OVERRIDE_FLAG                   := :new.TAX_CODE_OVERRIDE_FLAG                        ;
    t_new_rec.TOTAL_DIST_AMOUNT                        := :new.TOTAL_DIST_AMOUNT                             ;
    t_new_rec.TOTAL_DIST_BASE_AMOUNT                   := :new.TOTAL_DIST_BASE_AMOUNT                        ;
    t_new_rec.PREPAY_TAX_PARENT_ID                     := :new.PREPAY_TAX_PARENT_ID                          ;
    t_new_rec.CANCELLED_FLAG                           := :new.CANCELLED_FLAG                                ;
    t_new_rec.OLD_DISTRIBUTION_ID                      := :new.OLD_DISTRIBUTION_ID                           ;
    t_new_rec.OLD_DIST_LINE_NUMBER                     := :new.OLD_DIST_LINE_NUMBER                          ;
    t_new_rec.AMOUNT_VARIANCE                          := :new.AMOUNT_VARIANCE                               ;
    t_new_rec.BASE_AMOUNT_VARIANCE                     := :new.BASE_AMOUNT_VARIANCE                          ;
    t_new_rec.HISTORICAL_FLAG                          := :new.HISTORICAL_FLAG                               ;
    t_new_rec.RCV_CHARGE_ADDITION_FLAG                 := :new.RCV_CHARGE_ADDITION_FLAG                      ;
    t_new_rec.AWT_RELATED_ID                           := :new.AWT_RELATED_ID                                ;
    t_new_rec.RELATED_RETAINAGE_DIST_ID                := :new.RELATED_RETAINAGE_DIST_ID                     ;
    t_new_rec.RETAINED_AMOUNT_REMAINING                := :new.RETAINED_AMOUNT_REMAINING                     ;
    t_new_rec.BC_EVENT_ID                              := :new.BC_EVENT_ID                                   ;
    t_new_rec.RETAINED_INVOICE_DIST_ID                 := :new.RETAINED_INVOICE_DIST_ID                      ;
    t_new_rec.FINAL_RELEASE_ROUNDING                   := :new.FINAL_RELEASE_ROUNDING                        ;
    t_new_rec.FULLY_PAID_ACCTD_FLAG                    := :new.FULLY_PAID_ACCTD_FLAG                         ;
    t_new_rec.ROOT_DISTRIBUTION_ID                     := :new.ROOT_DISTRIBUTION_ID                          ;
    t_new_rec.XINV_PARENT_REVERSAL_ID                  := :new.XINV_PARENT_REVERSAL_ID                       ;
    t_new_rec.RECURRING_PAYMENT_ID                     := :new.RECURRING_PAYMENT_ID                          ;
    t_new_rec.RELEASE_INV_DIST_DERIVED_FROM            := :new.RELEASE_INV_DIST_DERIVED_FROM                 ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.ACCOUNTING_DATE                          := :old.ACCOUNTING_DATE                               ;
    t_old_rec.ACCRUAL_POSTED_FLAG                      := :old.ACCRUAL_POSTED_FLAG                           ;
    t_old_rec.ASSETS_ADDITION_FLAG                     := :old.ASSETS_ADDITION_FLAG                          ;
    t_old_rec.ASSETS_TRACKING_FLAG                     := :old.ASSETS_TRACKING_FLAG                          ;
    t_old_rec.CASH_POSTED_FLAG                         := :old.CASH_POSTED_FLAG                              ;
    t_old_rec.DISTRIBUTION_LINE_NUMBER                 := :old.DISTRIBUTION_LINE_NUMBER                      ;
    t_old_rec.DIST_CODE_COMBINATION_ID                 := :old.DIST_CODE_COMBINATION_ID                      ;
    t_old_rec.INVOICE_ID                               := :old.INVOICE_ID                                    ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LINE_TYPE_LOOKUP_CODE                    := :old.LINE_TYPE_LOOKUP_CODE                         ;
    t_old_rec.PERIOD_NAME                              := :old.PERIOD_NAME                                   ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :old.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.BASE_AMOUNT                              := :old.BASE_AMOUNT                                   ;
    t_old_rec.BASE_INVOICE_PRICE_VARIANCE              := :old.BASE_INVOICE_PRICE_VARIANCE                   ;
    t_old_rec.BATCH_ID                                 := :old.BATCH_ID                                      ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.DESCRIPTION                              := :old.DESCRIPTION                                   ;
    t_old_rec.EXCHANGE_RATE_VARIANCE                   := :old.EXCHANGE_RATE_VARIANCE                        ;
    t_old_rec.FINAL_MATCH_FLAG                         := :old.FINAL_MATCH_FLAG                              ;
    t_old_rec.INCOME_TAX_REGION                        := :old.INCOME_TAX_REGION                             ;
    t_old_rec.INVOICE_PRICE_VARIANCE                   := :old.INVOICE_PRICE_VARIANCE                        ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.MATCH_STATUS_FLAG                        := :old.MATCH_STATUS_FLAG                             ;
    t_old_rec.POSTED_FLAG                              := :old.POSTED_FLAG                                   ;
    t_old_rec.PO_DISTRIBUTION_ID                       := :old.PO_DISTRIBUTION_ID                            ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.QUANTITY_INVOICED                        := :old.QUANTITY_INVOICED                             ;
    t_old_rec.RATE_VAR_CODE_COMBINATION_ID             := :old.RATE_VAR_CODE_COMBINATION_ID                  ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.REVERSAL_FLAG                            := :old.REVERSAL_FLAG                                 ;
    t_old_rec.TYPE_1099                                := :old.TYPE_1099                                     ;
    t_old_rec.UNIT_PRICE                               := :old.UNIT_PRICE                                    ;
    t_old_rec.AMOUNT_ENCUMBERED                        := :old.AMOUNT_ENCUMBERED                             ;
    t_old_rec.BASE_AMOUNT_ENCUMBERED                   := :old.BASE_AMOUNT_ENCUMBERED                        ;
    t_old_rec.ENCUMBERED_FLAG                          := :old.ENCUMBERED_FLAG                               ;
    t_old_rec.EXCHANGE_DATE                            := :old.EXCHANGE_DATE                                 ;
    t_old_rec.EXCHANGE_RATE                            := :old.EXCHANGE_RATE                                 ;
    t_old_rec.EXCHANGE_RATE_TYPE                       := :old.EXCHANGE_RATE_TYPE                            ;
    t_old_rec.PRICE_ADJUSTMENT_FLAG                    := :old.PRICE_ADJUSTMENT_FLAG                         ;
    t_old_rec.PRICE_VAR_CODE_COMBINATION_ID            := :old.PRICE_VAR_CODE_COMBINATION_ID                 ;
    t_old_rec.QUANTITY_UNENCUMBERED                    := :old.QUANTITY_UNENCUMBERED                         ;
    t_old_rec.STAT_AMOUNT                              := :old.STAT_AMOUNT                                   ;
    t_old_rec.AMOUNT_TO_POST                           := :old.AMOUNT_TO_POST                                ;
    t_old_rec.ATTRIBUTE1                               := :old.ATTRIBUTE1                                    ;
    t_old_rec.ATTRIBUTE10                              := :old.ATTRIBUTE10                                   ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.ATTRIBUTE2                               := :old.ATTRIBUTE2                                    ;
    t_old_rec.ATTRIBUTE3                               := :old.ATTRIBUTE3                                    ;
    t_old_rec.ATTRIBUTE4                               := :old.ATTRIBUTE4                                    ;
    t_old_rec.ATTRIBUTE5                               := :old.ATTRIBUTE5                                    ;
    t_old_rec.ATTRIBUTE6                               := :old.ATTRIBUTE6                                    ;
    t_old_rec.ATTRIBUTE7                               := :old.ATTRIBUTE7                                    ;
    t_old_rec.ATTRIBUTE8                               := :old.ATTRIBUTE8                                    ;
    t_old_rec.ATTRIBUTE9                               := :old.ATTRIBUTE9                                    ;
    t_old_rec.ATTRIBUTE_CATEGORY                       := :old.ATTRIBUTE_CATEGORY                            ;
    t_old_rec.BASE_AMOUNT_TO_POST                      := :old.BASE_AMOUNT_TO_POST                           ;
    t_old_rec.CASH_JE_BATCH_ID                         := :old.CASH_JE_BATCH_ID                              ;
    t_old_rec.EXPENDITURE_ITEM_DATE                    := :old.EXPENDITURE_ITEM_DATE                         ;
    t_old_rec.EXPENDITURE_ORGANIZATION_ID              := :old.EXPENDITURE_ORGANIZATION_ID                   ;
    t_old_rec.EXPENDITURE_TYPE                         := :old.EXPENDITURE_TYPE                              ;
    t_old_rec.JE_BATCH_ID                              := :old.JE_BATCH_ID                                   ;
    t_old_rec.PARENT_INVOICE_ID                        := :old.PARENT_INVOICE_ID                             ;
    t_old_rec.PA_ADDITION_FLAG                         := :old.PA_ADDITION_FLAG                              ;
    t_old_rec.PA_QUANTITY                              := :old.PA_QUANTITY                                   ;
    t_old_rec.POSTED_AMOUNT                            := :old.POSTED_AMOUNT                                 ;
    t_old_rec.POSTED_BASE_AMOUNT                       := :old.POSTED_BASE_AMOUNT                            ;
    t_old_rec.PREPAY_AMOUNT_REMAINING                  := :old.PREPAY_AMOUNT_REMAINING                       ;
    t_old_rec.PROJECT_ACCOUNTING_CONTEXT               := :old.PROJECT_ACCOUNTING_CONTEXT                    ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.USSGL_TRX_CODE_CONTEXT                   := :old.USSGL_TRX_CODE_CONTEXT                        ;
    t_old_rec.EARLIEST_SETTLEMENT_DATE                 := :old.EARLIEST_SETTLEMENT_DATE                      ;
    t_old_rec.REQ_DISTRIBUTION_ID                      := :old.REQ_DISTRIBUTION_ID                           ;
    t_old_rec.QUANTITY_VARIANCE                        := :old.QUANTITY_VARIANCE                             ;
    t_old_rec.BASE_QUANTITY_VARIANCE                   := :old.BASE_QUANTITY_VARIANCE                        ;
    t_old_rec.PACKET_ID                                := :old.PACKET_ID                                     ;
    t_old_rec.AWT_FLAG                                 := :old.AWT_FLAG                                      ;
    t_old_rec.AWT_GROUP_ID                             := :old.AWT_GROUP_ID                                  ;
    t_old_rec.AWT_TAX_RATE_ID                          := :old.AWT_TAX_RATE_ID                               ;
    t_old_rec.AWT_GROSS_AMOUNT                         := :old.AWT_GROSS_AMOUNT                              ;
    t_old_rec.AWT_INVOICE_ID                           := :old.AWT_INVOICE_ID                                ;
    t_old_rec.AWT_ORIGIN_GROUP_ID                      := :old.AWT_ORIGIN_GROUP_ID                           ;
    t_old_rec.REFERENCE_1                              := :old.REFERENCE_1                                   ;
    t_old_rec.REFERENCE_2                              := :old.REFERENCE_2                                   ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.OTHER_INVOICE_ID                         := :old.OTHER_INVOICE_ID                              ;
    t_old_rec.AWT_INVOICE_PAYMENT_ID                   := :old.AWT_INVOICE_PAYMENT_ID                        ;
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
    t_old_rec.LINE_GROUP_NUMBER                        := :old.LINE_GROUP_NUMBER                             ;
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
    t_old_rec.AWARD_ID                                 := :old.AWARD_ID                                      ;
    t_old_rec.MRC_ACCRUAL_POSTED_FLAG                  := :old.MRC_ACCRUAL_POSTED_FLAG                       ;
    t_old_rec.MRC_CASH_POSTED_FLAG                     := :old.MRC_CASH_POSTED_FLAG                          ;
    t_old_rec.MRC_DIST_CODE_COMBINATION_ID             := :old.MRC_DIST_CODE_COMBINATION_ID                  ;
    t_old_rec.MRC_AMOUNT                               := :old.MRC_AMOUNT                                    ;
    t_old_rec.MRC_BASE_AMOUNT                          := :old.MRC_BASE_AMOUNT                               ;
    t_old_rec.MRC_BASE_INV_PRICE_VARIANCE              := :old.MRC_BASE_INV_PRICE_VARIANCE                   ;
    t_old_rec.MRC_EXCHANGE_RATE_VARIANCE               := :old.MRC_EXCHANGE_RATE_VARIANCE                    ;
    t_old_rec.MRC_POSTED_FLAG                          := :old.MRC_POSTED_FLAG                               ;
    t_old_rec.MRC_PROGRAM_APPLICATION_ID               := :old.MRC_PROGRAM_APPLICATION_ID                    ;
    t_old_rec.MRC_PROGRAM_ID                           := :old.MRC_PROGRAM_ID                                ;
    t_old_rec.MRC_PROGRAM_UPDATE_DATE                  := :old.MRC_PROGRAM_UPDATE_DATE                       ;
    t_old_rec.MRC_RATE_VAR_CCID                        := :old.MRC_RATE_VAR_CCID                             ;
    t_old_rec.MRC_REQUEST_ID                           := :old.MRC_REQUEST_ID                                ;
    t_old_rec.MRC_EXCHANGE_DATE                        := :old.MRC_EXCHANGE_DATE                             ;
    t_old_rec.MRC_EXCHANGE_RATE                        := :old.MRC_EXCHANGE_RATE                             ;
    t_old_rec.MRC_EXCHANGE_RATE_TYPE                   := :old.MRC_EXCHANGE_RATE_TYPE                        ;
    t_old_rec.MRC_AMOUNT_TO_POST                       := :old.MRC_AMOUNT_TO_POST                            ;
    t_old_rec.MRC_BASE_AMOUNT_TO_POST                  := :old.MRC_BASE_AMOUNT_TO_POST                       ;
    t_old_rec.MRC_CASH_JE_BATCH_ID                     := :old.MRC_CASH_JE_BATCH_ID                          ;
    t_old_rec.MRC_JE_BATCH_ID                          := :old.MRC_JE_BATCH_ID                               ;
    t_old_rec.MRC_POSTED_AMOUNT                        := :old.MRC_POSTED_AMOUNT                             ;
    t_old_rec.MRC_POSTED_BASE_AMOUNT                   := :old.MRC_POSTED_BASE_AMOUNT                        ;
    t_old_rec.MRC_RECEIPT_CONVERSION_RATE              := :old.MRC_RECEIPT_CONVERSION_RATE                   ;
    t_old_rec.CREDIT_CARD_TRX_ID                       := :old.CREDIT_CARD_TRX_ID                            ;
    t_old_rec.DIST_MATCH_TYPE                          := :old.DIST_MATCH_TYPE                               ;
    t_old_rec.RCV_TRANSACTION_ID                       := :old.RCV_TRANSACTION_ID                            ;
    t_old_rec.INVOICE_DISTRIBUTION_ID                  := :old.INVOICE_DISTRIBUTION_ID                       ;
    t_old_rec.PARENT_REVERSAL_ID                       := :old.PARENT_REVERSAL_ID                            ;
    t_old_rec.TAX_RECOVERABLE_FLAG                     := :old.TAX_RECOVERABLE_FLAG                          ;
    t_old_rec.PA_CC_AR_INVOICE_ID                      := :old.PA_CC_AR_INVOICE_ID                           ;
    t_old_rec.PA_CC_AR_INVOICE_LINE_NUM                := :old.PA_CC_AR_INVOICE_LINE_NUM                     ;
    t_old_rec.PA_CC_PROCESSED_CODE                     := :old.PA_CC_PROCESSED_CODE                          ;
    t_old_rec.MERCHANT_DOCUMENT_NUMBER                 := :old.MERCHANT_DOCUMENT_NUMBER                      ;
    t_old_rec.MERCHANT_NAME                            := :old.MERCHANT_NAME                                 ;
    t_old_rec.MERCHANT_REFERENCE                       := :old.MERCHANT_REFERENCE                            ;
    t_old_rec.MERCHANT_TAX_REG_NUMBER                  := :old.MERCHANT_TAX_REG_NUMBER                       ;
    t_old_rec.MERCHANT_TAXPAYER_ID                     := :old.MERCHANT_TAXPAYER_ID                          ;
    t_old_rec.COUNTRY_OF_SUPPLY                        := :old.COUNTRY_OF_SUPPLY                             ;
    t_old_rec.MATCHED_UOM_LOOKUP_CODE                  := :old.MATCHED_UOM_LOOKUP_CODE                       ;
    t_old_rec.GMS_BURDENABLE_RAW_COST                  := :old.GMS_BURDENABLE_RAW_COST                       ;
    t_old_rec.ACCOUNTING_EVENT_ID                      := :old.ACCOUNTING_EVENT_ID                           ;
    t_old_rec.PREPAY_DISTRIBUTION_ID                   := :old.PREPAY_DISTRIBUTION_ID                        ;
    t_old_rec.UPGRADE_POSTED_AMT                       := :old.UPGRADE_POSTED_AMT                            ;
    t_old_rec.UPGRADE_BASE_POSTED_AMT                  := :old.UPGRADE_BASE_POSTED_AMT                       ;
    t_old_rec.INVENTORY_TRANSFER_STATUS                := :old.INVENTORY_TRANSFER_STATUS                     ;
    t_old_rec.COMPANY_PREPAID_INVOICE_ID               := :old.COMPANY_PREPAID_INVOICE_ID                    ;
    t_old_rec.CC_REVERSAL_FLAG                         := :old.CC_REVERSAL_FLAG                              ;
    t_old_rec.AWT_WITHHELD_AMT                         := :old.AWT_WITHHELD_AMT                              ;
    t_old_rec.INVOICE_INCLUDES_PREPAY_FLAG             := :old.INVOICE_INCLUDES_PREPAY_FLAG                  ;
    t_old_rec.PRICE_CORRECT_INV_ID                     := :old.PRICE_CORRECT_INV_ID                          ;
    t_old_rec.PRICE_CORRECT_QTY                        := :old.PRICE_CORRECT_QTY                             ;
    t_old_rec.PA_CMT_XFACE_FLAG                        := :old.PA_CMT_XFACE_FLAG                             ;
    t_old_rec.CANCELLATION_FLAG                        := :old.CANCELLATION_FLAG                             ;
    t_old_rec.INVOICE_LINE_NUMBER                      := :old.INVOICE_LINE_NUMBER                           ;
    t_old_rec.CORRECTED_INVOICE_DIST_ID                := :old.CORRECTED_INVOICE_DIST_ID                     ;
    t_old_rec.ROUNDING_AMT                             := :old.ROUNDING_AMT                                  ;
    t_old_rec.CHARGE_APPLICABLE_TO_DIST_ID             := :old.CHARGE_APPLICABLE_TO_DIST_ID                  ;
    t_old_rec.CORRECTED_QUANTITY                       := :old.CORRECTED_QUANTITY                            ;
    t_old_rec.RELATED_ID                               := :old.RELATED_ID                                    ;
    t_old_rec.ASSET_BOOK_TYPE_CODE                     := :old.ASSET_BOOK_TYPE_CODE                          ;
    t_old_rec.ASSET_CATEGORY_ID                        := :old.ASSET_CATEGORY_ID                             ;
    t_old_rec.DISTRIBUTION_CLASS                       := :old.DISTRIBUTION_CLASS                            ;
    t_old_rec.FINAL_PAYMENT_ROUNDING                   := :old.FINAL_PAYMENT_ROUNDING                        ;
    t_old_rec.FINAL_APPLICATION_ROUNDING               := :old.FINAL_APPLICATION_ROUNDING                    ;
    t_old_rec.AMOUNT_AT_PREPAY_XRATE                   := :old.AMOUNT_AT_PREPAY_XRATE                        ;
    t_old_rec.CASH_BASIS_FINAL_APP_ROUNDING            := :old.CASH_BASIS_FINAL_APP_ROUNDING                 ;
    t_old_rec.AMOUNT_AT_PREPAY_PAY_XRATE               := :old.AMOUNT_AT_PREPAY_PAY_XRATE                    ;
    t_old_rec.INTENDED_USE                             := :old.INTENDED_USE                                  ;
    t_old_rec.DETAIL_TAX_DIST_ID                       := :old.DETAIL_TAX_DIST_ID                            ;
    t_old_rec.REC_NREC_RATE                            := :old.REC_NREC_RATE                                 ;
    t_old_rec.RECOVERY_RATE_ID                         := :old.RECOVERY_RATE_ID                              ;
    t_old_rec.RECOVERY_RATE_NAME                       := :old.RECOVERY_RATE_NAME                            ;
    t_old_rec.RECOVERY_TYPE_CODE                       := :old.RECOVERY_TYPE_CODE                            ;
    t_old_rec.RECOVERY_RATE_CODE                       := :old.RECOVERY_RATE_CODE                            ;
    t_old_rec.WITHHOLDING_TAX_CODE_ID                  := :old.WITHHOLDING_TAX_CODE_ID                       ;
    t_old_rec.TAX_ALREADY_DISTRIBUTED_FLAG             := :old.TAX_ALREADY_DISTRIBUTED_FLAG                  ;
    t_old_rec.SUMMARY_TAX_LINE_ID                      := :old.SUMMARY_TAX_LINE_ID                           ;
    t_old_rec.TAXABLE_AMOUNT                           := :old.TAXABLE_AMOUNT                                ;
    t_old_rec.TAXABLE_BASE_AMOUNT                      := :old.TAXABLE_BASE_AMOUNT                           ;
    t_old_rec.EXTRA_PO_ERV                             := :old.EXTRA_PO_ERV                                  ;
    t_old_rec.PREPAY_TAX_DIFF_AMOUNT                   := :old.PREPAY_TAX_DIFF_AMOUNT                        ;
    t_old_rec.TAX_CODE_ID                              := :old.TAX_CODE_ID                                   ;
    t_old_rec.VAT_CODE                                 := :old.VAT_CODE                                      ;
    t_old_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :old.AMOUNT_INCLUDES_TAX_FLAG                      ;
    t_old_rec.TAX_CALCULATED_FLAG                      := :old.TAX_CALCULATED_FLAG                           ;
    t_old_rec.TAX_RECOVERY_RATE                        := :old.TAX_RECOVERY_RATE                             ;
    t_old_rec.TAX_RECOVERY_OVERRIDE_FLAG               := :old.TAX_RECOVERY_OVERRIDE_FLAG                    ;
    t_old_rec.TAX_CODE_OVERRIDE_FLAG                   := :old.TAX_CODE_OVERRIDE_FLAG                        ;
    t_old_rec.TOTAL_DIST_AMOUNT                        := :old.TOTAL_DIST_AMOUNT                             ;
    t_old_rec.TOTAL_DIST_BASE_AMOUNT                   := :old.TOTAL_DIST_BASE_AMOUNT                        ;
    t_old_rec.PREPAY_TAX_PARENT_ID                     := :old.PREPAY_TAX_PARENT_ID                          ;
    t_old_rec.CANCELLED_FLAG                           := :old.CANCELLED_FLAG                                ;
    t_old_rec.OLD_DISTRIBUTION_ID                      := :old.OLD_DISTRIBUTION_ID                           ;
    t_old_rec.OLD_DIST_LINE_NUMBER                     := :old.OLD_DIST_LINE_NUMBER                          ;
    t_old_rec.AMOUNT_VARIANCE                          := :old.AMOUNT_VARIANCE                               ;
    t_old_rec.BASE_AMOUNT_VARIANCE                     := :old.BASE_AMOUNT_VARIANCE                          ;
    t_old_rec.HISTORICAL_FLAG                          := :old.HISTORICAL_FLAG                               ;
    t_old_rec.RCV_CHARGE_ADDITION_FLAG                 := :old.RCV_CHARGE_ADDITION_FLAG                      ;
    t_old_rec.AWT_RELATED_ID                           := :old.AWT_RELATED_ID                                ;
    t_old_rec.RELATED_RETAINAGE_DIST_ID                := :old.RELATED_RETAINAGE_DIST_ID                     ;
    t_old_rec.RETAINED_AMOUNT_REMAINING                := :old.RETAINED_AMOUNT_REMAINING                     ;
    t_old_rec.BC_EVENT_ID                              := :old.BC_EVENT_ID                                   ;
    t_old_rec.RETAINED_INVOICE_DIST_ID                 := :old.RETAINED_INVOICE_DIST_ID                      ;
    t_old_rec.FINAL_RELEASE_ROUNDING                   := :old.FINAL_RELEASE_ROUNDING                        ;
    t_old_rec.FULLY_PAID_ACCTD_FLAG                    := :old.FULLY_PAID_ACCTD_FLAG                         ;
    t_old_rec.ROOT_DISTRIBUTION_ID                     := :old.ROOT_DISTRIBUTION_ID                          ;
    t_old_rec.XINV_PARENT_REVERSAL_ID                  := :old.XINV_PARENT_REVERSAL_ID                       ;
    t_old_rec.RECURRING_PAYMENT_ID                     := :old.RECURRING_PAYMENT_ID                          ;
    t_old_rec.RELEASE_INV_DIST_DERIVED_FROM            := :old.RELEASE_INV_DIST_DERIVED_FROM                 ;
  END populate_old ;

  /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.ACCOUNTING_DATE                          := t_new_rec.ACCOUNTING_DATE                               ;
    :new.ACCRUAL_POSTED_FLAG                      := t_new_rec.ACCRUAL_POSTED_FLAG                           ;
    :new.ASSETS_ADDITION_FLAG                     := t_new_rec.ASSETS_ADDITION_FLAG                          ;
    :new.ASSETS_TRACKING_FLAG                     := t_new_rec.ASSETS_TRACKING_FLAG                          ;
    :new.CASH_POSTED_FLAG                         := t_new_rec.CASH_POSTED_FLAG                              ;
    :new.DISTRIBUTION_LINE_NUMBER                 := t_new_rec.DISTRIBUTION_LINE_NUMBER                      ;
    :new.DIST_CODE_COMBINATION_ID                 := t_new_rec.DIST_CODE_COMBINATION_ID                      ;
    :new.INVOICE_ID                               := t_new_rec.INVOICE_ID                                    ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LINE_TYPE_LOOKUP_CODE                    := t_new_rec.LINE_TYPE_LOOKUP_CODE                         ;
    :new.PERIOD_NAME                              := t_new_rec.PERIOD_NAME                                   ;
    :new.SET_OF_BOOKS_ID                          := t_new_rec.SET_OF_BOOKS_ID                               ;
    :new.ACCTS_PAY_CODE_COMBINATION_ID            := t_new_rec.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    :new.AMOUNT                                   := t_new_rec.AMOUNT                                        ;
    :new.BASE_AMOUNT                              := t_new_rec.BASE_AMOUNT                                   ;
    :new.BASE_INVOICE_PRICE_VARIANCE              := t_new_rec.BASE_INVOICE_PRICE_VARIANCE                   ;
    :new.BATCH_ID                                 := t_new_rec.BATCH_ID                                      ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.DESCRIPTION                              := t_new_rec.DESCRIPTION                                   ;
    :new.EXCHANGE_RATE_VARIANCE                   := t_new_rec.EXCHANGE_RATE_VARIANCE                        ;
    :new.FINAL_MATCH_FLAG                         := t_new_rec.FINAL_MATCH_FLAG                              ;
    :new.INCOME_TAX_REGION                        := t_new_rec.INCOME_TAX_REGION                             ;
    :new.INVOICE_PRICE_VARIANCE                   := t_new_rec.INVOICE_PRICE_VARIANCE                        ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.MATCH_STATUS_FLAG                        := t_new_rec.MATCH_STATUS_FLAG                             ;
    :new.POSTED_FLAG                              := t_new_rec.POSTED_FLAG                                   ;
    :new.PO_DISTRIBUTION_ID                       := t_new_rec.PO_DISTRIBUTION_ID                            ;
    :new.PROGRAM_APPLICATION_ID                   := t_new_rec.PROGRAM_APPLICATION_ID                        ;
    :new.PROGRAM_ID                               := t_new_rec.PROGRAM_ID                                    ;
    :new.PROGRAM_UPDATE_DATE                      := t_new_rec.PROGRAM_UPDATE_DATE                           ;
    :new.QUANTITY_INVOICED                        := t_new_rec.QUANTITY_INVOICED                             ;
    :new.RATE_VAR_CODE_COMBINATION_ID             := t_new_rec.RATE_VAR_CODE_COMBINATION_ID                  ;
    :new.REQUEST_ID                               := t_new_rec.REQUEST_ID                                    ;
    :new.REVERSAL_FLAG                            := t_new_rec.REVERSAL_FLAG                                 ;
    :new.TYPE_1099                                := t_new_rec.TYPE_1099                                     ;
    :new.UNIT_PRICE                               := t_new_rec.UNIT_PRICE                                    ;
    :new.AMOUNT_ENCUMBERED                        := t_new_rec.AMOUNT_ENCUMBERED                             ;
    :new.BASE_AMOUNT_ENCUMBERED                   := t_new_rec.BASE_AMOUNT_ENCUMBERED                        ;
    :new.ENCUMBERED_FLAG                          := t_new_rec.ENCUMBERED_FLAG                               ;
    :new.EXCHANGE_DATE                            := t_new_rec.EXCHANGE_DATE                                 ;
    :new.EXCHANGE_RATE                            := t_new_rec.EXCHANGE_RATE                                 ;
    :new.EXCHANGE_RATE_TYPE                       := t_new_rec.EXCHANGE_RATE_TYPE                            ;
    :new.PRICE_ADJUSTMENT_FLAG                    := t_new_rec.PRICE_ADJUSTMENT_FLAG                         ;
    :new.PRICE_VAR_CODE_COMBINATION_ID            := t_new_rec.PRICE_VAR_CODE_COMBINATION_ID                 ;
    :new.QUANTITY_UNENCUMBERED                    := t_new_rec.QUANTITY_UNENCUMBERED                         ;
    :new.STAT_AMOUNT                              := t_new_rec.STAT_AMOUNT                                   ;
    :new.AMOUNT_TO_POST                           := t_new_rec.AMOUNT_TO_POST                                ;
    :new.ATTRIBUTE1                               := t_new_rec.ATTRIBUTE1                                    ;
    :new.ATTRIBUTE10                              := t_new_rec.ATTRIBUTE10                                   ;
    :new.ATTRIBUTE11                              := t_new_rec.ATTRIBUTE11                                   ;
    :new.ATTRIBUTE12                              := t_new_rec.ATTRIBUTE12                                   ;
    :new.ATTRIBUTE13                              := t_new_rec.ATTRIBUTE13                                   ;
    :new.ATTRIBUTE14                              := t_new_rec.ATTRIBUTE14                                   ;
    :new.ATTRIBUTE15                              := t_new_rec.ATTRIBUTE15                                   ;
    :new.ATTRIBUTE2                               := t_new_rec.ATTRIBUTE2                                    ;
    :new.ATTRIBUTE3                               := t_new_rec.ATTRIBUTE3                                    ;
    :new.ATTRIBUTE4                               := t_new_rec.ATTRIBUTE4                                    ;
    :new.ATTRIBUTE5                               := t_new_rec.ATTRIBUTE5                                    ;
    :new.ATTRIBUTE6                               := t_new_rec.ATTRIBUTE6                                    ;
    :new.ATTRIBUTE7                               := t_new_rec.ATTRIBUTE7                                    ;
    :new.ATTRIBUTE8                               := t_new_rec.ATTRIBUTE8                                    ;
    :new.ATTRIBUTE9                               := t_new_rec.ATTRIBUTE9                                    ;
    :new.ATTRIBUTE_CATEGORY                       := t_new_rec.ATTRIBUTE_CATEGORY                            ;
    :new.BASE_AMOUNT_TO_POST                      := t_new_rec.BASE_AMOUNT_TO_POST                           ;
    :new.CASH_JE_BATCH_ID                         := t_new_rec.CASH_JE_BATCH_ID                              ;
    :new.EXPENDITURE_ITEM_DATE                    := t_new_rec.EXPENDITURE_ITEM_DATE                         ;
    :new.EXPENDITURE_ORGANIZATION_ID              := t_new_rec.EXPENDITURE_ORGANIZATION_ID                   ;
    :new.EXPENDITURE_TYPE                         := t_new_rec.EXPENDITURE_TYPE                              ;
    :new.JE_BATCH_ID                              := t_new_rec.JE_BATCH_ID                                   ;
    :new.PARENT_INVOICE_ID                        := t_new_rec.PARENT_INVOICE_ID                             ;
    :new.PA_ADDITION_FLAG                         := t_new_rec.PA_ADDITION_FLAG                              ;
    :new.PA_QUANTITY                              := t_new_rec.PA_QUANTITY                                   ;
    :new.POSTED_AMOUNT                            := t_new_rec.POSTED_AMOUNT                                 ;
    :new.POSTED_BASE_AMOUNT                       := t_new_rec.POSTED_BASE_AMOUNT                            ;
    :new.PREPAY_AMOUNT_REMAINING                  := t_new_rec.PREPAY_AMOUNT_REMAINING                       ;
    :new.PROJECT_ACCOUNTING_CONTEXT               := t_new_rec.PROJECT_ACCOUNTING_CONTEXT                    ;
    :new.PROJECT_ID                               := t_new_rec.PROJECT_ID                                    ;
    :new.TASK_ID                                  := t_new_rec.TASK_ID                                       ;
    :new.USSGL_TRANSACTION_CODE                   := t_new_rec.USSGL_TRANSACTION_CODE                        ;
    :new.USSGL_TRX_CODE_CONTEXT                   := t_new_rec.USSGL_TRX_CODE_CONTEXT                        ;
    :new.EARLIEST_SETTLEMENT_DATE                 := t_new_rec.EARLIEST_SETTLEMENT_DATE                      ;
    :new.REQ_DISTRIBUTION_ID                      := t_new_rec.REQ_DISTRIBUTION_ID                           ;
    :new.QUANTITY_VARIANCE                        := t_new_rec.QUANTITY_VARIANCE                             ;
    :new.BASE_QUANTITY_VARIANCE                   := t_new_rec.BASE_QUANTITY_VARIANCE                        ;
    :new.PACKET_ID                                := t_new_rec.PACKET_ID                                     ;
    :new.AWT_FLAG                                 := t_new_rec.AWT_FLAG                                      ;
    :new.AWT_GROUP_ID                             := t_new_rec.AWT_GROUP_ID                                  ;
    :new.AWT_TAX_RATE_ID                          := t_new_rec.AWT_TAX_RATE_ID                               ;
    :new.AWT_GROSS_AMOUNT                         := t_new_rec.AWT_GROSS_AMOUNT                              ;
    :new.AWT_INVOICE_ID                           := t_new_rec.AWT_INVOICE_ID                                ;
    :new.AWT_ORIGIN_GROUP_ID                      := t_new_rec.AWT_ORIGIN_GROUP_ID                           ;
    :new.REFERENCE_1                              := t_new_rec.REFERENCE_1                                   ;
    :new.REFERENCE_2                              := t_new_rec.REFERENCE_2                                   ;
    :new.ORG_ID                                   := t_new_rec.ORG_ID                                        ;
    :new.OTHER_INVOICE_ID                         := t_new_rec.OTHER_INVOICE_ID                              ;
    :new.AWT_INVOICE_PAYMENT_ID                   := t_new_rec.AWT_INVOICE_PAYMENT_ID                        ;
    :new.GLOBAL_ATTRIBUTE_CATEGORY                := t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    :new.GLOBAL_ATTRIBUTE1                        := t_new_rec.GLOBAL_ATTRIBUTE1                             ;
    :new.GLOBAL_ATTRIBUTE2                        := t_new_rec.GLOBAL_ATTRIBUTE2                             ;
    :new.GLOBAL_ATTRIBUTE3                        := t_new_rec.GLOBAL_ATTRIBUTE3                             ;
    :new.GLOBAL_ATTRIBUTE4                        := t_new_rec.GLOBAL_ATTRIBUTE4                             ;
    :new.GLOBAL_ATTRIBUTE5                        := t_new_rec.GLOBAL_ATTRIBUTE5                             ;
    :new.GLOBAL_ATTRIBUTE6                        := t_new_rec.GLOBAL_ATTRIBUTE6                             ;
    :new.GLOBAL_ATTRIBUTE7                        := t_new_rec.GLOBAL_ATTRIBUTE7                             ;
    :new.GLOBAL_ATTRIBUTE8                        := t_new_rec.GLOBAL_ATTRIBUTE8                             ;
    :new.GLOBAL_ATTRIBUTE9                        := t_new_rec.GLOBAL_ATTRIBUTE9                             ;
    :new.GLOBAL_ATTRIBUTE10                       := t_new_rec.GLOBAL_ATTRIBUTE10                            ;
    :new.GLOBAL_ATTRIBUTE11                       := t_new_rec.GLOBAL_ATTRIBUTE11                            ;
    :new.GLOBAL_ATTRIBUTE12                       := t_new_rec.GLOBAL_ATTRIBUTE12                            ;
    :new.GLOBAL_ATTRIBUTE13                       := t_new_rec.GLOBAL_ATTRIBUTE13                            ;
    :new.GLOBAL_ATTRIBUTE14                       := t_new_rec.GLOBAL_ATTRIBUTE14                            ;
    :new.GLOBAL_ATTRIBUTE15                       := t_new_rec.GLOBAL_ATTRIBUTE15                            ;
    :new.GLOBAL_ATTRIBUTE16                       := t_new_rec.GLOBAL_ATTRIBUTE16                            ;
    :new.GLOBAL_ATTRIBUTE17                       := t_new_rec.GLOBAL_ATTRIBUTE17                            ;
    :new.GLOBAL_ATTRIBUTE18                       := t_new_rec.GLOBAL_ATTRIBUTE18                            ;
    :new.GLOBAL_ATTRIBUTE19                       := t_new_rec.GLOBAL_ATTRIBUTE19                            ;
    :new.GLOBAL_ATTRIBUTE20                       := t_new_rec.GLOBAL_ATTRIBUTE20                            ;
    :new.LINE_GROUP_NUMBER                        := t_new_rec.LINE_GROUP_NUMBER                             ;
    :new.RECEIPT_VERIFIED_FLAG                    := t_new_rec.RECEIPT_VERIFIED_FLAG                         ;
    :new.RECEIPT_REQUIRED_FLAG                    := t_new_rec.RECEIPT_REQUIRED_FLAG                         ;
    :new.RECEIPT_MISSING_FLAG                     := t_new_rec.RECEIPT_MISSING_FLAG                          ;
    :new.JUSTIFICATION                            := t_new_rec.JUSTIFICATION                                 ;
    :new.EXPENSE_GROUP                            := t_new_rec.EXPENSE_GROUP                                 ;
    :new.START_EXPENSE_DATE                       := t_new_rec.START_EXPENSE_DATE                            ;
    :new.END_EXPENSE_DATE                         := t_new_rec.END_EXPENSE_DATE                              ;
    :new.RECEIPT_CURRENCY_CODE                    := t_new_rec.RECEIPT_CURRENCY_CODE                         ;
    :new.RECEIPT_CONVERSION_RATE                  := t_new_rec.RECEIPT_CONVERSION_RATE                       ;
    :new.RECEIPT_CURRENCY_AMOUNT                  := t_new_rec.RECEIPT_CURRENCY_AMOUNT                       ;
    :new.DAILY_AMOUNT                             := t_new_rec.DAILY_AMOUNT                                  ;
    :new.WEB_PARAMETER_ID                         := t_new_rec.WEB_PARAMETER_ID                              ;
    :new.ADJUSTMENT_REASON                        := t_new_rec.ADJUSTMENT_REASON                             ;
    :new.AWARD_ID                                 := t_new_rec.AWARD_ID                                      ;
    :new.MRC_ACCRUAL_POSTED_FLAG                  := t_new_rec.MRC_ACCRUAL_POSTED_FLAG                       ;
    :new.MRC_CASH_POSTED_FLAG                     := t_new_rec.MRC_CASH_POSTED_FLAG                          ;
    :new.MRC_DIST_CODE_COMBINATION_ID             := t_new_rec.MRC_DIST_CODE_COMBINATION_ID                  ;
    :new.MRC_AMOUNT                               := t_new_rec.MRC_AMOUNT                                    ;
    :new.MRC_BASE_AMOUNT                          := t_new_rec.MRC_BASE_AMOUNT                               ;
    :new.MRC_BASE_INV_PRICE_VARIANCE              := t_new_rec.MRC_BASE_INV_PRICE_VARIANCE                   ;
    :new.MRC_EXCHANGE_RATE_VARIANCE               := t_new_rec.MRC_EXCHANGE_RATE_VARIANCE                    ;
    :new.MRC_POSTED_FLAG                          := t_new_rec.MRC_POSTED_FLAG                               ;
    :new.MRC_PROGRAM_APPLICATION_ID               := t_new_rec.MRC_PROGRAM_APPLICATION_ID                    ;
    :new.MRC_PROGRAM_ID                           := t_new_rec.MRC_PROGRAM_ID                                ;
    :new.MRC_PROGRAM_UPDATE_DATE                  := t_new_rec.MRC_PROGRAM_UPDATE_DATE                       ;
    :new.MRC_RATE_VAR_CCID                        := t_new_rec.MRC_RATE_VAR_CCID                             ;
    :new.MRC_REQUEST_ID                           := t_new_rec.MRC_REQUEST_ID                                ;
    :new.MRC_EXCHANGE_DATE                        := t_new_rec.MRC_EXCHANGE_DATE                             ;
    :new.MRC_EXCHANGE_RATE                        := t_new_rec.MRC_EXCHANGE_RATE                             ;
    :new.MRC_EXCHANGE_RATE_TYPE                   := t_new_rec.MRC_EXCHANGE_RATE_TYPE                        ;
    :new.MRC_AMOUNT_TO_POST                       := t_new_rec.MRC_AMOUNT_TO_POST                            ;
    :new.MRC_BASE_AMOUNT_TO_POST                  := t_new_rec.MRC_BASE_AMOUNT_TO_POST                       ;
    :new.MRC_CASH_JE_BATCH_ID                     := t_new_rec.MRC_CASH_JE_BATCH_ID                          ;
    :new.MRC_JE_BATCH_ID                          := t_new_rec.MRC_JE_BATCH_ID                               ;
    :new.MRC_POSTED_AMOUNT                        := t_new_rec.MRC_POSTED_AMOUNT                             ;
    :new.MRC_POSTED_BASE_AMOUNT                   := t_new_rec.MRC_POSTED_BASE_AMOUNT                        ;
    :new.MRC_RECEIPT_CONVERSION_RATE              := t_new_rec.MRC_RECEIPT_CONVERSION_RATE                   ;
    :new.CREDIT_CARD_TRX_ID                       := t_new_rec.CREDIT_CARD_TRX_ID                            ;
    :new.DIST_MATCH_TYPE                          := t_new_rec.DIST_MATCH_TYPE                               ;
    :new.RCV_TRANSACTION_ID                       := t_new_rec.RCV_TRANSACTION_ID                            ;
    :new.INVOICE_DISTRIBUTION_ID                  := t_new_rec.INVOICE_DISTRIBUTION_ID                       ;
    :new.PARENT_REVERSAL_ID                       := t_new_rec.PARENT_REVERSAL_ID                            ;
    :new.TAX_RECOVERABLE_FLAG                     := t_new_rec.TAX_RECOVERABLE_FLAG                          ;
    :new.PA_CC_AR_INVOICE_ID                      := t_new_rec.PA_CC_AR_INVOICE_ID                           ;
    :new.PA_CC_AR_INVOICE_LINE_NUM                := t_new_rec.PA_CC_AR_INVOICE_LINE_NUM                     ;
    :new.PA_CC_PROCESSED_CODE                     := t_new_rec.PA_CC_PROCESSED_CODE                          ;
    :new.MERCHANT_DOCUMENT_NUMBER                 := t_new_rec.MERCHANT_DOCUMENT_NUMBER                      ;
    :new.MERCHANT_NAME                            := t_new_rec.MERCHANT_NAME                                 ;
    :new.MERCHANT_REFERENCE                       := t_new_rec.MERCHANT_REFERENCE                            ;
    :new.MERCHANT_TAX_REG_NUMBER                  := t_new_rec.MERCHANT_TAX_REG_NUMBER                       ;
    :new.MERCHANT_TAXPAYER_ID                     := t_new_rec.MERCHANT_TAXPAYER_ID                          ;
    :new.COUNTRY_OF_SUPPLY                        := t_new_rec.COUNTRY_OF_SUPPLY                             ;
    :new.MATCHED_UOM_LOOKUP_CODE                  := t_new_rec.MATCHED_UOM_LOOKUP_CODE                       ;
    :new.GMS_BURDENABLE_RAW_COST                  := t_new_rec.GMS_BURDENABLE_RAW_COST                       ;
    :new.ACCOUNTING_EVENT_ID                      := t_new_rec.ACCOUNTING_EVENT_ID                           ;
    :new.PREPAY_DISTRIBUTION_ID                   := t_new_rec.PREPAY_DISTRIBUTION_ID                        ;
    :new.UPGRADE_POSTED_AMT                       := t_new_rec.UPGRADE_POSTED_AMT                            ;
    :new.UPGRADE_BASE_POSTED_AMT                  := t_new_rec.UPGRADE_BASE_POSTED_AMT                       ;
    :new.INVENTORY_TRANSFER_STATUS                := t_new_rec.INVENTORY_TRANSFER_STATUS                     ;
    :new.COMPANY_PREPAID_INVOICE_ID               := t_new_rec.COMPANY_PREPAID_INVOICE_ID                    ;
    :new.CC_REVERSAL_FLAG                         := t_new_rec.CC_REVERSAL_FLAG                              ;
    :new.AWT_WITHHELD_AMT                         := t_new_rec.AWT_WITHHELD_AMT                              ;
    :new.INVOICE_INCLUDES_PREPAY_FLAG             := t_new_rec.INVOICE_INCLUDES_PREPAY_FLAG                  ;
    :new.PRICE_CORRECT_INV_ID                     := t_new_rec.PRICE_CORRECT_INV_ID                          ;
    :new.PRICE_CORRECT_QTY                        := t_new_rec.PRICE_CORRECT_QTY                             ;
    :new.PA_CMT_XFACE_FLAG                        := t_new_rec.PA_CMT_XFACE_FLAG                             ;
    :new.CANCELLATION_FLAG                        := t_new_rec.CANCELLATION_FLAG                             ;
    :new.INVOICE_LINE_NUMBER                      := t_new_rec.INVOICE_LINE_NUMBER                           ;
    :new.CORRECTED_INVOICE_DIST_ID                := t_new_rec.CORRECTED_INVOICE_DIST_ID                     ;
    :new.ROUNDING_AMT                             := t_new_rec.ROUNDING_AMT                                  ;
    :new.CHARGE_APPLICABLE_TO_DIST_ID             := t_new_rec.CHARGE_APPLICABLE_TO_DIST_ID                  ;
    :new.CORRECTED_QUANTITY                       := t_new_rec.CORRECTED_QUANTITY                            ;
    :new.RELATED_ID                               := t_new_rec.RELATED_ID                                    ;
    :new.ASSET_BOOK_TYPE_CODE                     := t_new_rec.ASSET_BOOK_TYPE_CODE                          ;
    :new.ASSET_CATEGORY_ID                        := t_new_rec.ASSET_CATEGORY_ID                             ;
    :new.DISTRIBUTION_CLASS                       := t_new_rec.DISTRIBUTION_CLASS                            ;
    :new.FINAL_PAYMENT_ROUNDING                   := t_new_rec.FINAL_PAYMENT_ROUNDING                        ;
    :new.FINAL_APPLICATION_ROUNDING               := t_new_rec.FINAL_APPLICATION_ROUNDING                    ;
    :new.AMOUNT_AT_PREPAY_XRATE                   := t_new_rec.AMOUNT_AT_PREPAY_XRATE                        ;
    :new.CASH_BASIS_FINAL_APP_ROUNDING            := t_new_rec.CASH_BASIS_FINAL_APP_ROUNDING                 ;
    :new.AMOUNT_AT_PREPAY_PAY_XRATE               := t_new_rec.AMOUNT_AT_PREPAY_PAY_XRATE                    ;
    :new.INTENDED_USE                             := t_new_rec.INTENDED_USE                                  ;
    :new.DETAIL_TAX_DIST_ID                       := t_new_rec.DETAIL_TAX_DIST_ID                            ;
    :new.REC_NREC_RATE                            := t_new_rec.REC_NREC_RATE                                 ;
    :new.RECOVERY_RATE_ID                         := t_new_rec.RECOVERY_RATE_ID                              ;
    :new.RECOVERY_RATE_NAME                       := t_new_rec.RECOVERY_RATE_NAME                            ;
    :new.RECOVERY_TYPE_CODE                       := t_new_rec.RECOVERY_TYPE_CODE                            ;
    :new.RECOVERY_RATE_CODE                       := t_new_rec.RECOVERY_RATE_CODE                            ;
    :new.WITHHOLDING_TAX_CODE_ID                  := t_new_rec.WITHHOLDING_TAX_CODE_ID                       ;
    :new.TAX_ALREADY_DISTRIBUTED_FLAG             := t_new_rec.TAX_ALREADY_DISTRIBUTED_FLAG                  ;
    :new.SUMMARY_TAX_LINE_ID                      := t_new_rec.SUMMARY_TAX_LINE_ID                           ;
    :new.TAXABLE_AMOUNT                           := t_new_rec.TAXABLE_AMOUNT                                ;
    :new.TAXABLE_BASE_AMOUNT                      := t_new_rec.TAXABLE_BASE_AMOUNT                           ;
    :new.EXTRA_PO_ERV                             := t_new_rec.EXTRA_PO_ERV                                  ;
    :new.PREPAY_TAX_DIFF_AMOUNT                   := t_new_rec.PREPAY_TAX_DIFF_AMOUNT                        ;
    :new.TAX_CODE_ID                              := t_new_rec.TAX_CODE_ID                                   ;
    :new.VAT_CODE                                 := t_new_rec.VAT_CODE                                      ;
    :new.AMOUNT_INCLUDES_TAX_FLAG                 := t_new_rec.AMOUNT_INCLUDES_TAX_FLAG                      ;
    :new.TAX_CALCULATED_FLAG                      := t_new_rec.TAX_CALCULATED_FLAG                           ;
    :new.TAX_RECOVERY_RATE                        := t_new_rec.TAX_RECOVERY_RATE                             ;
    :new.TAX_RECOVERY_OVERRIDE_FLAG               := t_new_rec.TAX_RECOVERY_OVERRIDE_FLAG                    ;
    :new.TAX_CODE_OVERRIDE_FLAG                   := t_new_rec.TAX_CODE_OVERRIDE_FLAG                        ;
    :new.TOTAL_DIST_AMOUNT                        := t_new_rec.TOTAL_DIST_AMOUNT                             ;
    :new.TOTAL_DIST_BASE_AMOUNT                   := t_new_rec.TOTAL_DIST_BASE_AMOUNT                        ;
    :new.PREPAY_TAX_PARENT_ID                     := t_new_rec.PREPAY_TAX_PARENT_ID                          ;
    :new.CANCELLED_FLAG                           := t_new_rec.CANCELLED_FLAG                                ;
    :new.OLD_DISTRIBUTION_ID                      := t_new_rec.OLD_DISTRIBUTION_ID                           ;
    :new.OLD_DIST_LINE_NUMBER                     := t_new_rec.OLD_DIST_LINE_NUMBER                          ;
    :new.AMOUNT_VARIANCE                          := t_new_rec.AMOUNT_VARIANCE                               ;
    :new.BASE_AMOUNT_VARIANCE                     := t_new_rec.BASE_AMOUNT_VARIANCE                          ;
    :new.HISTORICAL_FLAG                          := t_new_rec.HISTORICAL_FLAG                               ;
    :new.RCV_CHARGE_ADDITION_FLAG                 := t_new_rec.RCV_CHARGE_ADDITION_FLAG                      ;
    :new.AWT_RELATED_ID                           := t_new_rec.AWT_RELATED_ID                                ;
    :new.RELATED_RETAINAGE_DIST_ID                := t_new_rec.RELATED_RETAINAGE_DIST_ID                     ;
    :new.RETAINED_AMOUNT_REMAINING                := t_new_rec.RETAINED_AMOUNT_REMAINING                     ;
    :new.BC_EVENT_ID                              := t_new_rec.BC_EVENT_ID                                   ;
    :new.RETAINED_INVOICE_DIST_ID                 := t_new_rec.RETAINED_INVOICE_DIST_ID                      ;
    :new.FINAL_RELEASE_ROUNDING                   := t_new_rec.FINAL_RELEASE_ROUNDING                        ;
    :new.FULLY_PAID_ACCTD_FLAG                    := t_new_rec.FULLY_PAID_ACCTD_FLAG                         ;
    :new.ROOT_DISTRIBUTION_ID                     := t_new_rec.ROOT_DISTRIBUTION_ID                          ;
    :new.XINV_PARENT_REVERSAL_ID                  := t_new_rec.XINV_PARENT_REVERSAL_ID                       ;
    :new.RECURRING_PAYMENT_ID                     := t_new_rec.RECURRING_PAYMENT_ID                          ;
    :new.RELEASE_INV_DIST_DERIVED_FROM            := t_new_rec.RELEASE_INV_DIST_DERIVED_FROM                 ;
  END populate_t_new_rec ;

BEGIN

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

--Added for 6995295 by JMEENA
  lv_org_id:= :new.org_id;
  lv_set_of_books_id:= :new.set_of_books_id;

  IF DELETING THEN
  	lv_org_id:= :old.org_id;
  	lv_set_of_books_id:= :old.set_of_books_id;
  END IF;

--END 6995295

/*
|| make a call to the INR check package.
 */
    IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AP_IDA_BRIUD_T1', P_ORG_ID => lv_org_id, p_set_of_books_id => lv_set_of_books_id ) = FALSE THEN
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

      JAI_AP_IDA_TRIGGER_PKG.BRIUD_T1 (
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

  IF UPDATING THEN

      JAI_AP_IDA_TRIGGER_PKG.BRIUD_T1 (
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

  IF DELETING THEN

      JAI_AP_IDA_TRIGGER_PKG.BRIUD_T1 (
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

  /*
  || assign the new record values depending upon the triggering event.
  */
  IF UPDATING OR INSERTING THEN
     populate_t_new_rec;
  END IF;

EXCEPTION
     WHEN le_error THEN
        IF (SQLCODE <> -20001) THEN    /*code added for bug : 6493858 Starts from here*/
          FND_MESSAGE.SET_NAME('SQLAP','AP_DEBUG');
          FND_MESSAGE.SET_TOKEN('ERROR',SQLERRM);
          FND_MESSAGE.SET_TOKEN('CALLING_SEQUENCE','Error from Trigger JAI_AP_IDA_BRIUD_T1');
          FND_MESSAGE.SET_TOKEN('DEBUG_INFO',lv_return_message);
       END IF;
    APP_EXCEPTION.RAISE_EXCEPTION;   /* code ended for bug : 6493858 - Ends here*/

    /*Code commented by Nitin Prashar  on 4-dec-2007
      app_exception.raise_s (
                                     EXCEPTION_TYPE  => 'APP'  ,
                                     EXCEPTION_CODE  => -20110 ,
                                     EXCEPTION_TEXT  => lv_return_message
                                   );  Code commenting Ends */

  WHEN OTHERS THEN
      IF (SQLCODE <> -20001) THEN    /*code added for bug : 6493858*/
          FND_MESSAGE.SET_NAME('SQLAP','AP_DEBUG');
          FND_MESSAGE.SET_TOKEN('ERROR',SQLERRM);
          FND_MESSAGE.SET_TOKEN('CALLING_SEQUENCE','Exception from Trigger');
          FND_MESSAGE.SET_TOKEN('DEBUG_INFO','Encountered the error in trigger JAI_AP_IDA_BRIUD_T1' || substr(sqlerrm,1,1900));
       END IF;
    APP_EXCEPTION.RAISE_EXCEPTION;   /* code ended for bug : 6493858*/

 /*Code commented by Nitin Prashar  on 4-dec-2007
                                     app_exception.raise_exception (
                                      EXCEPTION_TYPE  => 'APP',
                                      EXCEPTION_CODE  => -20110 ,
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AP_IDA_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    ); Code commenting Ends */

END JAI_AP_IDA_BRIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_AP_IDA_BRIUD_T1" DISABLE;
