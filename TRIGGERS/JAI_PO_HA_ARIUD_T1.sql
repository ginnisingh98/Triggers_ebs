--------------------------------------------------------
--  DDL for Trigger JAI_PO_HA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_HA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."PO_HEADERS_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             PO_HEADERS_ALL%rowtype ;
  t_new_rec             PO_HEADERS_ALL%rowtype ;
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

  21-Oct-2005  Ramananda for bug#4692402. File Version 120.4
               Removed the references of column ENCUMBRANCE_REQUIRED

  28-May-2007  Bgowrava for Bug#6076948. File version 120.6
  						 Removed the code to call the procedure JAI_PO_HA_TRIGGER_PKG.ARU_T1

  ****************************************************************************/

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.AGENT_ID                                 := :new.AGENT_ID                                      ;
    t_new_rec.TYPE_LOOKUP_CODE                         := :new.TYPE_LOOKUP_CODE                              ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.SEGMENT1                                 := :new.SEGMENT1                                      ;
    t_new_rec.SUMMARY_FLAG                             := :new.SUMMARY_FLAG                                  ;
    t_new_rec.ENABLED_FLAG                             := :new.ENABLED_FLAG                                  ;
    t_new_rec.SEGMENT2                                 := :new.SEGMENT2                                      ;
    t_new_rec.SEGMENT3                                 := :new.SEGMENT3                                      ;
    t_new_rec.SEGMENT4                                 := :new.SEGMENT4                                      ;
    t_new_rec.SEGMENT5                                 := :new.SEGMENT5                                      ;
    t_new_rec.START_DATE_ACTIVE                        := :new.START_DATE_ACTIVE                             ;
    t_new_rec.END_DATE_ACTIVE                          := :new.END_DATE_ACTIVE                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.VENDOR_CONTACT_ID                        := :new.VENDOR_CONTACT_ID                             ;
    t_new_rec.SHIP_TO_LOCATION_ID                      := :new.SHIP_TO_LOCATION_ID                           ;
    t_new_rec.BILL_TO_LOCATION_ID                      := :new.BILL_TO_LOCATION_ID                           ;
    t_new_rec.TERMS_ID                                 := :new.TERMS_ID                                      ;
    t_new_rec.SHIP_VIA_LOOKUP_CODE                     := :new.SHIP_VIA_LOOKUP_CODE                          ;
    t_new_rec.FOB_LOOKUP_CODE                          := :new.FOB_LOOKUP_CODE                               ;
    t_new_rec.FREIGHT_TERMS_LOOKUP_CODE                := :new.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_new_rec.STATUS_LOOKUP_CODE                       := :new.STATUS_LOOKUP_CODE                            ;
    t_new_rec.CURRENCY_CODE                            := :new.CURRENCY_CODE                                 ;
    t_new_rec.RATE_TYPE                                := :new.RATE_TYPE                                     ;
    t_new_rec.RATE_DATE                                := :new.RATE_DATE                                     ;
    t_new_rec.RATE                                     := :new.RATE                                          ;
    t_new_rec.FROM_HEADER_ID                           := :new.FROM_HEADER_ID                                ;
    t_new_rec.FROM_TYPE_LOOKUP_CODE                    := :new.FROM_TYPE_LOOKUP_CODE                         ;
    t_new_rec.START_DATE                               := :new.START_DATE                                    ;
    t_new_rec.END_DATE                                 := :new.END_DATE                                      ;
    t_new_rec.BLANKET_TOTAL_AMOUNT                     := :new.BLANKET_TOTAL_AMOUNT                          ;
    t_new_rec.AUTHORIZATION_STATUS                     := :new.AUTHORIZATION_STATUS                          ;
    t_new_rec.REVISION_NUM                             := :new.REVISION_NUM                                  ;
    t_new_rec.REVISED_DATE                             := :new.REVISED_DATE                                  ;
    t_new_rec.APPROVED_FLAG                            := :new.APPROVED_FLAG                                 ;
    t_new_rec.APPROVED_DATE                            := :new.APPROVED_DATE                                 ;
    t_new_rec.AMOUNT_LIMIT                             := :new.AMOUNT_LIMIT                                  ;
    t_new_rec.MIN_RELEASE_AMOUNT                       := :new.MIN_RELEASE_AMOUNT                            ;
    t_new_rec.NOTE_TO_AUTHORIZER                       := :new.NOTE_TO_AUTHORIZER                            ;
    t_new_rec.NOTE_TO_VENDOR                           := :new.NOTE_TO_VENDOR                                ;
    t_new_rec.NOTE_TO_RECEIVER                         := :new.NOTE_TO_RECEIVER                              ;
    t_new_rec.PRINT_COUNT                              := :new.PRINT_COUNT                                   ;
    t_new_rec.PRINTED_DATE                             := :new.PRINTED_DATE                                  ;
    t_new_rec.VENDOR_ORDER_NUM                         := :new.VENDOR_ORDER_NUM                              ;
    t_new_rec.CONFIRMING_ORDER_FLAG                    := :new.CONFIRMING_ORDER_FLAG                         ;
    t_new_rec.COMMENTS                                 := :new.COMMENTS                                      ;
    t_new_rec.REPLY_DATE                               := :new.REPLY_DATE                                    ;
    t_new_rec.REPLY_METHOD_LOOKUP_CODE                 := :new.REPLY_METHOD_LOOKUP_CODE                      ;
    t_new_rec.RFQ_CLOSE_DATE                           := :new.RFQ_CLOSE_DATE                                ;
    t_new_rec.QUOTE_TYPE_LOOKUP_CODE                   := :new.QUOTE_TYPE_LOOKUP_CODE                        ;
    t_new_rec.QUOTATION_CLASS_CODE                     := :new.QUOTATION_CLASS_CODE                          ;
    t_new_rec.QUOTE_WARNING_DELAY_UNIT                 := :new.QUOTE_WARNING_DELAY_UNIT                      ;
    t_new_rec.QUOTE_WARNING_DELAY                      := :new.QUOTE_WARNING_DELAY                           ;
    t_new_rec.QUOTE_VENDOR_QUOTE_NUMBER                := :new.QUOTE_VENDOR_QUOTE_NUMBER                     ;
    t_new_rec.ACCEPTANCE_REQUIRED_FLAG                 := :new.ACCEPTANCE_REQUIRED_FLAG                      ;
    t_new_rec.ACCEPTANCE_DUE_DATE                      := :new.ACCEPTANCE_DUE_DATE                           ;
    t_new_rec.CLOSED_DATE                              := :new.CLOSED_DATE                                   ;
    t_new_rec.USER_HOLD_FLAG                           := :new.USER_HOLD_FLAG                                ;
    t_new_rec.APPROVAL_REQUIRED_FLAG                   := :new.APPROVAL_REQUIRED_FLAG                        ;
    t_new_rec.CANCEL_FLAG                              := :new.CANCEL_FLAG                                   ;
    t_new_rec.FIRM_STATUS_LOOKUP_CODE                  := :new.FIRM_STATUS_LOOKUP_CODE                       ;
    t_new_rec.FIRM_DATE                                := :new.FIRM_DATE                                     ;
    t_new_rec.FROZEN_FLAG                              := :new.FROZEN_FLAG                                   ;
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
    t_new_rec.CLOSED_CODE                              := :new.CLOSED_CODE                                   ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.GOVERNMENT_CONTEXT                       := :new.GOVERNMENT_CONTEXT                            ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.SUPPLY_AGREEMENT_FLAG                    := :new.SUPPLY_AGREEMENT_FLAG                         ;
    t_new_rec.EDI_PROCESSED_FLAG                       := :new.EDI_PROCESSED_FLAG                            ;
    t_new_rec.EDI_PROCESSED_STATUS                     := :new.EDI_PROCESSED_STATUS                          ;
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
    t_new_rec.INTERFACE_SOURCE_CODE                    := :new.INTERFACE_SOURCE_CODE                         ;
    t_new_rec.REFERENCE_NUM                            := :new.REFERENCE_NUM                                 ;
    t_new_rec.WF_ITEM_TYPE                             := :new.WF_ITEM_TYPE                                  ;
    t_new_rec.WF_ITEM_KEY                              := :new.WF_ITEM_KEY                                   ;
    t_new_rec.MRC_RATE_TYPE                            := :new.MRC_RATE_TYPE                                 ;
    t_new_rec.MRC_RATE_DATE                            := :new.MRC_RATE_DATE                                 ;
    t_new_rec.MRC_RATE                                 := :new.MRC_RATE                                      ;
    t_new_rec.PCARD_ID                                 := :new.PCARD_ID                                      ;
    t_new_rec.PRICE_UPDATE_TOLERANCE                   := :new.PRICE_UPDATE_TOLERANCE                        ;
    t_new_rec.PAY_ON_CODE                              := :new.PAY_ON_CODE                                   ;
    t_new_rec.XML_FLAG                                 := :new.XML_FLAG                                      ;
    t_new_rec.XML_SEND_DATE                            := :new.XML_SEND_DATE                                 ;
    t_new_rec.XML_CHANGE_SEND_DATE                     := :new.XML_CHANGE_SEND_DATE                          ;
    t_new_rec.GLOBAL_AGREEMENT_FLAG                    := :new.GLOBAL_AGREEMENT_FLAG                         ;
    t_new_rec.CONSIGNED_CONSUMPTION_FLAG               := :new.CONSIGNED_CONSUMPTION_FLAG                    ;
    t_new_rec.CBC_ACCOUNTING_DATE                      := :new.CBC_ACCOUNTING_DATE                           ;
    t_new_rec.CONSUME_REQ_DEMAND_FLAG                  := :new.CONSUME_REQ_DEMAND_FLAG                       ;
    t_new_rec.CHANGE_REQUESTED_BY                      := :new.CHANGE_REQUESTED_BY                           ;
    t_new_rec.SHIPPING_CONTROL                         := :new.SHIPPING_CONTROL                              ;
    t_new_rec.CONTERMS_EXIST_FLAG                      := :new.CONTERMS_EXIST_FLAG                           ;
    t_new_rec.CONTERMS_ARTICLES_UPD_DATE               := :new.CONTERMS_ARTICLES_UPD_DATE                    ;
    t_new_rec.CONTERMS_DELIV_UPD_DATE                  := :new.CONTERMS_DELIV_UPD_DATE                       ;
    t_new_rec.PENDING_SIGNATURE_FLAG                   := :new.PENDING_SIGNATURE_FLAG                        ;
    t_new_rec.CHANGE_SUMMARY                           := :new.CHANGE_SUMMARY                                ;
    t_new_rec.ENCUMBRANCE_REQUIRED_FLAG                := :new.ENCUMBRANCE_REQUIRED_FLAG                     ;
    t_new_rec.DOCUMENT_CREATION_METHOD                 := :new.DOCUMENT_CREATION_METHOD                      ;
    t_new_rec.SUBMIT_DATE                              := :new.SUBMIT_DATE                                   ;
    t_new_rec.CREATED_LANGUAGE                         := :new.CREATED_LANGUAGE                              ;
    t_new_rec.CPA_REFERENCE                            := :new.CPA_REFERENCE                                 ;
    /*
    t_new_rec.LAST_UPDATED_PROGRAM                     := :new.LAST_UPDATED_PROGRAM                          ;
    commented by ssumaith - bug# 4616729
    */
    t_new_rec.SUPPLIER_NOTIF_METHOD                    := :new.SUPPLIER_NOTIF_METHOD                         ;
    t_new_rec.FAX                                      := :new.FAX                                           ;
    t_new_rec.EMAIL_ADDRESS                            := :new.EMAIL_ADDRESS                                 ;
    t_new_rec.RETRO_PRICE_COMM_UPDATES_FLAG            := :new.RETRO_PRICE_COMM_UPDATES_FLAG                 ;
    t_new_rec.RETRO_PRICE_APPLY_UPDATES_FLAG           := :new.RETRO_PRICE_APPLY_UPDATES_FLAG                ;
    t_new_rec.UPDATE_SOURCING_RULES_FLAG               := :new.UPDATE_SOURCING_RULES_FLAG                    ;
    t_new_rec.AUTO_SOURCING_FLAG                       := :new.AUTO_SOURCING_FLAG                            ;
    t_new_rec.LOCK_OWNER_ROLE                          := :new.LOCK_OWNER_ROLE                               ;
    t_new_rec.LOCK_OWNER_USER_ID                       := :new.LOCK_OWNER_USER_ID                            ;
    t_new_rec.SUPPLIER_AUTH_ENABLED_FLAG               := :new.SUPPLIER_AUTH_ENABLED_FLAG                    ;
    t_new_rec.STYLE_ID                                 := :new.STYLE_ID                                      ;
    t_new_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :new.TAX_ATTRIBUTE_UPDATE_CODE                     ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.AGENT_ID                                 := :old.AGENT_ID                                      ;
    t_old_rec.TYPE_LOOKUP_CODE                         := :old.TYPE_LOOKUP_CODE                              ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.SEGMENT1                                 := :old.SEGMENT1                                      ;
    t_old_rec.SUMMARY_FLAG                             := :old.SUMMARY_FLAG                                  ;
    t_old_rec.ENABLED_FLAG                             := :old.ENABLED_FLAG                                  ;
    t_old_rec.SEGMENT2                                 := :old.SEGMENT2                                      ;
    t_old_rec.SEGMENT3                                 := :old.SEGMENT3                                      ;
    t_old_rec.SEGMENT4                                 := :old.SEGMENT4                                      ;
    t_old_rec.SEGMENT5                                 := :old.SEGMENT5                                      ;
    t_old_rec.START_DATE_ACTIVE                        := :old.START_DATE_ACTIVE                             ;
    t_old_rec.END_DATE_ACTIVE                          := :old.END_DATE_ACTIVE                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.VENDOR_CONTACT_ID                        := :old.VENDOR_CONTACT_ID                             ;
    t_old_rec.SHIP_TO_LOCATION_ID                      := :old.SHIP_TO_LOCATION_ID                           ;
    t_old_rec.BILL_TO_LOCATION_ID                      := :old.BILL_TO_LOCATION_ID                           ;
    t_old_rec.TERMS_ID                                 := :old.TERMS_ID                                      ;
    t_old_rec.SHIP_VIA_LOOKUP_CODE                     := :old.SHIP_VIA_LOOKUP_CODE                          ;
    t_old_rec.FOB_LOOKUP_CODE                          := :old.FOB_LOOKUP_CODE                               ;
    t_old_rec.FREIGHT_TERMS_LOOKUP_CODE                := :old.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_old_rec.STATUS_LOOKUP_CODE                       := :old.STATUS_LOOKUP_CODE                            ;
    t_old_rec.CURRENCY_CODE                            := :old.CURRENCY_CODE                                 ;
    t_old_rec.RATE_TYPE                                := :old.RATE_TYPE                                     ;
    t_old_rec.RATE_DATE                                := :old.RATE_DATE                                     ;
    t_old_rec.RATE                                     := :old.RATE                                          ;
    t_old_rec.FROM_HEADER_ID                           := :old.FROM_HEADER_ID                                ;
    t_old_rec.FROM_TYPE_LOOKUP_CODE                    := :old.FROM_TYPE_LOOKUP_CODE                         ;
    t_old_rec.START_DATE                               := :old.START_DATE                                    ;
    t_old_rec.END_DATE                                 := :old.END_DATE                                      ;
    t_old_rec.BLANKET_TOTAL_AMOUNT                     := :old.BLANKET_TOTAL_AMOUNT                          ;
    t_old_rec.AUTHORIZATION_STATUS                     := :old.AUTHORIZATION_STATUS                          ;
    t_old_rec.REVISION_NUM                             := :old.REVISION_NUM                                  ;
    t_old_rec.REVISED_DATE                             := :old.REVISED_DATE                                  ;
    t_old_rec.APPROVED_FLAG                            := :old.APPROVED_FLAG                                 ;
    t_old_rec.APPROVED_DATE                            := :old.APPROVED_DATE                                 ;
    t_old_rec.AMOUNT_LIMIT                             := :old.AMOUNT_LIMIT                                  ;
    t_old_rec.MIN_RELEASE_AMOUNT                       := :old.MIN_RELEASE_AMOUNT                            ;
    t_old_rec.NOTE_TO_AUTHORIZER                       := :old.NOTE_TO_AUTHORIZER                            ;
    t_old_rec.NOTE_TO_VENDOR                           := :old.NOTE_TO_VENDOR                                ;
    t_old_rec.NOTE_TO_RECEIVER                         := :old.NOTE_TO_RECEIVER                              ;
    t_old_rec.PRINT_COUNT                              := :old.PRINT_COUNT                                   ;
    t_old_rec.PRINTED_DATE                             := :old.PRINTED_DATE                                  ;
    t_old_rec.VENDOR_ORDER_NUM                         := :old.VENDOR_ORDER_NUM                              ;
    t_old_rec.CONFIRMING_ORDER_FLAG                    := :old.CONFIRMING_ORDER_FLAG                         ;
    t_old_rec.COMMENTS                                 := :old.COMMENTS                                      ;
    t_old_rec.REPLY_DATE                               := :old.REPLY_DATE                                    ;
    t_old_rec.REPLY_METHOD_LOOKUP_CODE                 := :old.REPLY_METHOD_LOOKUP_CODE                      ;
    t_old_rec.RFQ_CLOSE_DATE                           := :old.RFQ_CLOSE_DATE                                ;
    t_old_rec.QUOTE_TYPE_LOOKUP_CODE                   := :old.QUOTE_TYPE_LOOKUP_CODE                        ;
    t_old_rec.QUOTATION_CLASS_CODE                     := :old.QUOTATION_CLASS_CODE                          ;
    t_old_rec.QUOTE_WARNING_DELAY_UNIT                 := :old.QUOTE_WARNING_DELAY_UNIT                      ;
    t_old_rec.QUOTE_WARNING_DELAY                      := :old.QUOTE_WARNING_DELAY                           ;
    t_old_rec.QUOTE_VENDOR_QUOTE_NUMBER                := :old.QUOTE_VENDOR_QUOTE_NUMBER                     ;
    t_old_rec.ACCEPTANCE_REQUIRED_FLAG                 := :old.ACCEPTANCE_REQUIRED_FLAG                      ;
    t_old_rec.ACCEPTANCE_DUE_DATE                      := :old.ACCEPTANCE_DUE_DATE                           ;
    t_old_rec.CLOSED_DATE                              := :old.CLOSED_DATE                                   ;
    t_old_rec.USER_HOLD_FLAG                           := :old.USER_HOLD_FLAG                                ;
    t_old_rec.APPROVAL_REQUIRED_FLAG                   := :old.APPROVAL_REQUIRED_FLAG                        ;
    t_old_rec.CANCEL_FLAG                              := :old.CANCEL_FLAG                                   ;
    t_old_rec.FIRM_STATUS_LOOKUP_CODE                  := :old.FIRM_STATUS_LOOKUP_CODE                       ;
    t_old_rec.FIRM_DATE                                := :old.FIRM_DATE                                     ;
    t_old_rec.FROZEN_FLAG                              := :old.FROZEN_FLAG                                   ;
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
    t_old_rec.CLOSED_CODE                              := :old.CLOSED_CODE                                   ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.GOVERNMENT_CONTEXT                       := :old.GOVERNMENT_CONTEXT                            ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.SUPPLY_AGREEMENT_FLAG                    := :old.SUPPLY_AGREEMENT_FLAG                         ;
    t_old_rec.EDI_PROCESSED_FLAG                       := :old.EDI_PROCESSED_FLAG                            ;
    t_old_rec.EDI_PROCESSED_STATUS                     := :old.EDI_PROCESSED_STATUS                          ;
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
    t_old_rec.INTERFACE_SOURCE_CODE                    := :old.INTERFACE_SOURCE_CODE                         ;
    t_old_rec.REFERENCE_NUM                            := :old.REFERENCE_NUM                                 ;
    t_old_rec.WF_ITEM_TYPE                             := :old.WF_ITEM_TYPE                                  ;
    t_old_rec.WF_ITEM_KEY                              := :old.WF_ITEM_KEY                                   ;
    t_old_rec.MRC_RATE_TYPE                            := :old.MRC_RATE_TYPE                                 ;
    t_old_rec.MRC_RATE_DATE                            := :old.MRC_RATE_DATE                                 ;
    t_old_rec.MRC_RATE                                 := :old.MRC_RATE                                      ;
    t_old_rec.PCARD_ID                                 := :old.PCARD_ID                                      ;
    t_old_rec.PRICE_UPDATE_TOLERANCE                   := :old.PRICE_UPDATE_TOLERANCE                        ;
    t_old_rec.PAY_ON_CODE                              := :old.PAY_ON_CODE                                   ;
    t_old_rec.XML_FLAG                                 := :old.XML_FLAG                                      ;
    t_old_rec.XML_SEND_DATE                            := :old.XML_SEND_DATE                                 ;
    t_old_rec.XML_CHANGE_SEND_DATE                     := :old.XML_CHANGE_SEND_DATE                          ;
    t_old_rec.GLOBAL_AGREEMENT_FLAG                    := :old.GLOBAL_AGREEMENT_FLAG                         ;
    t_old_rec.CONSIGNED_CONSUMPTION_FLAG               := :old.CONSIGNED_CONSUMPTION_FLAG                    ;
    t_old_rec.CBC_ACCOUNTING_DATE                      := :old.CBC_ACCOUNTING_DATE                           ;
    t_old_rec.CONSUME_REQ_DEMAND_FLAG                  := :old.CONSUME_REQ_DEMAND_FLAG                       ;
    t_old_rec.CHANGE_REQUESTED_BY                      := :old.CHANGE_REQUESTED_BY                           ;
    t_old_rec.SHIPPING_CONTROL                         := :old.SHIPPING_CONTROL                              ;
    t_old_rec.CONTERMS_EXIST_FLAG                      := :old.CONTERMS_EXIST_FLAG                           ;
    t_old_rec.CONTERMS_ARTICLES_UPD_DATE               := :old.CONTERMS_ARTICLES_UPD_DATE                    ;
    t_old_rec.CONTERMS_DELIV_UPD_DATE                  := :old.CONTERMS_DELIV_UPD_DATE                       ;
    t_old_rec.PENDING_SIGNATURE_FLAG                   := :old.PENDING_SIGNATURE_FLAG                        ;
    t_old_rec.CHANGE_SUMMARY                           := :old.CHANGE_SUMMARY                                ;
    t_old_rec.ENCUMBRANCE_REQUIRED_FLAG                := :old.ENCUMBRANCE_REQUIRED_FLAG                     ;
    t_old_rec.DOCUMENT_CREATION_METHOD                 := :old.DOCUMENT_CREATION_METHOD                      ;
    t_old_rec.SUBMIT_DATE                              := :old.SUBMIT_DATE                                   ;
    t_old_rec.CREATED_LANGUAGE                         := :old.CREATED_LANGUAGE                              ;
    t_old_rec.CPA_REFERENCE                            := :old.CPA_REFERENCE                                 ;
    t_old_rec.SUPPLIER_NOTIF_METHOD                    := :old.SUPPLIER_NOTIF_METHOD                         ;
    t_old_rec.FAX                                      := :old.FAX                                           ;
    t_old_rec.EMAIL_ADDRESS                            := :old.EMAIL_ADDRESS                                 ;
    t_old_rec.RETRO_PRICE_COMM_UPDATES_FLAG            := :old.RETRO_PRICE_COMM_UPDATES_FLAG                 ;
    t_old_rec.RETRO_PRICE_APPLY_UPDATES_FLAG           := :old.RETRO_PRICE_APPLY_UPDATES_FLAG                ;
    t_old_rec.UPDATE_SOURCING_RULES_FLAG               := :old.UPDATE_SOURCING_RULES_FLAG                    ;
    t_old_rec.AUTO_SOURCING_FLAG                       := :old.AUTO_SOURCING_FLAG                            ;
    t_old_rec.LOCK_OWNER_ROLE                          := :old.LOCK_OWNER_ROLE                               ;
    t_old_rec.LOCK_OWNER_USER_ID                       := :old.LOCK_OWNER_USER_ID                            ;
    t_old_rec.SUPPLIER_AUTH_ENABLED_FLAG               := :old.SUPPLIER_AUTH_ENABLED_FLAG                    ;
    t_old_rec.STYLE_ID                                 := :old.STYLE_ID                                      ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_HA_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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


    IF ( :OLD.Currency_Code <> :NEW.Currency_Code ) THEN

      JAI_PO_HA_TRIGGER_PKG.ARU_T2 (
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

    IF ( ( NVL( :OLD.Vendor_Id, -999 ) <> NVL( :NEW.Vendor_Id, -999 ) ) OR ( NVL( :OLD.Vendor_Site_Id, -999 ) <> NVL( :NEW.Vendor_Site_Id, -999 ) ) ) THEN

      JAI_PO_HA_TRIGGER_PKG.ARU_T3 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_HA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_HA_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_PO_HA_ARIUD_T1" DISABLE;
