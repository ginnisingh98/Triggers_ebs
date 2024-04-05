--------------------------------------------------------
--  DDL for Trigger JAI_AP_IA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AP_IA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AP"."AP_INVOICES_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             AP_INVOICES_ALL%rowtype ;
  t_new_rec             AP_INVOICES_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

/****************************************************************************
CHANGE HISTORY:

21-Oct-2005  Ramananda for bug#4692402. File Version 120.3
             Removed the references of column MRC_POSTING_STATUS



****************************************************************************/


  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.INVOICE_ID                               := :new.INVOICE_ID                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.INVOICE_NUM                              := :new.INVOICE_NUM                                   ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.INVOICE_CURRENCY_CODE                    := :new.INVOICE_CURRENCY_CODE                         ;
    t_new_rec.PAYMENT_CURRENCY_CODE                    := :new.PAYMENT_CURRENCY_CODE                         ;
    t_new_rec.PAYMENT_CROSS_RATE                       := :new.PAYMENT_CROSS_RATE                            ;
    t_new_rec.INVOICE_AMOUNT                           := :new.INVOICE_AMOUNT                                ;
    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.AMOUNT_PAID                              := :new.AMOUNT_PAID                                   ;
    t_new_rec.DISCOUNT_AMOUNT_TAKEN                    := :new.DISCOUNT_AMOUNT_TAKEN                         ;
    t_new_rec.INVOICE_DATE                             := :new.INVOICE_DATE                                  ;
    t_new_rec.SOURCE                                   := :new.SOURCE                                        ;
    t_new_rec.INVOICE_TYPE_LOOKUP_CODE                 := :new.INVOICE_TYPE_LOOKUP_CODE                      ;
    t_new_rec.DESCRIPTION                              := :new.DESCRIPTION                                   ;
    t_new_rec.BATCH_ID                                 := :new.BATCH_ID                                      ;
    t_new_rec.AMOUNT_APPLICABLE_TO_DISCOUNT            := :new.AMOUNT_APPLICABLE_TO_DISCOUNT                 ;
    t_new_rec.TAX_AMOUNT                               := :new.TAX_AMOUNT                                    ;
    t_new_rec.TERMS_ID                                 := :new.TERMS_ID                                      ;
    t_new_rec.TERMS_DATE                               := :new.TERMS_DATE                                    ;
    t_new_rec.PAYMENT_METHOD_LOOKUP_CODE               := :new.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_new_rec.PAY_GROUP_LOOKUP_CODE                    := :new.PAY_GROUP_LOOKUP_CODE                         ;
    t_new_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :new.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_new_rec.PAYMENT_STATUS_FLAG                      := :new.PAYMENT_STATUS_FLAG                           ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.BASE_AMOUNT                              := :new.BASE_AMOUNT                                   ;
    t_new_rec.VAT_CODE                                 := :new.VAT_CODE                                      ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.EXCLUSIVE_PAYMENT_FLAG                   := :new.EXCLUSIVE_PAYMENT_FLAG                        ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.FREIGHT_AMOUNT                           := :new.FREIGHT_AMOUNT                                ;
    t_new_rec.GOODS_RECEIVED_DATE                      := :new.GOODS_RECEIVED_DATE                           ;
    t_new_rec.INVOICE_RECEIVED_DATE                    := :new.INVOICE_RECEIVED_DATE                         ;
    t_new_rec.VOUCHER_NUM                              := :new.VOUCHER_NUM                                   ;
    t_new_rec.APPROVED_AMOUNT                          := :new.APPROVED_AMOUNT                               ;
    t_new_rec.RECURRING_PAYMENT_ID                     := :new.RECURRING_PAYMENT_ID                          ;
    t_new_rec.EXCHANGE_RATE                            := :new.EXCHANGE_RATE                                 ;
    t_new_rec.EXCHANGE_RATE_TYPE                       := :new.EXCHANGE_RATE_TYPE                            ;
    t_new_rec.EXCHANGE_DATE                            := :new.EXCHANGE_DATE                                 ;
    t_new_rec.EARLIEST_SETTLEMENT_DATE                 := :new.EARLIEST_SETTLEMENT_DATE                      ;
    t_new_rec.ORIGINAL_PREPAYMENT_AMOUNT               := :new.ORIGINAL_PREPAYMENT_AMOUNT                    ;
    t_new_rec.DOC_SEQUENCE_ID                          := :new.DOC_SEQUENCE_ID                               ;
    t_new_rec.DOC_SEQUENCE_VALUE                       := :new.DOC_SEQUENCE_VALUE                            ;
    t_new_rec.DOC_CATEGORY_CODE                        := :new.DOC_CATEGORY_CODE                             ;
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
    t_new_rec.ATTRIBUTE_CATEGORY                       := :new.ATTRIBUTE_CATEGORY                            ;
    t_new_rec.APPROVAL_STATUS                          := :new.APPROVAL_STATUS                               ;
    t_new_rec.APPROVAL_DESCRIPTION                     := :new.APPROVAL_DESCRIPTION                          ;
    t_new_rec.INVOICE_DISTRIBUTION_TOTAL               := :new.INVOICE_DISTRIBUTION_TOTAL                    ;
    t_new_rec.POSTING_STATUS                           := :new.POSTING_STATUS                                ;
    t_new_rec.PREPAY_FLAG                              := :new.PREPAY_FLAG                                   ;
    t_new_rec.AUTHORIZED_BY                            := :new.AUTHORIZED_BY                                 ;
    t_new_rec.CANCELLED_DATE                           := :new.CANCELLED_DATE                                ;
    t_new_rec.CANCELLED_BY                             := :new.CANCELLED_BY                                  ;
    t_new_rec.CANCELLED_AMOUNT                         := :new.CANCELLED_AMOUNT                              ;
    t_new_rec.TEMP_CANCELLED_AMOUNT                    := :new.TEMP_CANCELLED_AMOUNT                         ;
    t_new_rec.PROJECT_ACCOUNTING_CONTEXT               := :new.PROJECT_ACCOUNTING_CONTEXT                    ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.USSGL_TRX_CODE_CONTEXT                   := :new.USSGL_TRX_CODE_CONTEXT                        ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
    t_new_rec.EXPENDITURE_TYPE                         := :new.EXPENDITURE_TYPE                              ;
    t_new_rec.EXPENDITURE_ITEM_DATE                    := :new.EXPENDITURE_ITEM_DATE                         ;
    t_new_rec.PA_QUANTITY                              := :new.PA_QUANTITY                                   ;
    t_new_rec.EXPENDITURE_ORGANIZATION_ID              := :new.EXPENDITURE_ORGANIZATION_ID                   ;
    t_new_rec.PA_DEFAULT_DIST_CCID                     := :new.PA_DEFAULT_DIST_CCID                          ;
    t_new_rec.VENDOR_PREPAY_AMOUNT                     := :new.VENDOR_PREPAY_AMOUNT                          ;
    t_new_rec.PAYMENT_AMOUNT_TOTAL                     := :new.PAYMENT_AMOUNT_TOTAL                          ;
    t_new_rec.AWT_FLAG                                 := :new.AWT_FLAG                                      ;
    t_new_rec.AWT_GROUP_ID                             := :new.AWT_GROUP_ID                                  ;
    t_new_rec.REFERENCE_1                              := :new.REFERENCE_1                                   ;
    t_new_rec.REFERENCE_2                              := :new.REFERENCE_2                                   ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.PRE_WITHHOLDING_AMOUNT                   := :new.PRE_WITHHOLDING_AMOUNT                        ;
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
    t_new_rec.AUTO_TAX_CALC_FLAG                       := :new.AUTO_TAX_CALC_FLAG                            ;
    t_new_rec.PAYMENT_CROSS_RATE_TYPE                  := :new.PAYMENT_CROSS_RATE_TYPE                       ;
    t_new_rec.PAYMENT_CROSS_RATE_DATE                  := :new.PAYMENT_CROSS_RATE_DATE                       ;
    t_new_rec.PAY_CURR_INVOICE_AMOUNT                  := :new.PAY_CURR_INVOICE_AMOUNT                       ;
    t_new_rec.MRC_BASE_AMOUNT                          := :new.MRC_BASE_AMOUNT                               ;
    t_new_rec.MRC_EXCHANGE_RATE                        := :new.MRC_EXCHANGE_RATE                             ;
    t_new_rec.MRC_EXCHANGE_RATE_TYPE                   := :new.MRC_EXCHANGE_RATE_TYPE                        ;
    t_new_rec.MRC_EXCHANGE_DATE                        := :new.MRC_EXCHANGE_DATE                             ;
    t_new_rec.GL_DATE                                  := :new.GL_DATE                                       ;
    t_new_rec.AWARD_ID                                 := :new.AWARD_ID                                      ;
    t_new_rec.PAID_ON_BEHALF_EMPLOYEE_ID               := :new.PAID_ON_BEHALF_EMPLOYEE_ID                    ;
    t_new_rec.AMT_DUE_CCARD_COMPANY                    := :new.AMT_DUE_CCARD_COMPANY                         ;
    t_new_rec.AMT_DUE_EMPLOYEE                         := :new.AMT_DUE_EMPLOYEE                              ;
    t_new_rec.APPROVAL_READY_FLAG                      := :new.APPROVAL_READY_FLAG                           ;
    t_new_rec.APPROVAL_ITERATION                       := :new.APPROVAL_ITERATION                            ;
    t_new_rec.WFAPPROVAL_STATUS                        := :new.WFAPPROVAL_STATUS                             ;
    t_new_rec.REQUESTER_ID                             := :new.REQUESTER_ID                                  ;
    t_new_rec.VALIDATION_REQUEST_ID                    := :new.VALIDATION_REQUEST_ID                         ;
    t_new_rec.VALIDATED_TAX_AMOUNT                     := :new.VALIDATED_TAX_AMOUNT                          ;
    t_new_rec.QUICK_CREDIT                             := :new.QUICK_CREDIT                                  ;
    t_new_rec.CREDITED_INVOICE_ID                      := :new.CREDITED_INVOICE_ID                           ;
    t_new_rec.DISTRIBUTION_SET_ID                      := :new.DISTRIBUTION_SET_ID                           ;
    t_new_rec.APPLICATION_ID                           := :new.APPLICATION_ID                                ;
    t_new_rec.PRODUCT_TABLE                            := :new.PRODUCT_TABLE                                 ;
    t_new_rec.REFERENCE_KEY1                           := :new.REFERENCE_KEY1                                ;
    t_new_rec.REFERENCE_KEY2                           := :new.REFERENCE_KEY2                                ;
    t_new_rec.REFERENCE_KEY3                           := :new.REFERENCE_KEY3                                ;
    t_new_rec.REFERENCE_KEY4                           := :new.REFERENCE_KEY4                                ;
    t_new_rec.REFERENCE_KEY5                           := :new.REFERENCE_KEY5                                ;
    t_new_rec.TOTAL_TAX_AMOUNT                         := :new.TOTAL_TAX_AMOUNT                              ;
    t_new_rec.SELF_ASSESSED_TAX_AMOUNT                 := :new.SELF_ASSESSED_TAX_AMOUNT                      ;
    t_new_rec.TAX_RELATED_INVOICE_ID                   := :new.TAX_RELATED_INVOICE_ID                        ;
    t_new_rec.TRX_BUSINESS_CATEGORY                    := :new.TRX_BUSINESS_CATEGORY                         ;
    t_new_rec.USER_DEFINED_FISC_CLASS                  := :new.USER_DEFINED_FISC_CLASS                       ;
    t_new_rec.TAXATION_COUNTRY                         := :new.TAXATION_COUNTRY                              ;
    t_new_rec.DOCUMENT_SUB_TYPE                        := :new.DOCUMENT_SUB_TYPE                             ;
    t_new_rec.SUPPLIER_TAX_INVOICE_NUMBER              := :new.SUPPLIER_TAX_INVOICE_NUMBER                   ;
    t_new_rec.SUPPLIER_TAX_INVOICE_DATE                := :new.SUPPLIER_TAX_INVOICE_DATE                     ;
    t_new_rec.SUPPLIER_TAX_EXCHANGE_RATE               := :new.SUPPLIER_TAX_EXCHANGE_RATE                    ;
    t_new_rec.TAX_INVOICE_RECORDING_DATE               := :new.TAX_INVOICE_RECORDING_DATE                    ;
    t_new_rec.TAX_INVOICE_INTERNAL_SEQ                 := :new.TAX_INVOICE_INTERNAL_SEQ                      ;
    t_new_rec.LEGAL_ENTITY_ID                          := :new.LEGAL_ENTITY_ID                               ;
    t_new_rec.HISTORICAL_FLAG                          := :new.HISTORICAL_FLAG                               ;
    t_new_rec.FORCE_REVALIDATION_FLAG                  := :new.FORCE_REVALIDATION_FLAG                       ;
    t_new_rec.BANK_CHARGE_BEARER                       := :new.BANK_CHARGE_BEARER                            ;
    t_new_rec.REMITTANCE_MESSAGE1                      := :new.REMITTANCE_MESSAGE1                           ;
    t_new_rec.REMITTANCE_MESSAGE2                      := :new.REMITTANCE_MESSAGE2                           ;
    t_new_rec.REMITTANCE_MESSAGE3                      := :new.REMITTANCE_MESSAGE3                           ;
    t_new_rec.UNIQUE_REMITTANCE_IDENTIFIER             := :new.UNIQUE_REMITTANCE_IDENTIFIER                  ;
    t_new_rec.URI_CHECK_DIGIT                          := :new.URI_CHECK_DIGIT                               ;
    t_new_rec.SETTLEMENT_PRIORITY                      := :new.SETTLEMENT_PRIORITY                           ;
    t_new_rec.PAYMENT_REASON_CODE                      := :new.PAYMENT_REASON_CODE                           ;
    t_new_rec.PAYMENT_REASON_COMMENTS                  := :new.PAYMENT_REASON_COMMENTS                       ;
    t_new_rec.PAYMENT_METHOD_CODE                      := :new.PAYMENT_METHOD_CODE                           ;
    t_new_rec.DELIVERY_CHANNEL_CODE                    := :new.DELIVERY_CHANNEL_CODE                         ;
    t_new_rec.QUICK_PO_HEADER_ID                       := :new.QUICK_PO_HEADER_ID                            ;
    t_new_rec.NET_OF_RETAINAGE_FLAG                    := :new.NET_OF_RETAINAGE_FLAG                         ;
    t_new_rec.RELEASE_AMOUNT_NET_OF_TAX                := :new.RELEASE_AMOUNT_NET_OF_TAX                     ;
    t_new_rec.CONTROL_AMOUNT                           := :new.CONTROL_AMOUNT                                ;
    t_new_rec.PARTY_ID                                 := :new.PARTY_ID                                      ;
    t_new_rec.PARTY_SITE_ID                            := :new.PARTY_SITE_ID                                 ;
    t_new_rec.PAY_PROC_TRXN_TYPE_CODE                  := :new.PAY_PROC_TRXN_TYPE_CODE                       ;
    t_new_rec.PAYMENT_FUNCTION                         := :new.PAYMENT_FUNCTION                              ;
    t_new_rec.CUST_REGISTRATION_CODE                   := :new.CUST_REGISTRATION_CODE                        ;
    t_new_rec.CUST_REGISTRATION_NUMBER                 := :new.CUST_REGISTRATION_NUMBER                      ;
    t_new_rec.PORT_OF_ENTRY_CODE                       := :new.PORT_OF_ENTRY_CODE                            ;
    t_new_rec.EXTERNAL_BANK_ACCOUNT_ID                 := :new.EXTERNAL_BANK_ACCOUNT_ID                      ;
    t_new_rec.VENDOR_CONTACT_ID                        := :new.VENDOR_CONTACT_ID                             ;
    t_new_rec.INTERNAL_CONTACT_EMAIL                   := :new.INTERNAL_CONTACT_EMAIL                        ;
    t_new_rec.DISC_IS_INV_LESS_TAX_FLAG                := :new.DISC_IS_INV_LESS_TAX_FLAG                     ;
    t_new_rec.EXCLUDE_FREIGHT_FROM_DISCOUNT            := :new.EXCLUDE_FREIGHT_FROM_DISCOUNT                 ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.INVOICE_ID                               := :old.INVOICE_ID                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.INVOICE_NUM                              := :old.INVOICE_NUM                                   ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.INVOICE_CURRENCY_CODE                    := :old.INVOICE_CURRENCY_CODE                         ;
    t_old_rec.PAYMENT_CURRENCY_CODE                    := :old.PAYMENT_CURRENCY_CODE                         ;
    t_old_rec.PAYMENT_CROSS_RATE                       := :old.PAYMENT_CROSS_RATE                            ;
    t_old_rec.INVOICE_AMOUNT                           := :old.INVOICE_AMOUNT                                ;
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.AMOUNT_PAID                              := :old.AMOUNT_PAID                                   ;
    t_old_rec.DISCOUNT_AMOUNT_TAKEN                    := :old.DISCOUNT_AMOUNT_TAKEN                         ;
    t_old_rec.INVOICE_DATE                             := :old.INVOICE_DATE                                  ;
    t_old_rec.SOURCE                                   := :old.SOURCE                                        ;
    t_old_rec.INVOICE_TYPE_LOOKUP_CODE                 := :old.INVOICE_TYPE_LOOKUP_CODE                      ;
    t_old_rec.DESCRIPTION                              := :old.DESCRIPTION                                   ;
    t_old_rec.BATCH_ID                                 := :old.BATCH_ID                                      ;
    t_old_rec.AMOUNT_APPLICABLE_TO_DISCOUNT            := :old.AMOUNT_APPLICABLE_TO_DISCOUNT                 ;
    t_old_rec.TAX_AMOUNT                               := :old.TAX_AMOUNT                                    ;
    t_old_rec.TERMS_ID                                 := :old.TERMS_ID                                      ;
    t_old_rec.TERMS_DATE                               := :old.TERMS_DATE                                    ;
    t_old_rec.PAYMENT_METHOD_LOOKUP_CODE               := :old.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_old_rec.PAY_GROUP_LOOKUP_CODE                    := :old.PAY_GROUP_LOOKUP_CODE                         ;
    t_old_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :old.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_old_rec.PAYMENT_STATUS_FLAG                      := :old.PAYMENT_STATUS_FLAG                           ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.BASE_AMOUNT                              := :old.BASE_AMOUNT                                   ;
    t_old_rec.VAT_CODE                                 := :old.VAT_CODE                                      ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.EXCLUSIVE_PAYMENT_FLAG                   := :old.EXCLUSIVE_PAYMENT_FLAG                        ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.FREIGHT_AMOUNT                           := :old.FREIGHT_AMOUNT                                ;
    t_old_rec.GOODS_RECEIVED_DATE                      := :old.GOODS_RECEIVED_DATE                           ;
    t_old_rec.INVOICE_RECEIVED_DATE                    := :old.INVOICE_RECEIVED_DATE                         ;
    t_old_rec.VOUCHER_NUM                              := :old.VOUCHER_NUM                                   ;
    t_old_rec.APPROVED_AMOUNT                          := :old.APPROVED_AMOUNT                               ;
    t_old_rec.RECURRING_PAYMENT_ID                     := :old.RECURRING_PAYMENT_ID                          ;
    t_old_rec.EXCHANGE_RATE                            := :old.EXCHANGE_RATE                                 ;
    t_old_rec.EXCHANGE_RATE_TYPE                       := :old.EXCHANGE_RATE_TYPE                            ;
    t_old_rec.EXCHANGE_DATE                            := :old.EXCHANGE_DATE                                 ;
    t_old_rec.EARLIEST_SETTLEMENT_DATE                 := :old.EARLIEST_SETTLEMENT_DATE                      ;
    t_old_rec.ORIGINAL_PREPAYMENT_AMOUNT               := :old.ORIGINAL_PREPAYMENT_AMOUNT                    ;
    t_old_rec.DOC_SEQUENCE_ID                          := :old.DOC_SEQUENCE_ID                               ;
    t_old_rec.DOC_SEQUENCE_VALUE                       := :old.DOC_SEQUENCE_VALUE                            ;
    t_old_rec.DOC_CATEGORY_CODE                        := :old.DOC_CATEGORY_CODE                             ;
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
    t_old_rec.ATTRIBUTE_CATEGORY                       := :old.ATTRIBUTE_CATEGORY                            ;
    t_old_rec.APPROVAL_STATUS                          := :old.APPROVAL_STATUS                               ;
    t_old_rec.APPROVAL_DESCRIPTION                     := :old.APPROVAL_DESCRIPTION                          ;
    t_old_rec.INVOICE_DISTRIBUTION_TOTAL               := :old.INVOICE_DISTRIBUTION_TOTAL                    ;
    t_old_rec.POSTING_STATUS                           := :old.POSTING_STATUS                                ;
    t_old_rec.PREPAY_FLAG                              := :old.PREPAY_FLAG                                   ;
    t_old_rec.AUTHORIZED_BY                            := :old.AUTHORIZED_BY                                 ;
    t_old_rec.CANCELLED_DATE                           := :old.CANCELLED_DATE                                ;
    t_old_rec.CANCELLED_BY                             := :old.CANCELLED_BY                                  ;
    t_old_rec.CANCELLED_AMOUNT                         := :old.CANCELLED_AMOUNT                              ;
    t_old_rec.TEMP_CANCELLED_AMOUNT                    := :old.TEMP_CANCELLED_AMOUNT                         ;
    t_old_rec.PROJECT_ACCOUNTING_CONTEXT               := :old.PROJECT_ACCOUNTING_CONTEXT                    ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.USSGL_TRX_CODE_CONTEXT                   := :old.USSGL_TRX_CODE_CONTEXT                        ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
    t_old_rec.EXPENDITURE_TYPE                         := :old.EXPENDITURE_TYPE                              ;
    t_old_rec.EXPENDITURE_ITEM_DATE                    := :old.EXPENDITURE_ITEM_DATE                         ;
    t_old_rec.PA_QUANTITY                              := :old.PA_QUANTITY                                   ;
    t_old_rec.EXPENDITURE_ORGANIZATION_ID              := :old.EXPENDITURE_ORGANIZATION_ID                   ;
    t_old_rec.PA_DEFAULT_DIST_CCID                     := :old.PA_DEFAULT_DIST_CCID                          ;
    t_old_rec.VENDOR_PREPAY_AMOUNT                     := :old.VENDOR_PREPAY_AMOUNT                          ;
    t_old_rec.PAYMENT_AMOUNT_TOTAL                     := :old.PAYMENT_AMOUNT_TOTAL                          ;
    t_old_rec.AWT_FLAG                                 := :old.AWT_FLAG                                      ;
    t_old_rec.AWT_GROUP_ID                             := :old.AWT_GROUP_ID                                  ;
    t_old_rec.REFERENCE_1                              := :old.REFERENCE_1                                   ;
    t_old_rec.REFERENCE_2                              := :old.REFERENCE_2                                   ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.PRE_WITHHOLDING_AMOUNT                   := :old.PRE_WITHHOLDING_AMOUNT                        ;
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
    t_old_rec.AUTO_TAX_CALC_FLAG                       := :old.AUTO_TAX_CALC_FLAG                            ;
    t_old_rec.PAYMENT_CROSS_RATE_TYPE                  := :old.PAYMENT_CROSS_RATE_TYPE                       ;
    t_old_rec.PAYMENT_CROSS_RATE_DATE                  := :old.PAYMENT_CROSS_RATE_DATE                       ;
    t_old_rec.PAY_CURR_INVOICE_AMOUNT                  := :old.PAY_CURR_INVOICE_AMOUNT                       ;
    t_old_rec.MRC_BASE_AMOUNT                          := :old.MRC_BASE_AMOUNT                               ;
    t_old_rec.MRC_EXCHANGE_RATE                        := :old.MRC_EXCHANGE_RATE                             ;
    t_old_rec.MRC_EXCHANGE_RATE_TYPE                   := :old.MRC_EXCHANGE_RATE_TYPE                        ;
    t_old_rec.MRC_EXCHANGE_DATE                        := :old.MRC_EXCHANGE_DATE                             ;
    t_old_rec.GL_DATE                                  := :old.GL_DATE                                       ;
    t_old_rec.AWARD_ID                                 := :old.AWARD_ID                                      ;
    t_old_rec.PAID_ON_BEHALF_EMPLOYEE_ID               := :old.PAID_ON_BEHALF_EMPLOYEE_ID                    ;
    t_old_rec.AMT_DUE_CCARD_COMPANY                    := :old.AMT_DUE_CCARD_COMPANY                         ;
    t_old_rec.AMT_DUE_EMPLOYEE                         := :old.AMT_DUE_EMPLOYEE                              ;
    t_old_rec.APPROVAL_READY_FLAG                      := :old.APPROVAL_READY_FLAG                           ;
    t_old_rec.APPROVAL_ITERATION                       := :old.APPROVAL_ITERATION                            ;
    t_old_rec.WFAPPROVAL_STATUS                        := :old.WFAPPROVAL_STATUS                             ;
    t_old_rec.REQUESTER_ID                             := :old.REQUESTER_ID                                  ;
    t_old_rec.VALIDATION_REQUEST_ID                    := :old.VALIDATION_REQUEST_ID                         ;
    t_old_rec.VALIDATED_TAX_AMOUNT                     := :old.VALIDATED_TAX_AMOUNT                          ;
    t_old_rec.QUICK_CREDIT                             := :old.QUICK_CREDIT                                  ;
    t_old_rec.CREDITED_INVOICE_ID                      := :old.CREDITED_INVOICE_ID                           ;
    t_old_rec.DISTRIBUTION_SET_ID                      := :old.DISTRIBUTION_SET_ID                           ;
    t_old_rec.APPLICATION_ID                           := :old.APPLICATION_ID                                ;
    t_old_rec.PRODUCT_TABLE                            := :old.PRODUCT_TABLE                                 ;
    t_old_rec.REFERENCE_KEY1                           := :old.REFERENCE_KEY1                                ;
    t_old_rec.REFERENCE_KEY2                           := :old.REFERENCE_KEY2                                ;
    t_old_rec.REFERENCE_KEY3                           := :old.REFERENCE_KEY3                                ;
    t_old_rec.REFERENCE_KEY4                           := :old.REFERENCE_KEY4                                ;
    t_old_rec.REFERENCE_KEY5                           := :old.REFERENCE_KEY5                                ;
    t_old_rec.TOTAL_TAX_AMOUNT                         := :old.TOTAL_TAX_AMOUNT                              ;
    t_old_rec.SELF_ASSESSED_TAX_AMOUNT                 := :old.SELF_ASSESSED_TAX_AMOUNT                      ;
    t_old_rec.TAX_RELATED_INVOICE_ID                   := :old.TAX_RELATED_INVOICE_ID                        ;
    t_old_rec.TRX_BUSINESS_CATEGORY                    := :old.TRX_BUSINESS_CATEGORY                         ;
    t_old_rec.USER_DEFINED_FISC_CLASS                  := :old.USER_DEFINED_FISC_CLASS                       ;
    t_old_rec.TAXATION_COUNTRY                         := :old.TAXATION_COUNTRY                              ;
    t_old_rec.DOCUMENT_SUB_TYPE                        := :old.DOCUMENT_SUB_TYPE                             ;
    t_old_rec.SUPPLIER_TAX_INVOICE_NUMBER              := :old.SUPPLIER_TAX_INVOICE_NUMBER                   ;
    t_old_rec.SUPPLIER_TAX_INVOICE_DATE                := :old.SUPPLIER_TAX_INVOICE_DATE                     ;
    t_old_rec.SUPPLIER_TAX_EXCHANGE_RATE               := :old.SUPPLIER_TAX_EXCHANGE_RATE                    ;
    t_old_rec.TAX_INVOICE_RECORDING_DATE               := :old.TAX_INVOICE_RECORDING_DATE                    ;
    t_old_rec.TAX_INVOICE_INTERNAL_SEQ                 := :old.TAX_INVOICE_INTERNAL_SEQ                      ;
    t_old_rec.LEGAL_ENTITY_ID                          := :old.LEGAL_ENTITY_ID                               ;
    t_old_rec.HISTORICAL_FLAG                          := :old.HISTORICAL_FLAG                               ;
    t_old_rec.FORCE_REVALIDATION_FLAG                  := :old.FORCE_REVALIDATION_FLAG                       ;
    t_old_rec.BANK_CHARGE_BEARER                       := :old.BANK_CHARGE_BEARER                            ;
    t_old_rec.REMITTANCE_MESSAGE1                      := :old.REMITTANCE_MESSAGE1                           ;
    t_old_rec.REMITTANCE_MESSAGE2                      := :old.REMITTANCE_MESSAGE2                           ;
    t_old_rec.REMITTANCE_MESSAGE3                      := :old.REMITTANCE_MESSAGE3                           ;
    t_old_rec.UNIQUE_REMITTANCE_IDENTIFIER             := :old.UNIQUE_REMITTANCE_IDENTIFIER                  ;
    t_old_rec.URI_CHECK_DIGIT                          := :old.URI_CHECK_DIGIT                               ;
    t_old_rec.SETTLEMENT_PRIORITY                      := :old.SETTLEMENT_PRIORITY                           ;
    t_old_rec.PAYMENT_REASON_CODE                      := :old.PAYMENT_REASON_CODE                           ;
    t_old_rec.PAYMENT_REASON_COMMENTS                  := :old.PAYMENT_REASON_COMMENTS                       ;
    t_old_rec.PAYMENT_METHOD_CODE                      := :old.PAYMENT_METHOD_CODE                           ;
    t_old_rec.DELIVERY_CHANNEL_CODE                    := :old.DELIVERY_CHANNEL_CODE                         ;
    t_old_rec.QUICK_PO_HEADER_ID                       := :old.QUICK_PO_HEADER_ID                            ;
    t_old_rec.NET_OF_RETAINAGE_FLAG                    := :old.NET_OF_RETAINAGE_FLAG                         ;
    t_old_rec.RELEASE_AMOUNT_NET_OF_TAX                := :old.RELEASE_AMOUNT_NET_OF_TAX                     ;
    t_old_rec.CONTROL_AMOUNT                           := :old.CONTROL_AMOUNT                                ;
    t_old_rec.PARTY_ID                                 := :old.PARTY_ID                                      ;
    t_old_rec.PARTY_SITE_ID                            := :old.PARTY_SITE_ID                                 ;
    t_old_rec.PAY_PROC_TRXN_TYPE_CODE                  := :old.PAY_PROC_TRXN_TYPE_CODE                       ;
    t_old_rec.PAYMENT_FUNCTION                         := :old.PAYMENT_FUNCTION                              ;
    t_old_rec.CUST_REGISTRATION_CODE                   := :old.CUST_REGISTRATION_CODE                        ;
    t_old_rec.CUST_REGISTRATION_NUMBER                 := :old.CUST_REGISTRATION_NUMBER                      ;
    t_old_rec.PORT_OF_ENTRY_CODE                       := :old.PORT_OF_ENTRY_CODE                            ;
    t_old_rec.EXTERNAL_BANK_ACCOUNT_ID                 := :old.EXTERNAL_BANK_ACCOUNT_ID                      ;
    t_old_rec.VENDOR_CONTACT_ID                        := :old.VENDOR_CONTACT_ID                             ;
    t_old_rec.INTERNAL_CONTACT_EMAIL                   := :old.INTERNAL_CONTACT_EMAIL                        ;
    t_old_rec.DISC_IS_INV_LESS_TAX_FLAG                := :old.DISC_IS_INV_LESS_TAX_FLAG                     ;
    t_old_rec.EXCLUDE_FREIGHT_FROM_DISCOUNT            := :old.EXCLUDE_FREIGHT_FROM_DISCOUNT                 ;
  END populate_old ;

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


  /*
  || make a call to the INR check package.
  */
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AP_IA_ARIUD_T1', P_ORG_ID => :new.org_id, p_set_of_books_id => :new.set_of_books_id) = FALSE THEN
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

      JAI_AP_IA_TRIGGER_PKG.ARUID_T1 (
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

      JAI_AP_IA_TRIGGER_PKG.ARUID_T1 (
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

      JAI_AP_IA_TRIGGER_PKG.ARUID_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AP_IA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AP_IA_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_AP_IA_ARIUD_T1" DISABLE;
