--------------------------------------------------------
--  DDL for Trigger JAI_PO_LA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_LA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."PO_LINES_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             PO_LINES_ALL%rowtype ;
  t_new_rec             PO_LINES_ALL%rowtype ;
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

    t_new_rec.PO_LINE_ID                               := :new.PO_LINE_ID                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.LINE_TYPE_ID                             := :new.LINE_TYPE_ID                                  ;
    t_new_rec.LINE_NUM                                 := :new.LINE_NUM                                      ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.ITEM_ID                                  := :new.ITEM_ID                                       ;
    t_new_rec.ITEM_REVISION                            := :new.ITEM_REVISION                                 ;
    t_new_rec.CATEGORY_ID                              := :new.CATEGORY_ID                                   ;
    t_new_rec.ITEM_DESCRIPTION                         := :new.ITEM_DESCRIPTION                              ;
    t_new_rec.UNIT_MEAS_LOOKUP_CODE                    := :new.UNIT_MEAS_LOOKUP_CODE                         ;
    t_new_rec.QUANTITY_COMMITTED                       := :new.QUANTITY_COMMITTED                            ;
    t_new_rec.COMMITTED_AMOUNT                         := :new.COMMITTED_AMOUNT                              ;
    t_new_rec.ALLOW_PRICE_OVERRIDE_FLAG                := :new.ALLOW_PRICE_OVERRIDE_FLAG                     ;
    t_new_rec.NOT_TO_EXCEED_PRICE                      := :new.NOT_TO_EXCEED_PRICE                           ;
    t_new_rec.LIST_PRICE_PER_UNIT                      := :new.LIST_PRICE_PER_UNIT                           ;
    t_new_rec.UNIT_PRICE                               := :new.UNIT_PRICE                                    ;
    t_new_rec.QUANTITY                                 := :new.QUANTITY                                      ;
    t_new_rec.UN_NUMBER_ID                             := :new.UN_NUMBER_ID                                  ;
    t_new_rec.HAZARD_CLASS_ID                          := :new.HAZARD_CLASS_ID                               ;
    t_new_rec.NOTE_TO_VENDOR                           := :new.NOTE_TO_VENDOR                                ;
    t_new_rec.FROM_HEADER_ID                           := :new.FROM_HEADER_ID                                ;
    t_new_rec.FROM_LINE_ID                             := :new.FROM_LINE_ID                                  ;
    t_new_rec.MIN_ORDER_QUANTITY                       := :new.MIN_ORDER_QUANTITY                            ;
    t_new_rec.MAX_ORDER_QUANTITY                       := :new.MAX_ORDER_QUANTITY                            ;
    t_new_rec.QTY_RCV_TOLERANCE                        := :new.QTY_RCV_TOLERANCE                             ;
    t_new_rec.OVER_TOLERANCE_ERROR_FLAG                := :new.OVER_TOLERANCE_ERROR_FLAG                     ;
    t_new_rec.MARKET_PRICE                             := :new.MARKET_PRICE                                  ;
    t_new_rec.UNORDERED_FLAG                           := :new.UNORDERED_FLAG                                ;
    t_new_rec.CLOSED_FLAG                              := :new.CLOSED_FLAG                                   ;
    t_new_rec.USER_HOLD_FLAG                           := :new.USER_HOLD_FLAG                                ;
    t_new_rec.CANCEL_FLAG                              := :new.CANCEL_FLAG                                   ;
    t_new_rec.CANCELLED_BY                             := :new.CANCELLED_BY                                  ;
    t_new_rec.CANCEL_DATE                              := :new.CANCEL_DATE                                   ;
    t_new_rec.CANCEL_REASON                            := :new.CANCEL_REASON                                 ;
    t_new_rec.FIRM_STATUS_LOOKUP_CODE                  := :new.FIRM_STATUS_LOOKUP_CODE                       ;
    t_new_rec.FIRM_DATE                                := :new.FIRM_DATE                                     ;
    t_new_rec.VENDOR_PRODUCT_NUM                       := :new.VENDOR_PRODUCT_NUM                            ;
    t_new_rec.CONTRACT_NUM                             := :new.CONTRACT_NUM                                  ;
    t_new_rec.TAXABLE_FLAG                             := :new.TAXABLE_FLAG                                  ;
    t_new_rec.TAX_NAME                                 := :new.TAX_NAME                                      ;
    t_new_rec.TYPE_1099                                := :new.TYPE_1099                                     ;
    t_new_rec.CAPITAL_EXPENSE_FLAG                     := :new.CAPITAL_EXPENSE_FLAG                          ;
    t_new_rec.NEGOTIATED_BY_PREPARER_FLAG              := :new.NEGOTIATED_BY_PREPARER_FLAG                   ;
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
    t_new_rec.REFERENCE_NUM                            := :new.REFERENCE_NUM                                 ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.MIN_RELEASE_AMOUNT                       := :new.MIN_RELEASE_AMOUNT                            ;
    t_new_rec.PRICE_TYPE_LOOKUP_CODE                   := :new.PRICE_TYPE_LOOKUP_CODE                        ;
    t_new_rec.CLOSED_CODE                              := :new.CLOSED_CODE                                   ;
    t_new_rec.PRICE_BREAK_LOOKUP_CODE                  := :new.PRICE_BREAK_LOOKUP_CODE                       ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.GOVERNMENT_CONTEXT                       := :new.GOVERNMENT_CONTEXT                            ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.CLOSED_DATE                              := :new.CLOSED_DATE                                   ;
    t_new_rec.CLOSED_REASON                            := :new.CLOSED_REASON                                 ;
    t_new_rec.CLOSED_BY                                := :new.CLOSED_BY                                     ;
    t_new_rec.TRANSACTION_REASON_CODE                  := :new.TRANSACTION_REASON_CODE                       ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.QC_GRADE                                 := :new.QC_GRADE                                      ;
    t_new_rec.BASE_UOM                                 := :new.BASE_UOM                                      ;
    t_new_rec.BASE_QTY                                 := :new.BASE_QTY                                      ;
    t_new_rec.SECONDARY_UOM                            := :new.SECONDARY_UOM                                 ;
    t_new_rec.SECONDARY_QTY                            := :new.SECONDARY_QTY                                 ;
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
    t_new_rec.LINE_REFERENCE_NUM                       := :new.LINE_REFERENCE_NUM                            ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
    t_new_rec.EXPIRATION_DATE                          := :new.EXPIRATION_DATE                               ;
    t_new_rec.TAX_CODE_ID                              := :new.TAX_CODE_ID                                   ;
    t_new_rec.OKE_CONTRACT_HEADER_ID                   := :new.OKE_CONTRACT_HEADER_ID                        ;
    t_new_rec.OKE_CONTRACT_VERSION_ID                  := :new.OKE_CONTRACT_VERSION_ID                       ;
    t_new_rec.SECONDARY_QUANTITY                       := :new.SECONDARY_QUANTITY                            ;
    t_new_rec.SECONDARY_UNIT_OF_MEASURE                := :new.SECONDARY_UNIT_OF_MEASURE                     ;
    t_new_rec.PREFERRED_GRADE                          := :new.PREFERRED_GRADE                               ;
    t_new_rec.AUCTION_HEADER_ID                        := :new.AUCTION_HEADER_ID                             ;
    t_new_rec.AUCTION_DISPLAY_NUMBER                   := :new.AUCTION_DISPLAY_NUMBER                        ;
    t_new_rec.AUCTION_LINE_NUMBER                      := :new.AUCTION_LINE_NUMBER                           ;
    t_new_rec.BID_NUMBER                               := :new.BID_NUMBER                                    ;
    t_new_rec.BID_LINE_NUMBER                          := :new.BID_LINE_NUMBER                               ;
    t_new_rec.RETROACTIVE_DATE                         := :new.RETROACTIVE_DATE                              ;
    t_new_rec.SUPPLIER_REF_NUMBER                      := :new.SUPPLIER_REF_NUMBER                           ;
    t_new_rec.CONTRACT_ID                              := :new.CONTRACT_ID                                   ;
    t_new_rec.START_DATE                               := :new.START_DATE                                    ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.JOB_ID                                   := :new.JOB_ID                                        ;
    t_new_rec.CONTRACTOR_FIRST_NAME                    := :new.CONTRACTOR_FIRST_NAME                         ;
    t_new_rec.CONTRACTOR_LAST_NAME                     := :new.CONTRACTOR_LAST_NAME                          ;
    t_new_rec.FROM_LINE_LOCATION_ID                    := :new.FROM_LINE_LOCATION_ID                         ;
    t_new_rec.ORDER_TYPE_LOOKUP_CODE                   := :new.ORDER_TYPE_LOOKUP_CODE                        ;
    t_new_rec.PURCHASE_BASIS                           := :new.PURCHASE_BASIS                                ;
    t_new_rec.MATCHING_BASIS                           := :new.MATCHING_BASIS                                ;
    t_new_rec.SVC_AMOUNT_NOTIF_SENT                    := :new.SVC_AMOUNT_NOTIF_SENT                         ;
    t_new_rec.SVC_COMPLETION_NOTIF_SENT                := :new.SVC_COMPLETION_NOTIF_SENT                     ;
    t_new_rec.BASE_UNIT_PRICE                          := :new.BASE_UNIT_PRICE                               ;
    t_new_rec.MANUAL_PRICE_CHANGE_FLAG                 := :new.MANUAL_PRICE_CHANGE_FLAG                      ;
    t_new_rec.CATALOG_NAME                             := :new.CATALOG_NAME                                  ;
    t_new_rec.SUPPLIER_PART_AUXID                      := :new.SUPPLIER_PART_AUXID                           ;
    t_new_rec.IP_CATEGORY_ID                           := :new.IP_CATEGORY_ID                                ;
    /*
    t_new_rec.LAST_UPDATED_PROGRAM                     := :new.LAST_UPDATED_PROGRAM                          ;
    commented bu ssumaith - bug#4616729
    */
    t_new_rec.RETAINAGE_RATE                           := :new.RETAINAGE_RATE                                ;
    t_new_rec.MAX_RETAINAGE_AMOUNT                     := :new.MAX_RETAINAGE_AMOUNT                          ;
    t_new_rec.PROGRESS_PAYMENT_RATE                    := :new.PROGRESS_PAYMENT_RATE                         ;
    t_new_rec.RECOUPMENT_RATE                          := :new.RECOUPMENT_RATE                               ;
    t_new_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :new.TAX_ATTRIBUTE_UPDATE_CODE                     ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.PO_LINE_ID                               := :old.PO_LINE_ID                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.LINE_TYPE_ID                             := :old.LINE_TYPE_ID                                  ;
    t_old_rec.LINE_NUM                                 := :old.LINE_NUM                                      ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.ITEM_ID                                  := :old.ITEM_ID                                       ;
    t_old_rec.ITEM_REVISION                            := :old.ITEM_REVISION                                 ;
    t_old_rec.CATEGORY_ID                              := :old.CATEGORY_ID                                   ;
    t_old_rec.ITEM_DESCRIPTION                         := :old.ITEM_DESCRIPTION                              ;
    t_old_rec.UNIT_MEAS_LOOKUP_CODE                    := :old.UNIT_MEAS_LOOKUP_CODE                         ;
    t_old_rec.QUANTITY_COMMITTED                       := :old.QUANTITY_COMMITTED                            ;
    t_old_rec.COMMITTED_AMOUNT                         := :old.COMMITTED_AMOUNT                              ;
    t_old_rec.ALLOW_PRICE_OVERRIDE_FLAG                := :old.ALLOW_PRICE_OVERRIDE_FLAG                     ;
    t_old_rec.NOT_TO_EXCEED_PRICE                      := :old.NOT_TO_EXCEED_PRICE                           ;
    t_old_rec.LIST_PRICE_PER_UNIT                      := :old.LIST_PRICE_PER_UNIT                           ;
    t_old_rec.UNIT_PRICE                               := :old.UNIT_PRICE                                    ;
    t_old_rec.QUANTITY                                 := :old.QUANTITY                                      ;
    t_old_rec.UN_NUMBER_ID                             := :old.UN_NUMBER_ID                                  ;
    t_old_rec.HAZARD_CLASS_ID                          := :old.HAZARD_CLASS_ID                               ;
    t_old_rec.NOTE_TO_VENDOR                           := :old.NOTE_TO_VENDOR                                ;
    t_old_rec.FROM_HEADER_ID                           := :old.FROM_HEADER_ID                                ;
    t_old_rec.FROM_LINE_ID                             := :old.FROM_LINE_ID                                  ;
    t_old_rec.MIN_ORDER_QUANTITY                       := :old.MIN_ORDER_QUANTITY                            ;
    t_old_rec.MAX_ORDER_QUANTITY                       := :old.MAX_ORDER_QUANTITY                            ;
    t_old_rec.QTY_RCV_TOLERANCE                        := :old.QTY_RCV_TOLERANCE                             ;
    t_old_rec.OVER_TOLERANCE_ERROR_FLAG                := :old.OVER_TOLERANCE_ERROR_FLAG                     ;
    t_old_rec.MARKET_PRICE                             := :old.MARKET_PRICE                                  ;
    t_old_rec.UNORDERED_FLAG                           := :old.UNORDERED_FLAG                                ;
    t_old_rec.CLOSED_FLAG                              := :old.CLOSED_FLAG                                   ;
    t_old_rec.USER_HOLD_FLAG                           := :old.USER_HOLD_FLAG                                ;
    t_old_rec.CANCEL_FLAG                              := :old.CANCEL_FLAG                                   ;
    t_old_rec.CANCELLED_BY                             := :old.CANCELLED_BY                                  ;
    t_old_rec.CANCEL_DATE                              := :old.CANCEL_DATE                                   ;
    t_old_rec.CANCEL_REASON                            := :old.CANCEL_REASON                                 ;
    t_old_rec.FIRM_STATUS_LOOKUP_CODE                  := :old.FIRM_STATUS_LOOKUP_CODE                       ;
    t_old_rec.FIRM_DATE                                := :old.FIRM_DATE                                     ;
    t_old_rec.VENDOR_PRODUCT_NUM                       := :old.VENDOR_PRODUCT_NUM                            ;
    t_old_rec.CONTRACT_NUM                             := :old.CONTRACT_NUM                                  ;
    t_old_rec.TAXABLE_FLAG                             := :old.TAXABLE_FLAG                                  ;
    t_old_rec.TAX_NAME                                 := :old.TAX_NAME                                      ;
    t_old_rec.TYPE_1099                                := :old.TYPE_1099                                     ;
    t_old_rec.CAPITAL_EXPENSE_FLAG                     := :old.CAPITAL_EXPENSE_FLAG                          ;
    t_old_rec.NEGOTIATED_BY_PREPARER_FLAG              := :old.NEGOTIATED_BY_PREPARER_FLAG                   ;
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
    t_old_rec.REFERENCE_NUM                            := :old.REFERENCE_NUM                                 ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.MIN_RELEASE_AMOUNT                       := :old.MIN_RELEASE_AMOUNT                            ;
    t_old_rec.PRICE_TYPE_LOOKUP_CODE                   := :old.PRICE_TYPE_LOOKUP_CODE                        ;
    t_old_rec.CLOSED_CODE                              := :old.CLOSED_CODE                                   ;
    t_old_rec.PRICE_BREAK_LOOKUP_CODE                  := :old.PRICE_BREAK_LOOKUP_CODE                       ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.GOVERNMENT_CONTEXT                       := :old.GOVERNMENT_CONTEXT                            ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.CLOSED_DATE                              := :old.CLOSED_DATE                                   ;
    t_old_rec.CLOSED_REASON                            := :old.CLOSED_REASON                                 ;
    t_old_rec.CLOSED_BY                                := :old.CLOSED_BY                                     ;
    t_old_rec.TRANSACTION_REASON_CODE                  := :old.TRANSACTION_REASON_CODE                       ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.QC_GRADE                                 := :old.QC_GRADE                                      ;
    t_old_rec.BASE_UOM                                 := :old.BASE_UOM                                      ;
    t_old_rec.BASE_QTY                                 := :old.BASE_QTY                                      ;
    t_old_rec.SECONDARY_UOM                            := :old.SECONDARY_UOM                                 ;
    t_old_rec.SECONDARY_QTY                            := :old.SECONDARY_QTY                                 ;
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
    t_old_rec.LINE_REFERENCE_NUM                       := :old.LINE_REFERENCE_NUM                            ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
    t_old_rec.EXPIRATION_DATE                          := :old.EXPIRATION_DATE                               ;
    t_old_rec.TAX_CODE_ID                              := :old.TAX_CODE_ID                                   ;
    t_old_rec.OKE_CONTRACT_HEADER_ID                   := :old.OKE_CONTRACT_HEADER_ID                        ;
    t_old_rec.OKE_CONTRACT_VERSION_ID                  := :old.OKE_CONTRACT_VERSION_ID                       ;
    t_old_rec.SECONDARY_QUANTITY                       := :old.SECONDARY_QUANTITY                            ;
    t_old_rec.SECONDARY_UNIT_OF_MEASURE                := :old.SECONDARY_UNIT_OF_MEASURE                     ;
    t_old_rec.PREFERRED_GRADE                          := :old.PREFERRED_GRADE                               ;
    t_old_rec.AUCTION_HEADER_ID                        := :old.AUCTION_HEADER_ID                             ;
    t_old_rec.AUCTION_DISPLAY_NUMBER                   := :old.AUCTION_DISPLAY_NUMBER                        ;
    t_old_rec.AUCTION_LINE_NUMBER                      := :old.AUCTION_LINE_NUMBER                           ;
    t_old_rec.BID_NUMBER                               := :old.BID_NUMBER                                    ;
    t_old_rec.BID_LINE_NUMBER                          := :old.BID_LINE_NUMBER                               ;
    t_old_rec.RETROACTIVE_DATE                         := :old.RETROACTIVE_DATE                              ;
    t_old_rec.SUPPLIER_REF_NUMBER                      := :old.SUPPLIER_REF_NUMBER                           ;
    t_old_rec.CONTRACT_ID                              := :old.CONTRACT_ID                                   ;
    t_old_rec.START_DATE                               := :old.START_DATE                                    ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.JOB_ID                                   := :old.JOB_ID                                        ;
    t_old_rec.CONTRACTOR_FIRST_NAME                    := :old.CONTRACTOR_FIRST_NAME                         ;
    t_old_rec.CONTRACTOR_LAST_NAME                     := :old.CONTRACTOR_LAST_NAME                          ;
    t_old_rec.FROM_LINE_LOCATION_ID                    := :old.FROM_LINE_LOCATION_ID                         ;
    t_old_rec.ORDER_TYPE_LOOKUP_CODE                   := :old.ORDER_TYPE_LOOKUP_CODE                        ;
    t_old_rec.PURCHASE_BASIS                           := :old.PURCHASE_BASIS                                ;
    t_old_rec.MATCHING_BASIS                           := :old.MATCHING_BASIS                                ;
    t_old_rec.SVC_AMOUNT_NOTIF_SENT                    := :old.SVC_AMOUNT_NOTIF_SENT                         ;
    t_old_rec.SVC_COMPLETION_NOTIF_SENT                := :old.SVC_COMPLETION_NOTIF_SENT                     ;
    t_old_rec.BASE_UNIT_PRICE                          := :old.BASE_UNIT_PRICE                               ;
    t_old_rec.MANUAL_PRICE_CHANGE_FLAG                 := :old.MANUAL_PRICE_CHANGE_FLAG                      ;
    t_old_rec.CATALOG_NAME                             := :old.CATALOG_NAME                                  ;
    t_old_rec.SUPPLIER_PART_AUXID                      := :old.SUPPLIER_PART_AUXID                           ;
    t_old_rec.IP_CATEGORY_ID                           := :old.IP_CATEGORY_ID                                ;
    /*
    t_old_rec.LAST_UPDATED_PROGRAM                     := :old.LAST_UPDATED_PROGRAM                          ;
    commented by ssumaith - bug#4616729
    */
    t_old_rec.RETAINAGE_RATE                           := :old.RETAINAGE_RATE                                ;
    t_old_rec.MAX_RETAINAGE_AMOUNT                     := :old.MAX_RETAINAGE_AMOUNT                          ;
    t_old_rec.PROGRESS_PAYMENT_RATE                    := :old.PROGRESS_PAYMENT_RATE                         ;
    t_old_rec.RECOUPMENT_RATE                          := :old.RECOUPMENT_RATE                               ;
    t_old_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :old.TAX_ATTRIBUTE_UPDATE_CODE                     ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_LA_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

    IF ( :NEW.ITEM_ID IS NOT NULL ) THEN

      JAI_PO_LA_TRIGGER_PKG.ARI_T1 (
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

  IF UPDATING THEN

      JAI_PO_LA_TRIGGER_PKG.ARU_T1 (
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

      JAI_PO_LA_TRIGGER_PKG.ARD_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_LA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_LA_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_PO_LA_ARIUD_T1" DISABLE;
