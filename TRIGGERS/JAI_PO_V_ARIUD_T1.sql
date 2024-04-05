--------------------------------------------------------
--  DDL for Trigger JAI_PO_V_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_V_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AP"."AP_SUPPLIERS"
FOR EACH ROW
DECLARE
-- Bug 5141305. Added by Lakshmi Gopalsami
  -- Changed PO_AP_VENDORS to AP_SUPPLIERS
  t_old_rec             AP_SUPPLIERS%rowtype ;
  t_new_rec             AP_SUPPLIERS%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

   /*----------------------------------------------------------------------------------------------------------------------
   CHANGE HISTORY:
   S.No    Date          Author and Details

    1.    07-Nov-2005    Ramananda for bug# 4718848. FileVersion 120.1
                         Removed the references of columns PARTY_ID, PARENT_PARTY_ID of table PO_AP_VENDORS

    2.    04-Jan-2006    rallamse for Bug#4547059. File version 120.2
                         Issue : Payables is migrating Suppliers information to TCA in R12.
                         As part of R12 activities, some columns of PO_VENDORS and PO_VENDOR_SITES_ALL
                         have been obsoleted.
                         PO_AP_VENDORS is a synonym for PO.PO_VENDORS
                         Fix :
                         Removed the reference to following columns of table PO_AP_VENDORS :
                          ACCTS_PAY_CODE_COMBINATION_ID, AMOUNT_INCLUDES_TAX_FLAG , AUTO_TAX_CALC_FLAG
                          AUTO_TAX_CALC_OVERRIDE, BANK_ACCOUNT_NAME, BANK_ACCOUNT_NUM, BANK_ACCOUNT_TYPE,
                          BANK_NUM, BANK_NUMBER, BILL_TO_LOCATION_ID, DISTRIBUTION_SET_ID,
                          EDI_PAYMENT_FORMAT, EDI_PAYMENT_METHOD, EDI_REMITTANCE_INSTRUCTION ,
                          EDI_REMITTANCE_METHOD, EDI_TRANSACTION_HANDLING, EXCLUSIVE_PAYMENT_FLAG,
                          FOB_LOOKUP_CODE, FREIGHT_TERMS_LOOKUP_CODE, FUTURE_DATED_PAYMENT_CCID,
                          OFFSET_TAX_FLAG, PAYMENT_METHOD_LOOKUP_CODE, PREPAY_CODE_COMBINATION_ID,
                          SHIP_TO_LOCATION_ID, SHIP_VIA_LOOKUP_CODE, VAT_CODE

   -----------------------------------------------------------------------------------------------------------------------*/

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.VENDOR_NAME                              := :new.VENDOR_NAME                                   ;
    t_new_rec.SEGMENT1                                 := :new.SEGMENT1                                      ;
    t_new_rec.SUMMARY_FLAG                             := :new.SUMMARY_FLAG                                  ;
    t_new_rec.ENABLED_FLAG                             := :new.ENABLED_FLAG                                  ;
    t_new_rec.SEGMENT2                                 := :new.SEGMENT2                                      ;
    t_new_rec.SEGMENT3                                 := :new.SEGMENT3                                      ;
    t_new_rec.SEGMENT4                                 := :new.SEGMENT4                                      ;
    t_new_rec.SEGMENT5                                 := :new.SEGMENT5                                      ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.EMPLOYEE_ID                              := :new.EMPLOYEE_ID                                   ;
    t_new_rec.VENDOR_TYPE_LOOKUP_CODE                  := :new.VENDOR_TYPE_LOOKUP_CODE                       ;
    t_new_rec.CUSTOMER_NUM                             := :new.CUSTOMER_NUM                                  ;
    t_new_rec.ONE_TIME_FLAG                            := :new.ONE_TIME_FLAG                                 ;
    t_new_rec.PARENT_VENDOR_ID                         := :new.PARENT_VENDOR_ID                              ;
    t_new_rec.MIN_ORDER_AMOUNT                         := :new.MIN_ORDER_AMOUNT                              ;
    t_new_rec.TERMS_ID                                 := :new.TERMS_ID                                      ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.CREDIT_STATUS_LOOKUP_CODE                := :new.CREDIT_STATUS_LOOKUP_CODE                     ;
    t_new_rec.CREDIT_LIMIT                             := :new.CREDIT_LIMIT                                  ;
    t_new_rec.ALWAYS_TAKE_DISC_FLAG                    := :new.ALWAYS_TAKE_DISC_FLAG                         ;
    t_new_rec.PAY_DATE_BASIS_LOOKUP_CODE               := :new.PAY_DATE_BASIS_LOOKUP_CODE                    ;
    t_new_rec.PAY_GROUP_LOOKUP_CODE                    := :new.PAY_GROUP_LOOKUP_CODE                         ;
    t_new_rec.PAYMENT_PRIORITY                         := :new.PAYMENT_PRIORITY                              ;
    t_new_rec.INVOICE_CURRENCY_CODE                    := :new.INVOICE_CURRENCY_CODE                         ;
    t_new_rec.PAYMENT_CURRENCY_CODE                    := :new.PAYMENT_CURRENCY_CODE                         ;
    t_new_rec.INVOICE_AMOUNT_LIMIT                     := :new.INVOICE_AMOUNT_LIMIT                          ;
    t_new_rec.EXCHANGE_DATE_LOOKUP_CODE                := :new.EXCHANGE_DATE_LOOKUP_CODE                     ;
    t_new_rec.HOLD_ALL_PAYMENTS_FLAG                   := :new.HOLD_ALL_PAYMENTS_FLAG                        ;
    t_new_rec.HOLD_FUTURE_PAYMENTS_FLAG                := :new.HOLD_FUTURE_PAYMENTS_FLAG                     ;
    t_new_rec.HOLD_REASON                              := :new.HOLD_REASON                                   ;
    t_new_rec.DISC_LOST_CODE_COMBINATION_ID            := :new.DISC_LOST_CODE_COMBINATION_ID                 ;
    t_new_rec.DISC_TAKEN_CODE_COMBINATION_ID           := :new.DISC_TAKEN_CODE_COMBINATION_ID                ;
    t_new_rec.EXPENSE_CODE_COMBINATION_ID              := :new.EXPENSE_CODE_COMBINATION_ID                   ;
    t_new_rec.NUM_1099                                 := :new.NUM_1099                                      ;
    t_new_rec.TYPE_1099                                := :new.TYPE_1099                                     ;
    t_new_rec.WITHHOLDING_STATUS_LOOKUP_CODE           := :new.WITHHOLDING_STATUS_LOOKUP_CODE                ;
    t_new_rec.WITHHOLDING_START_DATE                   := :new.WITHHOLDING_START_DATE                        ;
    t_new_rec.ORGANIZATION_TYPE_LOOKUP_CODE            := :new.ORGANIZATION_TYPE_LOOKUP_CODE                 ;
    t_new_rec.START_DATE_ACTIVE                        := :new.START_DATE_ACTIVE                             ;
    t_new_rec.END_DATE_ACTIVE                          := :new.END_DATE_ACTIVE                               ;
    t_new_rec.MINORITY_GROUP_LOOKUP_CODE               := :new.MINORITY_GROUP_LOOKUP_CODE                    ;
    t_new_rec.WOMEN_OWNED_FLAG                         := :new.WOMEN_OWNED_FLAG                              ;
    t_new_rec.SMALL_BUSINESS_FLAG                      := :new.SMALL_BUSINESS_FLAG                           ;
    t_new_rec.STANDARD_INDUSTRY_CLASS                  := :new.STANDARD_INDUSTRY_CLASS                       ;
    t_new_rec.HOLD_FLAG                                := :new.HOLD_FLAG                                     ;
    t_new_rec.PURCHASING_HOLD_REASON                   := :new.PURCHASING_HOLD_REASON                        ;
    t_new_rec.HOLD_BY                                  := :new.HOLD_BY                                       ;
    t_new_rec.HOLD_DATE                                := :new.HOLD_DATE                                     ;
    t_new_rec.TERMS_DATE_BASIS                         := :new.TERMS_DATE_BASIS                              ;
    t_new_rec.PRICE_TOLERANCE                          := :new.PRICE_TOLERANCE                               ;
    t_new_rec.INSPECTION_REQUIRED_FLAG                 := :new.INSPECTION_REQUIRED_FLAG                      ;
    t_new_rec.RECEIPT_REQUIRED_FLAG                    := :new.RECEIPT_REQUIRED_FLAG                         ;
    t_new_rec.QTY_RCV_TOLERANCE                        := :new.QTY_RCV_TOLERANCE                             ;
    t_new_rec.QTY_RCV_EXCEPTION_CODE                   := :new.QTY_RCV_EXCEPTION_CODE                        ;
    t_new_rec.ENFORCE_SHIP_TO_LOCATION_CODE            := :new.ENFORCE_SHIP_TO_LOCATION_CODE                 ;
    t_new_rec.DAYS_EARLY_RECEIPT_ALLOWED               := :new.DAYS_EARLY_RECEIPT_ALLOWED                    ;
    t_new_rec.DAYS_LATE_RECEIPT_ALLOWED                := :new.DAYS_LATE_RECEIPT_ALLOWED                     ;
    t_new_rec.RECEIPT_DAYS_EXCEPTION_CODE              := :new.RECEIPT_DAYS_EXCEPTION_CODE                   ;
    t_new_rec.RECEIVING_ROUTING_ID                     := :new.RECEIVING_ROUTING_ID                          ;
    t_new_rec.ALLOW_SUBSTITUTE_RECEIPTS_FLAG           := :new.ALLOW_SUBSTITUTE_RECEIPTS_FLAG                ;
    t_new_rec.ALLOW_UNORDERED_RECEIPTS_FLAG            := :new.ALLOW_UNORDERED_RECEIPTS_FLAG                 ;
    t_new_rec.HOLD_UNMATCHED_INVOICES_FLAG             := :new.HOLD_UNMATCHED_INVOICES_FLAG                  ;
    t_new_rec.TAX_VERIFICATION_DATE                    := :new.TAX_VERIFICATION_DATE                         ;
    t_new_rec.NAME_CONTROL                             := :new.NAME_CONTROL                                  ;
    t_new_rec.STATE_REPORTABLE_FLAG                    := :new.STATE_REPORTABLE_FLAG                         ;
    t_new_rec.FEDERAL_REPORTABLE_FLAG                  := :new.FEDERAL_REPORTABLE_FLAG                       ;
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
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.OFFSET_VAT_CODE                          := :new.OFFSET_VAT_CODE                               ;
    t_new_rec.VAT_REGISTRATION_NUM                     := :new.VAT_REGISTRATION_NUM                          ;
    t_new_rec.AUTO_CALCULATE_INTEREST_FLAG             := :new.AUTO_CALCULATE_INTEREST_FLAG                  ;
    t_new_rec.VALIDATION_NUMBER                        := :new.VALIDATION_NUMBER                             ;
    t_new_rec.EXCLUDE_FREIGHT_FROM_DISCOUNT            := :new.EXCLUDE_FREIGHT_FROM_DISCOUNT                 ;
    t_new_rec.TAX_REPORTING_NAME                       := :new.TAX_REPORTING_NAME                            ;
    t_new_rec.CHECK_DIGITS                             := :new.CHECK_DIGITS                                  ;
    t_new_rec.ALLOW_AWT_FLAG                           := :new.ALLOW_AWT_FLAG                                ;
    t_new_rec.AWT_GROUP_ID                             := :new.AWT_GROUP_ID                                  ;
    t_new_rec.VENDOR_NAME_ALT                          := :new.VENDOR_NAME_ALT                               ;
    t_new_rec.AP_TAX_ROUNDING_RULE                     := :new.AP_TAX_ROUNDING_RULE                          ;
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
    t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :new.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_new_rec.BANK_CHARGE_BEARER                       := :new.BANK_CHARGE_BEARER                            ;
    t_new_rec.BANK_BRANCH_TYPE                         := :new.BANK_BRANCH_TYPE                              ;
    t_new_rec.MATCH_OPTION                             := :new.MATCH_OPTION                                  ;
    t_new_rec.CREATE_DEBIT_MEMO_FLAG                   := :new.CREATE_DEBIT_MEMO_FLAG                        ;
    t_new_rec.NI_NUMBER                                := :new.NI_NUMBER                                     ;
    /* Commented by rallamse for Bug#4547059
    t_new_rec.VAT_CODE                                 := :new.VAT_CODE                                      ;
    t_new_rec.PREPAY_CODE_COMBINATION_ID               := :new.PREPAY_CODE_COMBINATION_ID                    ;
    t_new_rec.PAYMENT_METHOD_LOOKUP_CODE               := :new.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_new_rec.OFFSET_TAX_FLAG                          := :new.OFFSET_TAX_FLAG                               ;
    t_new_rec.FUTURE_DATED_PAYMENT_CCID                := :new.FUTURE_DATED_PAYMENT_CCID                     ;
    t_new_rec.EXCLUSIVE_PAYMENT_FLAG                   := :new.EXCLUSIVE_PAYMENT_FLAG                        ;
    t_new_rec.DISTRIBUTION_SET_ID                      := :new.DISTRIBUTION_SET_ID                           ;
    t_new_rec.SHIP_TO_LOCATION_ID                      := :new.SHIP_TO_LOCATION_ID                           ;
    t_new_rec.BILL_TO_LOCATION_ID                      := :new.BILL_TO_LOCATION_ID                           ;
    t_new_rec.SHIP_VIA_LOOKUP_CODE                     := :new.SHIP_VIA_LOOKUP_CODE                          ;
    t_new_rec.FREIGHT_TERMS_LOOKUP_CODE                := :new.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_new_rec.FOB_LOOKUP_CODE                          := :new.FOB_LOOKUP_CODE                               ;
    t_new_rec.BANK_NUMBER                              := :new.BANK_NUMBER                                   ;
    t_new_rec.AUTO_TAX_CALC_FLAG                       := :new.AUTO_TAX_CALC_FLAG                            ;
    t_new_rec.AUTO_TAX_CALC_OVERRIDE                   := :new.AUTO_TAX_CALC_OVERRIDE                        ;
    t_new_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :new.AMOUNT_INCLUDES_TAX_FLAG                      ;
    t_new_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :new.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_new_rec.BANK_ACCOUNT_NAME                        := :new.BANK_ACCOUNT_NAME                             ;
    t_new_rec.BANK_ACCOUNT_NUM                         := :new.BANK_ACCOUNT_NUM                              ;
    t_new_rec.BANK_NUM                                 := :new.BANK_NUM                                      ;
    t_new_rec.BANK_ACCOUNT_TYPE                        := :new.BANK_ACCOUNT_TYPE                             ;
    t_new_rec.EDI_TRANSACTION_HANDLING                 := :new.EDI_TRANSACTION_HANDLING                      ;
    t_new_rec.EDI_PAYMENT_METHOD                       := :new.EDI_PAYMENT_METHOD                            ;
    t_new_rec.EDI_PAYMENT_FORMAT                       := :new.EDI_PAYMENT_FORMAT                            ;
    t_new_rec.EDI_REMITTANCE_METHOD                    := :new.EDI_REMITTANCE_METHOD                         ;
    t_new_rec.EDI_REMITTANCE_INSTRUCTION               := :new.EDI_REMITTANCE_INSTRUCTION                    ;
    */
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.VENDOR_NAME                              := :old.VENDOR_NAME                                   ;
    t_old_rec.SEGMENT1                                 := :old.SEGMENT1                                      ;
    t_old_rec.SUMMARY_FLAG                             := :old.SUMMARY_FLAG                                  ;
    t_old_rec.ENABLED_FLAG                             := :old.ENABLED_FLAG                                  ;
    t_old_rec.SEGMENT2                                 := :old.SEGMENT2                                      ;
    t_old_rec.SEGMENT3                                 := :old.SEGMENT3                                      ;
    t_old_rec.SEGMENT4                                 := :old.SEGMENT4                                      ;
    t_old_rec.SEGMENT5                                 := :old.SEGMENT5                                      ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.EMPLOYEE_ID                              := :old.EMPLOYEE_ID                                   ;
    t_old_rec.VENDOR_TYPE_LOOKUP_CODE                  := :old.VENDOR_TYPE_LOOKUP_CODE                       ;
    t_old_rec.CUSTOMER_NUM                             := :old.CUSTOMER_NUM                                  ;
    t_old_rec.ONE_TIME_FLAG                            := :old.ONE_TIME_FLAG                                 ;
    t_old_rec.PARENT_VENDOR_ID                         := :old.PARENT_VENDOR_ID                              ;
    t_old_rec.MIN_ORDER_AMOUNT                         := :old.MIN_ORDER_AMOUNT                              ;
    t_old_rec.TERMS_ID                                 := :old.TERMS_ID                                      ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.CREDIT_STATUS_LOOKUP_CODE                := :old.CREDIT_STATUS_LOOKUP_CODE                     ;
    t_old_rec.CREDIT_LIMIT                             := :old.CREDIT_LIMIT                                  ;
    t_old_rec.ALWAYS_TAKE_DISC_FLAG                    := :old.ALWAYS_TAKE_DISC_FLAG                         ;
    t_old_rec.PAY_DATE_BASIS_LOOKUP_CODE               := :old.PAY_DATE_BASIS_LOOKUP_CODE                    ;
    t_old_rec.PAY_GROUP_LOOKUP_CODE                    := :old.PAY_GROUP_LOOKUP_CODE                         ;
    t_old_rec.PAYMENT_PRIORITY                         := :old.PAYMENT_PRIORITY                              ;
    t_old_rec.INVOICE_CURRENCY_CODE                    := :old.INVOICE_CURRENCY_CODE                         ;
    t_old_rec.PAYMENT_CURRENCY_CODE                    := :old.PAYMENT_CURRENCY_CODE                         ;
    t_old_rec.INVOICE_AMOUNT_LIMIT                     := :old.INVOICE_AMOUNT_LIMIT                          ;
    t_old_rec.EXCHANGE_DATE_LOOKUP_CODE                := :old.EXCHANGE_DATE_LOOKUP_CODE                     ;
    t_old_rec.HOLD_ALL_PAYMENTS_FLAG                   := :old.HOLD_ALL_PAYMENTS_FLAG                        ;
    t_old_rec.HOLD_FUTURE_PAYMENTS_FLAG                := :old.HOLD_FUTURE_PAYMENTS_FLAG                     ;
    t_old_rec.HOLD_REASON                              := :old.HOLD_REASON                                   ;
    t_old_rec.DISC_LOST_CODE_COMBINATION_ID            := :old.DISC_LOST_CODE_COMBINATION_ID                 ;
    t_old_rec.DISC_TAKEN_CODE_COMBINATION_ID           := :old.DISC_TAKEN_CODE_COMBINATION_ID                ;
    t_old_rec.EXPENSE_CODE_COMBINATION_ID              := :old.EXPENSE_CODE_COMBINATION_ID                   ;
    t_old_rec.NUM_1099                                 := :old.NUM_1099                                      ;
    t_old_rec.TYPE_1099                                := :old.TYPE_1099                                     ;
    t_old_rec.WITHHOLDING_STATUS_LOOKUP_CODE           := :old.WITHHOLDING_STATUS_LOOKUP_CODE                ;
    t_old_rec.WITHHOLDING_START_DATE                   := :old.WITHHOLDING_START_DATE                        ;
    t_old_rec.ORGANIZATION_TYPE_LOOKUP_CODE            := :old.ORGANIZATION_TYPE_LOOKUP_CODE                 ;
    t_old_rec.START_DATE_ACTIVE                        := :old.START_DATE_ACTIVE                             ;
    t_old_rec.END_DATE_ACTIVE                          := :old.END_DATE_ACTIVE                               ;
    t_old_rec.MINORITY_GROUP_LOOKUP_CODE               := :old.MINORITY_GROUP_LOOKUP_CODE                    ;
    t_old_rec.WOMEN_OWNED_FLAG                         := :old.WOMEN_OWNED_FLAG                              ;
    t_old_rec.SMALL_BUSINESS_FLAG                      := :old.SMALL_BUSINESS_FLAG                           ;
    t_old_rec.STANDARD_INDUSTRY_CLASS                  := :old.STANDARD_INDUSTRY_CLASS                       ;
    t_old_rec.HOLD_FLAG                                := :old.HOLD_FLAG                                     ;
    t_old_rec.PURCHASING_HOLD_REASON                   := :old.PURCHASING_HOLD_REASON                        ;
    t_old_rec.HOLD_BY                                  := :old.HOLD_BY                                       ;
    t_old_rec.HOLD_DATE                                := :old.HOLD_DATE                                     ;
    t_old_rec.TERMS_DATE_BASIS                         := :old.TERMS_DATE_BASIS                              ;
    t_old_rec.PRICE_TOLERANCE                          := :old.PRICE_TOLERANCE                               ;
    t_old_rec.INSPECTION_REQUIRED_FLAG                 := :old.INSPECTION_REQUIRED_FLAG                      ;
    t_old_rec.RECEIPT_REQUIRED_FLAG                    := :old.RECEIPT_REQUIRED_FLAG                         ;
    t_old_rec.QTY_RCV_TOLERANCE                        := :old.QTY_RCV_TOLERANCE                             ;
    t_old_rec.QTY_RCV_EXCEPTION_CODE                   := :old.QTY_RCV_EXCEPTION_CODE                        ;
    t_old_rec.ENFORCE_SHIP_TO_LOCATION_CODE            := :old.ENFORCE_SHIP_TO_LOCATION_CODE                 ;
    t_old_rec.DAYS_EARLY_RECEIPT_ALLOWED               := :old.DAYS_EARLY_RECEIPT_ALLOWED                    ;
    t_old_rec.DAYS_LATE_RECEIPT_ALLOWED                := :old.DAYS_LATE_RECEIPT_ALLOWED                     ;
    t_old_rec.RECEIPT_DAYS_EXCEPTION_CODE              := :old.RECEIPT_DAYS_EXCEPTION_CODE                   ;
    t_old_rec.RECEIVING_ROUTING_ID                     := :old.RECEIVING_ROUTING_ID                          ;
    t_old_rec.ALLOW_SUBSTITUTE_RECEIPTS_FLAG           := :old.ALLOW_SUBSTITUTE_RECEIPTS_FLAG                ;
    t_old_rec.ALLOW_UNORDERED_RECEIPTS_FLAG            := :old.ALLOW_UNORDERED_RECEIPTS_FLAG                 ;
    t_old_rec.HOLD_UNMATCHED_INVOICES_FLAG             := :old.HOLD_UNMATCHED_INVOICES_FLAG                  ;
    t_old_rec.TAX_VERIFICATION_DATE                    := :old.TAX_VERIFICATION_DATE                         ;
    t_old_rec.NAME_CONTROL                             := :old.NAME_CONTROL                                  ;
    t_old_rec.STATE_REPORTABLE_FLAG                    := :old.STATE_REPORTABLE_FLAG                         ;
    t_old_rec.FEDERAL_REPORTABLE_FLAG                  := :old.FEDERAL_REPORTABLE_FLAG                       ;
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
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.OFFSET_VAT_CODE                          := :old.OFFSET_VAT_CODE                               ;
    t_old_rec.VAT_REGISTRATION_NUM                     := :old.VAT_REGISTRATION_NUM                          ;
    t_old_rec.AUTO_CALCULATE_INTEREST_FLAG             := :old.AUTO_CALCULATE_INTEREST_FLAG                  ;
    t_old_rec.VALIDATION_NUMBER                        := :old.VALIDATION_NUMBER                             ;
    t_old_rec.EXCLUDE_FREIGHT_FROM_DISCOUNT            := :old.EXCLUDE_FREIGHT_FROM_DISCOUNT                 ;
    t_old_rec.TAX_REPORTING_NAME                       := :old.TAX_REPORTING_NAME                            ;
    t_old_rec.CHECK_DIGITS                             := :old.CHECK_DIGITS                                  ;
    t_old_rec.ALLOW_AWT_FLAG                           := :old.ALLOW_AWT_FLAG                                ;
    t_old_rec.AWT_GROUP_ID                             := :old.AWT_GROUP_ID                                  ;
    t_old_rec.VENDOR_NAME_ALT                          := :old.VENDOR_NAME_ALT                               ;
    t_old_rec.AP_TAX_ROUNDING_RULE                     := :old.AP_TAX_ROUNDING_RULE                          ;
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
    t_old_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :old.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_old_rec.BANK_CHARGE_BEARER                       := :old.BANK_CHARGE_BEARER                            ;
    t_old_rec.BANK_BRANCH_TYPE                         := :old.BANK_BRANCH_TYPE                              ;
    t_old_rec.MATCH_OPTION                             := :old.MATCH_OPTION                                  ;
    t_old_rec.CREATE_DEBIT_MEMO_FLAG                   := :old.CREATE_DEBIT_MEMO_FLAG                        ;
    t_old_rec.NI_NUMBER                                := :old.NI_NUMBER                                     ;
    /* Commented by rallamse for Bug#4547059
    t_old_rec.VAT_CODE                                 := :old.VAT_CODE                                      ;
    t_old_rec.PREPAY_CODE_COMBINATION_ID               := :old.PREPAY_CODE_COMBINATION_ID                    ;
    t_old_rec.PAYMENT_METHOD_LOOKUP_CODE               := :old.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_old_rec.OFFSET_TAX_FLAG                          := :old.OFFSET_TAX_FLAG                               ;
    t_old_rec.FUTURE_DATED_PAYMENT_CCID                := :old.FUTURE_DATED_PAYMENT_CCID                     ;
    t_old_rec.EXCLUSIVE_PAYMENT_FLAG                   := :old.EXCLUSIVE_PAYMENT_FLAG                        ;
    t_old_rec.EDI_TRANSACTION_HANDLING                 := :old.EDI_TRANSACTION_HANDLING                      ;
    t_old_rec.EDI_PAYMENT_METHOD                       := :old.EDI_PAYMENT_METHOD                            ;
    t_old_rec.EDI_PAYMENT_FORMAT                       := :old.EDI_PAYMENT_FORMAT                            ;
    t_old_rec.EDI_REMITTANCE_METHOD                    := :old.EDI_REMITTANCE_METHOD                         ;
    t_old_rec.EDI_REMITTANCE_INSTRUCTION               := :old.EDI_REMITTANCE_INSTRUCTION                    ;
    t_old_rec.DISTRIBUTION_SET_ID                      := :old.DISTRIBUTION_SET_ID                           ;
    t_old_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :old.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_old_rec.BANK_ACCOUNT_NAME                        := :old.BANK_ACCOUNT_NAME                             ;
    t_old_rec.BANK_ACCOUNT_NUM                         := :old.BANK_ACCOUNT_NUM                              ;
    t_old_rec.BANK_NUM                                 := :old.BANK_NUM                                      ;
    t_old_rec.BANK_ACCOUNT_TYPE                        := :old.BANK_ACCOUNT_TYPE                             ;
    t_old_rec.SHIP_TO_LOCATION_ID                      := :old.SHIP_TO_LOCATION_ID                           ;
    t_old_rec.BILL_TO_LOCATION_ID                      := :old.BILL_TO_LOCATION_ID                           ;
    t_old_rec.SHIP_VIA_LOOKUP_CODE                     := :old.SHIP_VIA_LOOKUP_CODE                          ;
    t_old_rec.FREIGHT_TERMS_LOOKUP_CODE                := :old.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_old_rec.FOB_LOOKUP_CODE                          := :old.FOB_LOOKUP_CODE                               ;
    t_old_rec.BANK_NUMBER                              := :old.BANK_NUMBER                                   ;
    t_old_rec.AUTO_TAX_CALC_FLAG                       := :old.AUTO_TAX_CALC_FLAG                            ;
    t_old_rec.AUTO_TAX_CALC_OVERRIDE                   := :old.AUTO_TAX_CALC_OVERRIDE                        ;
    t_old_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :old.AMOUNT_INCLUDES_TAX_FLAG                      ;
    */
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_V_ARIUD_T1', p_set_of_books_id => :new.set_of_books_id ) = FALSE THEN
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

  IF UPDATING THEN

    IF ( (:OLD.end_date_active IS NULL AND :NEW.end_date_active IS NOT NULL) OR (:OLD.end_date_active IS NOT NULL AND :NEW.end_date_active IS NULL) ) THEN

      JAI_PO_V_TRIGGER_PKG.ARU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_V_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_V_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_PO_V_ARIUD_T1" DISABLE;
