--------------------------------------------------------
--  DDL for Trigger JAI_PO_VSA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_VSA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AP"."AP_SUPPLIER_SITES_ALL"
FOR EACH ROW
DECLARE
  -- Bug 5141305. Added by Lakshmi Gopalsami
  -- Changed PO_AP_VENDOR_SITES_ALL to AP_SUPPLIER_SITES_ALL
  t_old_rec             AP_SUPPLIER_SITES_ALL%rowtype ;
  t_new_rec             AP_SUPPLIER_SITES_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;


   /*----------------------------------------------------------------------------------------------------------------------
   CHANGE HISTORY:
   S.No    Date          Author and Details

    1.    07-Nov-2005    Ramananda for bug# 4718848. FileVersion 120.1
                         Removed the references of columns LOCATION_ID, PARTY_SITE_ID, SERVICES_TOLERANCE_ID
                         of table PO_AP_VENDOR_SITES_ALL

    2.    19-Dec-2005    Aiyer for the bug 4884010, File version 120.2
                         Removed the reference to po_ap_vendor_sites_all.tolerance_id. Which has been obsoleted.

                         Dependency Due to This bug:-
                         None

    3.    04-Jan-2006    rallamse for Bug#4547059. File version 120.2
                         Issue : Payables is migrating Suppliers information to TCA in R12.
                         As part of R12 activities, some columns of PO_VENDORS and PO_VENDOR_SITES_ALL
                         have been obsoleted.
                         PO_AP_VENDOR_SITES_ALL is a synonym for PO.PO_VENDOR_SITES_ALL
                         Fix :
                         Removed the reference to following columns of table PO_AP_VENDOR_SITES_ALL :
                          AMOUNT_INCLUDES_TAX_FLAG, AP_TAX_ROUNDING_RULE, AUTO_TAX_CALC_FLAG
                          AUTO_TAX_CALC_OVERRIDE, BANK_ACCOUNT_NAME, BANK_ACCOUNT_NUM
                          BANK_ACCOUNT_TYPE, BANK_BRANCH_TYPE, BANK_NUM, BANK_NUMBER
                          EDI_ID_NUMBER, EDI_PAYMENT_FORMAT, EDI_PAYMENT_METHOD
                          EDI_REMITTANCE_INSTRUCTION, EDI_REMITTANCE_METHOD, EDI_TRANSACTION_HANDLING
                          EXCLUSIVE_PAYMENT_FLAG, OFFSET_TAX_FLAG, OFFSET_VAT_CODE, REMITTANCE_EMAIL
                          VAT_CODE, VAT_REGISTRATION_NUM
   -----------------------------------------------------------------------------------------------------------------------*/

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.VENDOR_SITE_CODE                         := :new.VENDOR_SITE_CODE                              ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.PURCHASING_SITE_FLAG                     := :new.PURCHASING_SITE_FLAG                          ;
    t_new_rec.RFQ_ONLY_SITE_FLAG                       := :new.RFQ_ONLY_SITE_FLAG                            ;
    t_new_rec.PAY_SITE_FLAG                            := :new.PAY_SITE_FLAG                                 ;
    t_new_rec.ATTENTION_AR_FLAG                        := :new.ATTENTION_AR_FLAG                             ;
    t_new_rec.ADDRESS_LINE1                            := :new.ADDRESS_LINE1                                 ;
    t_new_rec.ADDRESS_LINE2                            := :new.ADDRESS_LINE2                                 ;
    t_new_rec.ADDRESS_LINE3                            := :new.ADDRESS_LINE3                                 ;
    t_new_rec.CITY                                     := :new.CITY                                          ;
    t_new_rec.STATE                                    := :new.STATE                                         ;
    t_new_rec.ZIP                                      := :new.ZIP                                           ;
    t_new_rec.PROVINCE                                 := :new.PROVINCE                                      ;
    t_new_rec.COUNTRY                                  := :new.COUNTRY                                       ;
    t_new_rec.AREA_CODE                                := :new.AREA_CODE                                     ;
    t_new_rec.PHONE                                    := :new.PHONE                                         ;
    t_new_rec.CUSTOMER_NUM                             := :new.CUSTOMER_NUM                                  ;
    t_new_rec.SHIP_TO_LOCATION_ID                      := :new.SHIP_TO_LOCATION_ID                           ;
    t_new_rec.BILL_TO_LOCATION_ID                      := :new.BILL_TO_LOCATION_ID                           ;
    t_new_rec.SHIP_VIA_LOOKUP_CODE                     := :new.SHIP_VIA_LOOKUP_CODE                          ;
    t_new_rec.FREIGHT_TERMS_LOOKUP_CODE                := :new.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_new_rec.FOB_LOOKUP_CODE                          := :new.FOB_LOOKUP_CODE                               ;
    t_new_rec.INACTIVE_DATE                            := :new.INACTIVE_DATE                                 ;
    t_new_rec.FAX                                      := :new.FAX                                           ;
    t_new_rec.FAX_AREA_CODE                            := :new.FAX_AREA_CODE                                 ;
    t_new_rec.TELEX                                    := :new.TELEX                                         ;
    t_new_rec.PAYMENT_METHOD_LOOKUP_CODE               := :new.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_new_rec.TERMS_DATE_BASIS                         := :new.TERMS_DATE_BASIS                              ;
    t_new_rec.CURRENT_CATALOG_NUM                      := :new.CURRENT_CATALOG_NUM                           ;
    t_new_rec.DISTRIBUTION_SET_ID                      := :new.DISTRIBUTION_SET_ID                           ;
    t_new_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :new.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_new_rec.PREPAY_CODE_COMBINATION_ID               := :new.PREPAY_CODE_COMBINATION_ID                    ;
    t_new_rec.PAY_GROUP_LOOKUP_CODE                    := :new.PAY_GROUP_LOOKUP_CODE                         ;
    t_new_rec.PAYMENT_PRIORITY                         := :new.PAYMENT_PRIORITY                              ;
    t_new_rec.TERMS_ID                                 := :new.TERMS_ID                                      ;
    t_new_rec.INVOICE_AMOUNT_LIMIT                     := :new.INVOICE_AMOUNT_LIMIT                          ;
    t_new_rec.PAY_DATE_BASIS_LOOKUP_CODE               := :new.PAY_DATE_BASIS_LOOKUP_CODE                    ;
    t_new_rec.ALWAYS_TAKE_DISC_FLAG                    := :new.ALWAYS_TAKE_DISC_FLAG                         ;
    t_new_rec.INVOICE_CURRENCY_CODE                    := :new.INVOICE_CURRENCY_CODE                         ;
    t_new_rec.PAYMENT_CURRENCY_CODE                    := :new.PAYMENT_CURRENCY_CODE                         ;
    t_new_rec.HOLD_ALL_PAYMENTS_FLAG                   := :new.HOLD_ALL_PAYMENTS_FLAG                        ;
    t_new_rec.HOLD_FUTURE_PAYMENTS_FLAG                := :new.HOLD_FUTURE_PAYMENTS_FLAG                     ;
    t_new_rec.HOLD_REASON                              := :new.HOLD_REASON                                   ;
    t_new_rec.HOLD_UNMATCHED_INVOICES_FLAG             := :new.HOLD_UNMATCHED_INVOICES_FLAG                  ;
    t_new_rec.TAX_REPORTING_SITE_FLAG                  := :new.TAX_REPORTING_SITE_FLAG                       ;
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
    t_new_rec.VALIDATION_NUMBER                        := :new.VALIDATION_NUMBER                             ;
    t_new_rec.EXCLUDE_FREIGHT_FROM_DISCOUNT            := :new.EXCLUDE_FREIGHT_FROM_DISCOUNT                 ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.CHECK_DIGITS                             := :new.CHECK_DIGITS                                  ;
    t_new_rec.ADDRESS_LINE4                            := :new.ADDRESS_LINE4                                 ;
    t_new_rec.COUNTY                                   := :new.COUNTY                                        ;
    t_new_rec.ADDRESS_STYLE                            := :new.ADDRESS_STYLE                                 ;
    t_new_rec.LANGUAGE                                 := :new.LANGUAGE                                      ;
    t_new_rec.ALLOW_AWT_FLAG                           := :new.ALLOW_AWT_FLAG                                ;
    t_new_rec.AWT_GROUP_ID                             := :new.AWT_GROUP_ID                                  ;
    t_new_rec.VENDOR_SITE_CODE_ALT                     := :new.VENDOR_SITE_CODE_ALT                          ;
    t_new_rec.ADDRESS_LINES_ALT                        := :new.ADDRESS_LINES_ALT                             ;
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
    t_new_rec.PAY_ON_CODE                              := :new.PAY_ON_CODE                                   ;
    t_new_rec.DEFAULT_PAY_SITE_ID                      := :new.DEFAULT_PAY_SITE_ID                           ;
    t_new_rec.PAY_ON_RECEIPT_SUMMARY_CODE              := :new.PAY_ON_RECEIPT_SUMMARY_CODE                   ;
    t_new_rec.TP_HEADER_ID                             := :new.TP_HEADER_ID                                  ;
    t_new_rec.ECE_TP_LOCATION_CODE                     := :new.ECE_TP_LOCATION_CODE                          ;
    t_new_rec.PCARD_SITE_FLAG                          := :new.PCARD_SITE_FLAG                               ;
    t_new_rec.MATCH_OPTION                             := :new.MATCH_OPTION                                  ;
    t_new_rec.COUNTRY_OF_ORIGIN_CODE                   := :new.COUNTRY_OF_ORIGIN_CODE                        ;
    t_new_rec.FUTURE_DATED_PAYMENT_CCID                := :new.FUTURE_DATED_PAYMENT_CCID                     ;
    t_new_rec.CREATE_DEBIT_MEMO_FLAG                   := :new.CREATE_DEBIT_MEMO_FLAG                        ;
    /*  Commented by rallamse for Bug#4547059
    t_new_rec.EXCLUSIVE_PAYMENT_FLAG                   := :new.EXCLUSIVE_PAYMENT_FLAG                        ;
    t_new_rec.BANK_NUMBER                              := :new.BANK_NUMBER                                   ;
    t_new_rec.VAT_REGISTRATION_NUM                     := :new.VAT_REGISTRATION_NUM                          ;
    t_new_rec.OFFSET_VAT_CODE                          := :new.OFFSET_VAT_CODE                               ;
    t_new_rec.OFFSET_TAX_FLAG                          := :new.OFFSET_TAX_FLAG                               ;
    t_new_rec.REMITTANCE_EMAIL                         := :new.REMITTANCE_EMAIL                              ;
    t_new_rec.BANK_BRANCH_TYPE                         := :new.BANK_BRANCH_TYPE                              ;
    t_new_rec.BANK_ACCOUNT_NAME                        := :new.BANK_ACCOUNT_NAME                             ;
    t_new_rec.BANK_ACCOUNT_NUM                         := :new.BANK_ACCOUNT_NUM                              ;
    t_new_rec.BANK_NUM                                 := :new.BANK_NUM                                      ;
    t_new_rec.BANK_ACCOUNT_TYPE                        := :new.BANK_ACCOUNT_TYPE                             ;
    t_new_rec.VAT_CODE                                 := :new.VAT_CODE                                      ;
    t_new_rec.AP_TAX_ROUNDING_RULE                     := :new.AP_TAX_ROUNDING_RULE                          ;
    t_new_rec.AUTO_TAX_CALC_FLAG                       := :new.AUTO_TAX_CALC_FLAG                            ;
    t_new_rec.AUTO_TAX_CALC_OVERRIDE                   := :new.AUTO_TAX_CALC_OVERRIDE                        ;
    t_new_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :new.AMOUNT_INCLUDES_TAX_FLAG                      ;
    t_new_rec.EDI_TRANSACTION_HANDLING                 := :new.EDI_TRANSACTION_HANDLING                      ;
    t_new_rec.EDI_ID_NUMBER                            := :new.EDI_ID_NUMBER                                 ;
    t_new_rec.EDI_PAYMENT_METHOD                       := :new.EDI_PAYMENT_METHOD                            ;
    t_new_rec.EDI_PAYMENT_FORMAT                       := :new.EDI_PAYMENT_FORMAT                            ;
    t_new_rec.EDI_REMITTANCE_METHOD                    := :new.EDI_REMITTANCE_METHOD                         ;
    t_new_rec.EDI_REMITTANCE_INSTRUCTION               := :new.EDI_REMITTANCE_INSTRUCTION                    ;
    */

  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.VENDOR_SITE_CODE                         := :old.VENDOR_SITE_CODE                              ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.PURCHASING_SITE_FLAG                     := :old.PURCHASING_SITE_FLAG                          ;
    t_old_rec.RFQ_ONLY_SITE_FLAG                       := :old.RFQ_ONLY_SITE_FLAG                            ;
    t_old_rec.PAY_SITE_FLAG                            := :old.PAY_SITE_FLAG                                 ;
    t_old_rec.ATTENTION_AR_FLAG                        := :old.ATTENTION_AR_FLAG                             ;
    t_old_rec.ADDRESS_LINE1                            := :old.ADDRESS_LINE1                                 ;
    t_old_rec.ADDRESS_LINE2                            := :old.ADDRESS_LINE2                                 ;
    t_old_rec.ADDRESS_LINE3                            := :old.ADDRESS_LINE3                                 ;
    t_old_rec.CITY                                     := :old.CITY                                          ;
    t_old_rec.STATE                                    := :old.STATE                                         ;
    t_old_rec.ZIP                                      := :old.ZIP                                           ;
    t_old_rec.PROVINCE                                 := :old.PROVINCE                                      ;
    t_old_rec.COUNTRY                                  := :old.COUNTRY                                       ;
    t_old_rec.AREA_CODE                                := :old.AREA_CODE                                     ;
    t_old_rec.PHONE                                    := :old.PHONE                                         ;
    t_old_rec.CUSTOMER_NUM                             := :old.CUSTOMER_NUM                                  ;
    t_old_rec.SHIP_TO_LOCATION_ID                      := :old.SHIP_TO_LOCATION_ID                           ;
    t_old_rec.BILL_TO_LOCATION_ID                      := :old.BILL_TO_LOCATION_ID                           ;
    t_old_rec.SHIP_VIA_LOOKUP_CODE                     := :old.SHIP_VIA_LOOKUP_CODE                          ;
    t_old_rec.FREIGHT_TERMS_LOOKUP_CODE                := :old.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_old_rec.FOB_LOOKUP_CODE                          := :old.FOB_LOOKUP_CODE                               ;
    t_old_rec.INACTIVE_DATE                            := :old.INACTIVE_DATE                                 ;
    t_old_rec.FAX                                      := :old.FAX                                           ;
    t_old_rec.FAX_AREA_CODE                            := :old.FAX_AREA_CODE                                 ;
    t_old_rec.TELEX                                    := :old.TELEX                                         ;
    t_old_rec.PAYMENT_METHOD_LOOKUP_CODE               := :old.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_old_rec.TERMS_DATE_BASIS                         := :old.TERMS_DATE_BASIS                              ;
    t_old_rec.CURRENT_CATALOG_NUM                      := :old.CURRENT_CATALOG_NUM                           ;
    t_old_rec.DISTRIBUTION_SET_ID                      := :old.DISTRIBUTION_SET_ID                           ;
    t_old_rec.ACCTS_PAY_CODE_COMBINATION_ID            := :old.ACCTS_PAY_CODE_COMBINATION_ID                 ;
    t_old_rec.PREPAY_CODE_COMBINATION_ID               := :old.PREPAY_CODE_COMBINATION_ID                    ;
    t_old_rec.PAY_GROUP_LOOKUP_CODE                    := :old.PAY_GROUP_LOOKUP_CODE                         ;
    t_old_rec.PAYMENT_PRIORITY                         := :old.PAYMENT_PRIORITY                              ;
    t_old_rec.TERMS_ID                                 := :old.TERMS_ID                                      ;
    t_old_rec.INVOICE_AMOUNT_LIMIT                     := :old.INVOICE_AMOUNT_LIMIT                          ;
    t_old_rec.PAY_DATE_BASIS_LOOKUP_CODE               := :old.PAY_DATE_BASIS_LOOKUP_CODE                    ;
    t_old_rec.ALWAYS_TAKE_DISC_FLAG                    := :old.ALWAYS_TAKE_DISC_FLAG                         ;
    t_old_rec.INVOICE_CURRENCY_CODE                    := :old.INVOICE_CURRENCY_CODE                         ;
    t_old_rec.PAYMENT_CURRENCY_CODE                    := :old.PAYMENT_CURRENCY_CODE                         ;
    t_old_rec.HOLD_ALL_PAYMENTS_FLAG                   := :old.HOLD_ALL_PAYMENTS_FLAG                        ;
    t_old_rec.HOLD_FUTURE_PAYMENTS_FLAG                := :old.HOLD_FUTURE_PAYMENTS_FLAG                     ;
    t_old_rec.HOLD_REASON                              := :old.HOLD_REASON                                   ;
    t_old_rec.HOLD_UNMATCHED_INVOICES_FLAG             := :old.HOLD_UNMATCHED_INVOICES_FLAG                  ;
    t_old_rec.TAX_REPORTING_SITE_FLAG                  := :old.TAX_REPORTING_SITE_FLAG                       ;
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
    t_old_rec.VALIDATION_NUMBER                        := :old.VALIDATION_NUMBER                             ;
    t_old_rec.EXCLUDE_FREIGHT_FROM_DISCOUNT            := :old.EXCLUDE_FREIGHT_FROM_DISCOUNT                 ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.CHECK_DIGITS                             := :old.CHECK_DIGITS                                  ;
    t_old_rec.ADDRESS_LINE4                            := :old.ADDRESS_LINE4                                 ;
    t_old_rec.COUNTY                                   := :old.COUNTY                                        ;
    t_old_rec.ADDRESS_STYLE                            := :old.ADDRESS_STYLE                                 ;
    t_old_rec.LANGUAGE                                 := :old.LANGUAGE                                      ;
    t_old_rec.ALLOW_AWT_FLAG                           := :old.ALLOW_AWT_FLAG                                ;
    t_old_rec.AWT_GROUP_ID                             := :old.AWT_GROUP_ID                                  ;
    t_old_rec.VENDOR_SITE_CODE_ALT                     := :old.VENDOR_SITE_CODE_ALT                          ;
    t_old_rec.ADDRESS_LINES_ALT                        := :old.ADDRESS_LINES_ALT                             ;
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
    t_old_rec.PAY_ON_CODE                              := :old.PAY_ON_CODE                                   ;
    t_old_rec.DEFAULT_PAY_SITE_ID                      := :old.DEFAULT_PAY_SITE_ID                           ;
    t_old_rec.PAY_ON_RECEIPT_SUMMARY_CODE              := :old.PAY_ON_RECEIPT_SUMMARY_CODE                   ;
    t_old_rec.TP_HEADER_ID                             := :old.TP_HEADER_ID                                  ;
    t_old_rec.ECE_TP_LOCATION_CODE                     := :old.ECE_TP_LOCATION_CODE                          ;
    t_old_rec.PCARD_SITE_FLAG                          := :old.PCARD_SITE_FLAG                               ;
    t_old_rec.MATCH_OPTION                             := :old.MATCH_OPTION                                  ;
    t_old_rec.COUNTRY_OF_ORIGIN_CODE                   := :old.COUNTRY_OF_ORIGIN_CODE                        ;
    t_old_rec.FUTURE_DATED_PAYMENT_CCID                := :old.FUTURE_DATED_PAYMENT_CCID                     ;
    t_old_rec.CREATE_DEBIT_MEMO_FLAG                   := :old.CREATE_DEBIT_MEMO_FLAG                        ;
    /*   Commented by rallamse for Bug#4547059
    t_old_rec.EXCLUSIVE_PAYMENT_FLAG                   := :old.EXCLUSIVE_PAYMENT_FLAG                        ;
    t_old_rec.BANK_NUMBER                              := :old.BANK_NUMBER                                   ;
    t_old_rec.VAT_REGISTRATION_NUM                     := :old.VAT_REGISTRATION_NUM                          ;
    t_old_rec.OFFSET_VAT_CODE                          := :old.OFFSET_VAT_CODE                               ;
    t_old_rec.REMITTANCE_EMAIL                         := :old.REMITTANCE_EMAIL                              ;
    t_old_rec.OFFSET_TAX_FLAG                          := :old.OFFSET_TAX_FLAG                               ;
    t_old_rec.BANK_BRANCH_TYPE                         := :old.BANK_BRANCH_TYPE                              ;
    t_old_rec.BANK_ACCOUNT_NAME                        := :old.BANK_ACCOUNT_NAME                             ;
    t_old_rec.BANK_ACCOUNT_NUM                         := :old.BANK_ACCOUNT_NUM                              ;
    t_old_rec.BANK_NUM                                 := :old.BANK_NUM                                      ;
    t_old_rec.BANK_ACCOUNT_TYPE                        := :old.BANK_ACCOUNT_TYPE                             ;
    t_old_rec.VAT_CODE                                 := :old.VAT_CODE                                      ;
    t_old_rec.AP_TAX_ROUNDING_RULE                     := :old.AP_TAX_ROUNDING_RULE                          ;
    t_old_rec.AUTO_TAX_CALC_FLAG                       := :old.AUTO_TAX_CALC_FLAG                            ;
    t_old_rec.AUTO_TAX_CALC_OVERRIDE                   := :old.AUTO_TAX_CALC_OVERRIDE                        ;
    t_old_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :old.AMOUNT_INCLUDES_TAX_FLAG                      ;
    t_old_rec.EDI_TRANSACTION_HANDLING                 := :old.EDI_TRANSACTION_HANDLING                      ;
    t_old_rec.EDI_ID_NUMBER                            := :old.EDI_ID_NUMBER                                 ;
    t_old_rec.EDI_PAYMENT_METHOD                       := :old.EDI_PAYMENT_METHOD                            ;
    t_old_rec.EDI_PAYMENT_FORMAT                       := :old.EDI_PAYMENT_FORMAT                            ;
    t_old_rec.EDI_REMITTANCE_METHOD                    := :old.EDI_REMITTANCE_METHOD                         ;
    t_old_rec.EDI_REMITTANCE_INSTRUCTION               := :old.EDI_REMITTANCE_INSTRUCTION                    ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_VSA_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

    IF ( ( :OLD.inactive_date IS NULL AND :NEW.inactive_date IS NOT NULL) OR (:OLD.inactive_date IS NOT NULL AND :NEW.inactive_date IS NULL ) ) THEN

      JAI_PO_VSA_TRIGGER_PKG.ARU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_VSA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_VSA_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_PO_VSA_ARIUD_T1" DISABLE;
