--------------------------------------------------------
--  DDL for Trigger JAI_AR_RC_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AR_RC_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AR"."HZ_CUST_ACCOUNTS"
FOR EACH ROW
DECLARE
  t_old_rec             HZ_CUST_ACCOUNTS%rowtype ;
  t_new_rec             HZ_CUST_ACCOUNTS%rowtype ;
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

    t_new_rec.CUST_ACCOUNT_ID                          := :new.CUST_ACCOUNT_ID                               ;
    t_new_rec.PARTY_ID                                 := :new.PARTY_ID                                      ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.ACCOUNT_NUMBER                           := :new.ACCOUNT_NUMBER                                ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.WH_UPDATE_DATE                           := :new.WH_UPDATE_DATE                                ;
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
    t_new_rec.ATTRIBUTE16                              := :new.ATTRIBUTE16                                   ;
    t_new_rec.ATTRIBUTE17                              := :new.ATTRIBUTE17                                   ;
    t_new_rec.ATTRIBUTE18                              := :new.ATTRIBUTE18                                   ;
    t_new_rec.ATTRIBUTE19                              := :new.ATTRIBUTE19                                   ;
    t_new_rec.ATTRIBUTE20                              := :new.ATTRIBUTE20                                   ;
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
    t_new_rec.ORIG_SYSTEM_REFERENCE                    := :new.ORIG_SYSTEM_REFERENCE                         ;
    t_new_rec.STATUS                                   := :new.STATUS                                        ;
    t_new_rec.CUSTOMER_TYPE                            := :new.CUSTOMER_TYPE                                 ;
    t_new_rec.CUSTOMER_CLASS_CODE                      := :new.CUSTOMER_CLASS_CODE                           ;
    t_new_rec.SALES_CHANNEL_CODE                       := :new.SALES_CHANNEL_CODE                            ;
    t_new_rec.ORDER_TYPE_ID                            := :new.ORDER_TYPE_ID                                 ;
    t_new_rec.PRICE_LIST_ID                            := :new.PRICE_LIST_ID                                 ;
    t_new_rec.SUBCATEGORY_CODE                         := :new.SUBCATEGORY_CODE                              ;
    t_new_rec.TAX_CODE                                 := :new.TAX_CODE                                      ;
    t_new_rec.FOB_POINT                                := :new.FOB_POINT                                     ;
    t_new_rec.FREIGHT_TERM                             := :new.FREIGHT_TERM                                  ;
    t_new_rec.SHIP_PARTIAL                             := :new.SHIP_PARTIAL                                  ;
    t_new_rec.SHIP_VIA                                 := :new.SHIP_VIA                                      ;
    t_new_rec.WAREHOUSE_ID                             := :new.WAREHOUSE_ID                                  ;
    t_new_rec.PAYMENT_TERM_ID                          := :new.PAYMENT_TERM_ID                               ;
    t_new_rec.TAX_HEADER_LEVEL_FLAG                    := :new.TAX_HEADER_LEVEL_FLAG                         ;
    t_new_rec.TAX_ROUNDING_RULE                        := :new.TAX_ROUNDING_RULE                             ;
    t_new_rec.COTERMINATE_DAY_MONTH                    := :new.COTERMINATE_DAY_MONTH                         ;
    t_new_rec.PRIMARY_SPECIALIST_ID                    := :new.PRIMARY_SPECIALIST_ID                         ;
    t_new_rec.SECONDARY_SPECIALIST_ID                  := :new.SECONDARY_SPECIALIST_ID                       ;
    t_new_rec.ACCOUNT_LIABLE_FLAG                      := :new.ACCOUNT_LIABLE_FLAG                           ;
    t_new_rec.RESTRICTION_LIMIT_AMOUNT                 := :new.RESTRICTION_LIMIT_AMOUNT                      ;
    t_new_rec.CURRENT_BALANCE                          := :new.CURRENT_BALANCE                               ;
    t_new_rec.PASSWORD_TEXT                            := :new.PASSWORD_TEXT                                 ;
    t_new_rec.HIGH_PRIORITY_INDICATOR                  := :new.HIGH_PRIORITY_INDICATOR                       ;
    t_new_rec.ACCOUNT_ESTABLISHED_DATE                 := :new.ACCOUNT_ESTABLISHED_DATE                      ;
    t_new_rec.ACCOUNT_TERMINATION_DATE                 := :new.ACCOUNT_TERMINATION_DATE                      ;
    t_new_rec.ACCOUNT_ACTIVATION_DATE                  := :new.ACCOUNT_ACTIVATION_DATE                       ;
    t_new_rec.CREDIT_CLASSIFICATION_CODE               := :new.CREDIT_CLASSIFICATION_CODE                    ;
    t_new_rec.DEPARTMENT                               := :new.DEPARTMENT                                    ;
    t_new_rec.MAJOR_ACCOUNT_NUMBER                     := :new.MAJOR_ACCOUNT_NUMBER                          ;
    t_new_rec.HOTWATCH_SERVICE_FLAG                    := :new.HOTWATCH_SERVICE_FLAG                         ;
    t_new_rec.HOTWATCH_SVC_BAL_IND                     := :new.HOTWATCH_SVC_BAL_IND                          ;
    t_new_rec.HELD_BILL_EXPIRATION_DATE                := :new.HELD_BILL_EXPIRATION_DATE                     ;
    t_new_rec.HOLD_BILL_FLAG                           := :new.HOLD_BILL_FLAG                                ;
    t_new_rec.HIGH_PRIORITY_REMARKS                    := :new.HIGH_PRIORITY_REMARKS                         ;
    t_new_rec.PO_EFFECTIVE_DATE                        := :new.PO_EFFECTIVE_DATE                             ;
    t_new_rec.PO_EXPIRATION_DATE                       := :new.PO_EXPIRATION_DATE                            ;
    t_new_rec.REALTIME_RATE_FLAG                       := :new.REALTIME_RATE_FLAG                            ;
    t_new_rec.SINGLE_USER_FLAG                         := :new.SINGLE_USER_FLAG                              ;
    t_new_rec.WATCH_ACCOUNT_FLAG                       := :new.WATCH_ACCOUNT_FLAG                            ;
    t_new_rec.WATCH_BALANCE_INDICATOR                  := :new.WATCH_BALANCE_INDICATOR                       ;
    t_new_rec.GEO_CODE                                 := :new.GEO_CODE                                      ;
    t_new_rec.ACCT_LIFE_CYCLE_STATUS                   := :new.ACCT_LIFE_CYCLE_STATUS                        ;
    t_new_rec.ACCOUNT_NAME                             := :new.ACCOUNT_NAME                                  ;
    t_new_rec.DEPOSIT_REFUND_METHOD                    := :new.DEPOSIT_REFUND_METHOD                         ;
    t_new_rec.DORMANT_ACCOUNT_FLAG                     := :new.DORMANT_ACCOUNT_FLAG                          ;
    t_new_rec.NPA_NUMBER                               := :new.NPA_NUMBER                                    ;
    t_new_rec.PIN_NUMBER                               := :new.PIN_NUMBER                                    ;
    t_new_rec.SUSPENSION_DATE                          := :new.SUSPENSION_DATE                               ;
    t_new_rec.WRITE_OFF_ADJUSTMENT_AMOUNT              := :new.WRITE_OFF_ADJUSTMENT_AMOUNT                   ;
    t_new_rec.WRITE_OFF_PAYMENT_AMOUNT                 := :new.WRITE_OFF_PAYMENT_AMOUNT                      ;
    t_new_rec.WRITE_OFF_AMOUNT                         := :new.WRITE_OFF_AMOUNT                              ;
    t_new_rec.SOURCE_CODE                              := :new.SOURCE_CODE                                   ;
    t_new_rec.COMPETITOR_TYPE                          := :new.COMPETITOR_TYPE                               ;
    t_new_rec.COMMENTS                                 := :new.COMMENTS                                      ;
    t_new_rec.DATES_NEGATIVE_TOLERANCE                 := :new.DATES_NEGATIVE_TOLERANCE                      ;
    t_new_rec.DATES_POSITIVE_TOLERANCE                 := :new.DATES_POSITIVE_TOLERANCE                      ;
    t_new_rec.DATE_TYPE_PREFERENCE                     := :new.DATE_TYPE_PREFERENCE                          ;
    t_new_rec.OVER_SHIPMENT_TOLERANCE                  := :new.OVER_SHIPMENT_TOLERANCE                       ;
    t_new_rec.UNDER_SHIPMENT_TOLERANCE                 := :new.UNDER_SHIPMENT_TOLERANCE                      ;
    t_new_rec.OVER_RETURN_TOLERANCE                    := :new.OVER_RETURN_TOLERANCE                         ;
    t_new_rec.UNDER_RETURN_TOLERANCE                   := :new.UNDER_RETURN_TOLERANCE                        ;
    t_new_rec.ITEM_CROSS_REF_PREF                      := :new.ITEM_CROSS_REF_PREF                           ;
    t_new_rec.SHIP_SETS_INCLUDE_LINES_FLAG             := :new.SHIP_SETS_INCLUDE_LINES_FLAG                  ;
    t_new_rec.ARRIVALSETS_INCLUDE_LINES_FLAG           := :new.ARRIVALSETS_INCLUDE_LINES_FLAG                ;
    t_new_rec.SCHED_DATE_PUSH_FLAG                     := :new.SCHED_DATE_PUSH_FLAG                          ;
    t_new_rec.INVOICE_QUANTITY_RULE                    := :new.INVOICE_QUANTITY_RULE                         ;
    t_new_rec.PRICING_EVENT                            := :new.PRICING_EVENT                                 ;
    t_new_rec.ACCOUNT_REPLICATION_KEY                  := :new.ACCOUNT_REPLICATION_KEY                       ;
    t_new_rec.STATUS_UPDATE_DATE                       := :new.STATUS_UPDATE_DATE                            ;
    t_new_rec.AUTOPAY_FLAG                             := :new.AUTOPAY_FLAG                                  ;
    t_new_rec.NOTIFY_FLAG                              := :new.NOTIFY_FLAG                                   ;
    t_new_rec.LAST_BATCH_ID                            := :new.LAST_BATCH_ID                                 ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
    t_new_rec.CREATED_BY_MODULE                        := :new.CREATED_BY_MODULE                             ;
    t_new_rec.APPLICATION_ID                           := :new.APPLICATION_ID                                ;
    t_new_rec.SELLING_PARTY_ID                         := :new.SELLING_PARTY_ID                              ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.CUST_ACCOUNT_ID                          := :old.CUST_ACCOUNT_ID                               ;
    t_old_rec.PARTY_ID                                 := :old.PARTY_ID                                      ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.ACCOUNT_NUMBER                           := :old.ACCOUNT_NUMBER                                ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.WH_UPDATE_DATE                           := :old.WH_UPDATE_DATE                                ;
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
    t_old_rec.ATTRIBUTE16                              := :old.ATTRIBUTE16                                   ;
    t_old_rec.ATTRIBUTE17                              := :old.ATTRIBUTE17                                   ;
    t_old_rec.ATTRIBUTE18                              := :old.ATTRIBUTE18                                   ;
    t_old_rec.ATTRIBUTE19                              := :old.ATTRIBUTE19                                   ;
    t_old_rec.ATTRIBUTE20                              := :old.ATTRIBUTE20                                   ;
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
    t_old_rec.ORIG_SYSTEM_REFERENCE                    := :old.ORIG_SYSTEM_REFERENCE                         ;
    t_old_rec.STATUS                                   := :old.STATUS                                        ;
    t_old_rec.CUSTOMER_TYPE                            := :old.CUSTOMER_TYPE                                 ;
    t_old_rec.CUSTOMER_CLASS_CODE                      := :old.CUSTOMER_CLASS_CODE                           ;
    t_old_rec.SALES_CHANNEL_CODE                       := :old.SALES_CHANNEL_CODE                            ;
    t_old_rec.ORDER_TYPE_ID                            := :old.ORDER_TYPE_ID                                 ;
    t_old_rec.PRICE_LIST_ID                            := :old.PRICE_LIST_ID                                 ;
    t_old_rec.SUBCATEGORY_CODE                         := :old.SUBCATEGORY_CODE                              ;
    t_old_rec.TAX_CODE                                 := :old.TAX_CODE                                      ;
    t_old_rec.FOB_POINT                                := :old.FOB_POINT                                     ;
    t_old_rec.FREIGHT_TERM                             := :old.FREIGHT_TERM                                  ;
    t_old_rec.SHIP_PARTIAL                             := :old.SHIP_PARTIAL                                  ;
    t_old_rec.SHIP_VIA                                 := :old.SHIP_VIA                                      ;
    t_old_rec.WAREHOUSE_ID                             := :old.WAREHOUSE_ID                                  ;
    t_old_rec.PAYMENT_TERM_ID                          := :old.PAYMENT_TERM_ID                               ;
    t_old_rec.TAX_HEADER_LEVEL_FLAG                    := :old.TAX_HEADER_LEVEL_FLAG                         ;
    t_old_rec.TAX_ROUNDING_RULE                        := :old.TAX_ROUNDING_RULE                             ;
    t_old_rec.COTERMINATE_DAY_MONTH                    := :old.COTERMINATE_DAY_MONTH                         ;
    t_old_rec.PRIMARY_SPECIALIST_ID                    := :old.PRIMARY_SPECIALIST_ID                         ;
    t_old_rec.SECONDARY_SPECIALIST_ID                  := :old.SECONDARY_SPECIALIST_ID                       ;
    t_old_rec.ACCOUNT_LIABLE_FLAG                      := :old.ACCOUNT_LIABLE_FLAG                           ;
    t_old_rec.RESTRICTION_LIMIT_AMOUNT                 := :old.RESTRICTION_LIMIT_AMOUNT                      ;
    t_old_rec.CURRENT_BALANCE                          := :old.CURRENT_BALANCE                               ;
    t_old_rec.PASSWORD_TEXT                            := :old.PASSWORD_TEXT                                 ;
    t_old_rec.HIGH_PRIORITY_INDICATOR                  := :old.HIGH_PRIORITY_INDICATOR                       ;
    t_old_rec.ACCOUNT_ESTABLISHED_DATE                 := :old.ACCOUNT_ESTABLISHED_DATE                      ;
    t_old_rec.ACCOUNT_TERMINATION_DATE                 := :old.ACCOUNT_TERMINATION_DATE                      ;
    t_old_rec.ACCOUNT_ACTIVATION_DATE                  := :old.ACCOUNT_ACTIVATION_DATE                       ;
    t_old_rec.CREDIT_CLASSIFICATION_CODE               := :old.CREDIT_CLASSIFICATION_CODE                    ;
    t_old_rec.DEPARTMENT                               := :old.DEPARTMENT                                    ;
    t_old_rec.MAJOR_ACCOUNT_NUMBER                     := :old.MAJOR_ACCOUNT_NUMBER                          ;
    t_old_rec.HOTWATCH_SERVICE_FLAG                    := :old.HOTWATCH_SERVICE_FLAG                         ;
    t_old_rec.HOTWATCH_SVC_BAL_IND                     := :old.HOTWATCH_SVC_BAL_IND                          ;
    t_old_rec.HELD_BILL_EXPIRATION_DATE                := :old.HELD_BILL_EXPIRATION_DATE                     ;
    t_old_rec.HOLD_BILL_FLAG                           := :old.HOLD_BILL_FLAG                                ;
    t_old_rec.HIGH_PRIORITY_REMARKS                    := :old.HIGH_PRIORITY_REMARKS                         ;
    t_old_rec.PO_EFFECTIVE_DATE                        := :old.PO_EFFECTIVE_DATE                             ;
    t_old_rec.PO_EXPIRATION_DATE                       := :old.PO_EXPIRATION_DATE                            ;
    t_old_rec.REALTIME_RATE_FLAG                       := :old.REALTIME_RATE_FLAG                            ;
    t_old_rec.SINGLE_USER_FLAG                         := :old.SINGLE_USER_FLAG                              ;
    t_old_rec.WATCH_ACCOUNT_FLAG                       := :old.WATCH_ACCOUNT_FLAG                            ;
    t_old_rec.WATCH_BALANCE_INDICATOR                  := :old.WATCH_BALANCE_INDICATOR                       ;
    t_old_rec.GEO_CODE                                 := :old.GEO_CODE                                      ;
    t_old_rec.ACCT_LIFE_CYCLE_STATUS                   := :old.ACCT_LIFE_CYCLE_STATUS                        ;
    t_old_rec.ACCOUNT_NAME                             := :old.ACCOUNT_NAME                                  ;
    t_old_rec.DEPOSIT_REFUND_METHOD                    := :old.DEPOSIT_REFUND_METHOD                         ;
    t_old_rec.DORMANT_ACCOUNT_FLAG                     := :old.DORMANT_ACCOUNT_FLAG                          ;
    t_old_rec.NPA_NUMBER                               := :old.NPA_NUMBER                                    ;
    t_old_rec.PIN_NUMBER                               := :old.PIN_NUMBER                                    ;
    t_old_rec.SUSPENSION_DATE                          := :old.SUSPENSION_DATE                               ;
    t_old_rec.WRITE_OFF_ADJUSTMENT_AMOUNT              := :old.WRITE_OFF_ADJUSTMENT_AMOUNT                   ;
    t_old_rec.WRITE_OFF_PAYMENT_AMOUNT                 := :old.WRITE_OFF_PAYMENT_AMOUNT                      ;
    t_old_rec.WRITE_OFF_AMOUNT                         := :old.WRITE_OFF_AMOUNT                              ;
    t_old_rec.SOURCE_CODE                              := :old.SOURCE_CODE                                   ;
    t_old_rec.COMPETITOR_TYPE                          := :old.COMPETITOR_TYPE                               ;
    t_old_rec.COMMENTS                                 := :old.COMMENTS                                      ;
    t_old_rec.DATES_NEGATIVE_TOLERANCE                 := :old.DATES_NEGATIVE_TOLERANCE                      ;
    t_old_rec.DATES_POSITIVE_TOLERANCE                 := :old.DATES_POSITIVE_TOLERANCE                      ;
    t_old_rec.DATE_TYPE_PREFERENCE                     := :old.DATE_TYPE_PREFERENCE                          ;
    t_old_rec.OVER_SHIPMENT_TOLERANCE                  := :old.OVER_SHIPMENT_TOLERANCE                       ;
    t_old_rec.UNDER_SHIPMENT_TOLERANCE                 := :old.UNDER_SHIPMENT_TOLERANCE                      ;
    t_old_rec.OVER_RETURN_TOLERANCE                    := :old.OVER_RETURN_TOLERANCE                         ;
    t_old_rec.UNDER_RETURN_TOLERANCE                   := :old.UNDER_RETURN_TOLERANCE                        ;
    t_old_rec.ITEM_CROSS_REF_PREF                      := :old.ITEM_CROSS_REF_PREF                           ;
    t_old_rec.SHIP_SETS_INCLUDE_LINES_FLAG             := :old.SHIP_SETS_INCLUDE_LINES_FLAG                  ;
    t_old_rec.ARRIVALSETS_INCLUDE_LINES_FLAG           := :old.ARRIVALSETS_INCLUDE_LINES_FLAG                ;
    t_old_rec.SCHED_DATE_PUSH_FLAG                     := :old.SCHED_DATE_PUSH_FLAG                          ;
    t_old_rec.INVOICE_QUANTITY_RULE                    := :old.INVOICE_QUANTITY_RULE                         ;
    t_old_rec.PRICING_EVENT                            := :old.PRICING_EVENT                                 ;
    t_old_rec.ACCOUNT_REPLICATION_KEY                  := :old.ACCOUNT_REPLICATION_KEY                       ;
    t_old_rec.STATUS_UPDATE_DATE                       := :old.STATUS_UPDATE_DATE                            ;
    t_old_rec.AUTOPAY_FLAG                             := :old.AUTOPAY_FLAG                                  ;
    t_old_rec.NOTIFY_FLAG                              := :old.NOTIFY_FLAG                                   ;
    t_old_rec.LAST_BATCH_ID                            := :old.LAST_BATCH_ID                                 ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
    t_old_rec.CREATED_BY_MODULE                        := :old.CREATED_BY_MODULE                             ;
    t_old_rec.APPLICATION_ID                           := :old.APPLICATION_ID                                ;
    t_old_rec.SELLING_PARTY_ID                         := :old.SELLING_PARTY_ID                              ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AR_RC_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

  IF DELETING THEN

      JAI_AR_HCA_TRIGGER_PKG.ARD_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AR_RC_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AR_RC_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_AR_RC_ARIUD_T1" DISABLE;
