--------------------------------------------------------
--  DDL for Trigger JAI_PO_RLA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_RLA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."PO_REQUISITION_LINES_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             PO_REQUISITION_LINES_ALL%rowtype ;
  t_new_rec             PO_REQUISITION_LINES_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /*----------------------------------------------------------------------------------------------------------------------
   CHANGE HISTORY:
   S.No    Date          Author and Details

    1.    07-Nov-2005    Ramananda for bug# 4718848. FileVersion 120.3
                         Removed the references of column ORIGINAL_SHIPMENT_ID of table PO_REQUISITION_LINES_ALL

    2.    14-Sep-2009   Bug 8739537 File version 120.4.12000000.4 / 120.6.12010000.2 / 120.7
                          Removed the extra space from the IF statement
                          IF ( NVL( :OLD.CURRENCY_CODE, 'X' ) <> NVL( :NEW.CURRENCY_CODE,' X' ) ) THEN
                          The extra space caused the above statement to be always true for iProce requisitions, resulting in taxes being defaulted from
                          vendor setup, though different taxes are present in the BPA.

   -----------------------------------------------------------------------------------------------------------------------*/

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.REQUISITION_LINE_ID                      := :new.REQUISITION_LINE_ID                           ;
    t_new_rec.REQUISITION_HEADER_ID                    := :new.REQUISITION_HEADER_ID                         ;
    t_new_rec.LINE_NUM                                 := :new.LINE_NUM                                      ;
    t_new_rec.LINE_TYPE_ID                             := :new.LINE_TYPE_ID                                  ;
    t_new_rec.CATEGORY_ID                              := :new.CATEGORY_ID                                   ;
    t_new_rec.ITEM_DESCRIPTION                         := :new.ITEM_DESCRIPTION                              ;
    t_new_rec.UNIT_MEAS_LOOKUP_CODE                    := :new.UNIT_MEAS_LOOKUP_CODE                         ;
    t_new_rec.UNIT_PRICE                               := :new.UNIT_PRICE                                    ;
    t_new_rec.QUANTITY                                 := :new.QUANTITY                                      ;
    t_new_rec.DELIVER_TO_LOCATION_ID                   := :new.DELIVER_TO_LOCATION_ID                        ;
    t_new_rec.TO_PERSON_ID                             := :new.TO_PERSON_ID                                  ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.SOURCE_TYPE_CODE                         := :new.SOURCE_TYPE_CODE                              ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.ITEM_ID                                  := :new.ITEM_ID                                       ;
    t_new_rec.ITEM_REVISION                            := :new.ITEM_REVISION                                 ;
    t_new_rec.QUANTITY_DELIVERED                       := :new.QUANTITY_DELIVERED                            ;
    t_new_rec.SUGGESTED_BUYER_ID                       := :new.SUGGESTED_BUYER_ID                            ;
    t_new_rec.ENCUMBERED_FLAG                          := :new.ENCUMBERED_FLAG                               ;
    t_new_rec.RFQ_REQUIRED_FLAG                        := :new.RFQ_REQUIRED_FLAG                             ;
    t_new_rec.NEED_BY_DATE                             := :new.NEED_BY_DATE                                  ;
    t_new_rec.LINE_LOCATION_ID                         := :new.LINE_LOCATION_ID                              ;
    t_new_rec.MODIFIED_BY_AGENT_FLAG                   := :new.MODIFIED_BY_AGENT_FLAG                        ;
    t_new_rec.PARENT_REQ_LINE_ID                       := :new.PARENT_REQ_LINE_ID                            ;
    t_new_rec.JUSTIFICATION                            := :new.JUSTIFICATION                                 ;
    t_new_rec.NOTE_TO_AGENT                            := :new.NOTE_TO_AGENT                                 ;
    t_new_rec.NOTE_TO_RECEIVER                         := :new.NOTE_TO_RECEIVER                              ;
    t_new_rec.PURCHASING_AGENT_ID                      := :new.PURCHASING_AGENT_ID                           ;
    t_new_rec.DOCUMENT_TYPE_CODE                       := :new.DOCUMENT_TYPE_CODE                            ;
    t_new_rec.BLANKET_PO_HEADER_ID                     := :new.BLANKET_PO_HEADER_ID                          ;
    t_new_rec.BLANKET_PO_LINE_NUM                      := :new.BLANKET_PO_LINE_NUM                           ;
    t_new_rec.CURRENCY_CODE                            := :new.CURRENCY_CODE                                 ;
    t_new_rec.RATE_TYPE                                := :new.RATE_TYPE                                     ;
    t_new_rec.RATE_DATE                                := :new.RATE_DATE                                     ;
    t_new_rec.RATE                                     := :new.RATE                                          ;
    t_new_rec.CURRENCY_UNIT_PRICE                      := :new.CURRENCY_UNIT_PRICE                           ;
    t_new_rec.SUGGESTED_VENDOR_NAME                    := :new.SUGGESTED_VENDOR_NAME                         ;
    t_new_rec.SUGGESTED_VENDOR_LOCATION                := :new.SUGGESTED_VENDOR_LOCATION                     ;
    t_new_rec.SUGGESTED_VENDOR_CONTACT                 := :new.SUGGESTED_VENDOR_CONTACT                      ;
    t_new_rec.SUGGESTED_VENDOR_PHONE                   := :new.SUGGESTED_VENDOR_PHONE                        ;
    t_new_rec.SUGGESTED_VENDOR_PRODUCT_CODE            := :new.SUGGESTED_VENDOR_PRODUCT_CODE                 ;
    t_new_rec.UN_NUMBER_ID                             := :new.UN_NUMBER_ID                                  ;
    t_new_rec.HAZARD_CLASS_ID                          := :new.HAZARD_CLASS_ID                               ;
    t_new_rec.MUST_USE_SUGG_VENDOR_FLAG                := :new.MUST_USE_SUGG_VENDOR_FLAG                     ;
    t_new_rec.REFERENCE_NUM                            := :new.REFERENCE_NUM                                 ;
    t_new_rec.ON_RFQ_FLAG                              := :new.ON_RFQ_FLAG                                   ;
    t_new_rec.URGENT_FLAG                              := :new.URGENT_FLAG                                   ;
    t_new_rec.CANCEL_FLAG                              := :new.CANCEL_FLAG                                   ;
    t_new_rec.SOURCE_ORGANIZATION_ID                   := :new.SOURCE_ORGANIZATION_ID                        ;
    t_new_rec.SOURCE_SUBINVENTORY                      := :new.SOURCE_SUBINVENTORY                           ;
    t_new_rec.DESTINATION_TYPE_CODE                    := :new.DESTINATION_TYPE_CODE                         ;
    t_new_rec.DESTINATION_ORGANIZATION_ID              := :new.DESTINATION_ORGANIZATION_ID                   ;
    t_new_rec.DESTINATION_SUBINVENTORY                 := :new.DESTINATION_SUBINVENTORY                      ;
    t_new_rec.QUANTITY_CANCELLED                       := :new.QUANTITY_CANCELLED                            ;
    t_new_rec.CANCEL_DATE                              := :new.CANCEL_DATE                                   ;
    t_new_rec.CANCEL_REASON                            := :new.CANCEL_REASON                                 ;
    t_new_rec.CLOSED_CODE                              := :new.CLOSED_CODE                                   ;
    t_new_rec.AGENT_RETURN_NOTE                        := :new.AGENT_RETURN_NOTE                             ;
    t_new_rec.CHANGED_AFTER_RESEARCH_FLAG              := :new.CHANGED_AFTER_RESEARCH_FLAG                   ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.VENDOR_CONTACT_ID                        := :new.VENDOR_CONTACT_ID                             ;
    t_new_rec.RESEARCH_AGENT_ID                        := :new.RESEARCH_AGENT_ID                             ;
    t_new_rec.ON_LINE_FLAG                             := :new.ON_LINE_FLAG                                  ;
    t_new_rec.WIP_ENTITY_ID                            := :new.WIP_ENTITY_ID                                 ;
    t_new_rec.WIP_LINE_ID                              := :new.WIP_LINE_ID                                   ;
    t_new_rec.WIP_REPETITIVE_SCHEDULE_ID               := :new.WIP_REPETITIVE_SCHEDULE_ID                    ;
    t_new_rec.WIP_OPERATION_SEQ_NUM                    := :new.WIP_OPERATION_SEQ_NUM                         ;
    t_new_rec.WIP_RESOURCE_SEQ_NUM                     := :new.WIP_RESOURCE_SEQ_NUM                          ;
    t_new_rec.ATTRIBUTE_CATEGORY                       := :new.ATTRIBUTE_CATEGORY                            ;
    t_new_rec.DESTINATION_CONTEXT                      := :new.DESTINATION_CONTEXT                           ;
    t_new_rec.INVENTORY_SOURCE_CONTEXT                 := :new.INVENTORY_SOURCE_CONTEXT                      ;
    t_new_rec.VENDOR_SOURCE_CONTEXT                    := :new.VENDOR_SOURCE_CONTEXT                         ;
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
    t_new_rec.BOM_RESOURCE_ID                          := :new.BOM_RESOURCE_ID                               ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.GOVERNMENT_CONTEXT                       := :new.GOVERNMENT_CONTEXT                            ;
    t_new_rec.CLOSED_REASON                            := :new.CLOSED_REASON                                 ;
    t_new_rec.CLOSED_DATE                              := :new.CLOSED_DATE                                   ;
    t_new_rec.TRANSACTION_REASON_CODE                  := :new.TRANSACTION_REASON_CODE                       ;
    t_new_rec.QUANTITY_RECEIVED                        := :new.QUANTITY_RECEIVED                             ;
    t_new_rec.SOURCE_REQ_LINE_ID                       := :new.SOURCE_REQ_LINE_ID                            ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
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
    t_new_rec.KANBAN_CARD_ID                           := :new.KANBAN_CARD_ID                                ;
    t_new_rec.CATALOG_TYPE                             := :new.CATALOG_TYPE                                  ;
    t_new_rec.CATALOG_SOURCE                           := :new.CATALOG_SOURCE                                ;
    t_new_rec.MANUFACTURER_ID                          := :new.MANUFACTURER_ID                               ;
    t_new_rec.MANUFACTURER_NAME                        := :new.MANUFACTURER_NAME                             ;
    t_new_rec.MANUFACTURER_PART_NUMBER                 := :new.MANUFACTURER_PART_NUMBER                      ;
    t_new_rec.REQUESTER_EMAIL                          := :new.REQUESTER_EMAIL                               ;
    t_new_rec.REQUESTER_FAX                            := :new.REQUESTER_FAX                                 ;
    t_new_rec.REQUESTER_PHONE                          := :new.REQUESTER_PHONE                               ;
    t_new_rec.UNSPSC_CODE                              := :new.UNSPSC_CODE                                   ;
    t_new_rec.OTHER_CATEGORY_CODE                      := :new.OTHER_CATEGORY_CODE                           ;
    t_new_rec.SUPPLIER_DUNS                            := :new.SUPPLIER_DUNS                                 ;
    t_new_rec.TAX_STATUS_INDICATOR                     := :new.TAX_STATUS_INDICATOR                          ;
    t_new_rec.PCARD_FLAG                               := :new.PCARD_FLAG                                    ;
    t_new_rec.NEW_SUPPLIER_FLAG                        := :new.NEW_SUPPLIER_FLAG                             ;
    t_new_rec.AUTO_RECEIVE_FLAG                        := :new.AUTO_RECEIVE_FLAG                             ;
    t_new_rec.TAX_USER_OVERRIDE_FLAG                   := :new.TAX_USER_OVERRIDE_FLAG                        ;
    t_new_rec.TAX_CODE_ID                              := :new.TAX_CODE_ID                                   ;
    t_new_rec.NOTE_TO_VENDOR                           := :new.NOTE_TO_VENDOR                                ;
    t_new_rec.OKE_CONTRACT_VERSION_ID                  := :new.OKE_CONTRACT_VERSION_ID                       ;
    t_new_rec.OKE_CONTRACT_HEADER_ID                   := :new.OKE_CONTRACT_HEADER_ID                        ;
    t_new_rec.ITEM_SOURCE_ID                           := :new.ITEM_SOURCE_ID                                ;
    t_new_rec.SUPPLIER_REF_NUMBER                      := :new.SUPPLIER_REF_NUMBER                           ;
    t_new_rec.SECONDARY_UNIT_OF_MEASURE                := :new.SECONDARY_UNIT_OF_MEASURE                     ;
    t_new_rec.SECONDARY_QUANTITY                       := :new.SECONDARY_QUANTITY                            ;
    t_new_rec.PREFERRED_GRADE                          := :new.PREFERRED_GRADE                               ;
    t_new_rec.SECONDARY_QUANTITY_RECEIVED              := :new.SECONDARY_QUANTITY_RECEIVED                   ;
    t_new_rec.SECONDARY_QUANTITY_CANCELLED             := :new.SECONDARY_QUANTITY_CANCELLED                  ;
    t_new_rec.VMI_FLAG                                 := :new.VMI_FLAG                                      ;
    t_new_rec.AUCTION_HEADER_ID                        := :new.AUCTION_HEADER_ID                             ;
    t_new_rec.AUCTION_DISPLAY_NUMBER                   := :new.AUCTION_DISPLAY_NUMBER                        ;
    t_new_rec.AUCTION_LINE_NUMBER                      := :new.AUCTION_LINE_NUMBER                           ;
    t_new_rec.REQS_IN_POOL_FLAG                        := :new.REQS_IN_POOL_FLAG                             ;
    t_new_rec.BID_NUMBER                               := :new.BID_NUMBER                                    ;
    t_new_rec.BID_LINE_NUMBER                          := :new.BID_LINE_NUMBER                               ;
    t_new_rec.NONCAT_TEMPLATE_ID                       := :new.NONCAT_TEMPLATE_ID                            ;
    t_new_rec.SUGGESTED_VENDOR_CONTACT_FAX             := :new.SUGGESTED_VENDOR_CONTACT_FAX                  ;
    t_new_rec.SUGGESTED_VENDOR_CONTACT_EMAIL           := :new.SUGGESTED_VENDOR_CONTACT_EMAIL                ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.CURRENCY_AMOUNT                          := :new.CURRENCY_AMOUNT                               ;
    t_new_rec.LABOR_REQ_LINE_ID                        := :new.LABOR_REQ_LINE_ID                             ;
    t_new_rec.JOB_ID                                   := :new.JOB_ID                                        ;
    t_new_rec.JOB_LONG_DESCRIPTION                     := :new.JOB_LONG_DESCRIPTION                          ;
    t_new_rec.CONTRACTOR_STATUS                        := :new.CONTRACTOR_STATUS                             ;
    t_new_rec.CONTACT_INFORMATION                      := :new.CONTACT_INFORMATION                           ;
    t_new_rec.SUGGESTED_SUPPLIER_FLAG                  := :new.SUGGESTED_SUPPLIER_FLAG                       ;
    t_new_rec.CANDIDATE_SCREENING_REQD_FLAG            := :new.CANDIDATE_SCREENING_REQD_FLAG                 ;
    t_new_rec.CANDIDATE_FIRST_NAME                     := :new.CANDIDATE_FIRST_NAME                          ;
    t_new_rec.CANDIDATE_LAST_NAME                      := :new.CANDIDATE_LAST_NAME                           ;
    t_new_rec.ASSIGNMENT_END_DATE                      := :new.ASSIGNMENT_END_DATE                           ;
    t_new_rec.OVERTIME_ALLOWED_FLAG                    := :new.OVERTIME_ALLOWED_FLAG                         ;
    t_new_rec.CONTRACTOR_REQUISITION_FLAG              := :new.CONTRACTOR_REQUISITION_FLAG                   ;
    t_new_rec.DROP_SHIP_FLAG                           := :new.DROP_SHIP_FLAG                                ;
    t_new_rec.ASSIGNMENT_START_DATE                    := :new.ASSIGNMENT_START_DATE                         ;
    t_new_rec.ORDER_TYPE_LOOKUP_CODE                   := :new.ORDER_TYPE_LOOKUP_CODE                        ;
    t_new_rec.PURCHASE_BASIS                           := :new.PURCHASE_BASIS                                ;
    t_new_rec.MATCHING_BASIS                           := :new.MATCHING_BASIS                                ;
    t_new_rec.NEGOTIATED_BY_PREPARER_FLAG              := :new.NEGOTIATED_BY_PREPARER_FLAG                   ;
    t_new_rec.SHIP_METHOD                              := :new.SHIP_METHOD                                   ;
    t_new_rec.ESTIMATED_PICKUP_DATE                    := :new.ESTIMATED_PICKUP_DATE                         ;
    t_new_rec.SUPPLIER_NOTIFIED_FOR_CANCEL             := :new.SUPPLIER_NOTIFIED_FOR_CANCEL                  ;
    t_new_rec.BASE_UNIT_PRICE                          := :new.BASE_UNIT_PRICE                               ;
    t_new_rec.AT_SOURCING_FLAG                         := :new.AT_SOURCING_FLAG                              ;
    t_new_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :new.TAX_ATTRIBUTE_UPDATE_CODE                     ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.REQUISITION_LINE_ID                      := :old.REQUISITION_LINE_ID                           ;
    t_old_rec.REQUISITION_HEADER_ID                    := :old.REQUISITION_HEADER_ID                         ;
    t_old_rec.LINE_NUM                                 := :old.LINE_NUM                                      ;
    t_old_rec.LINE_TYPE_ID                             := :old.LINE_TYPE_ID                                  ;
    t_old_rec.CATEGORY_ID                              := :old.CATEGORY_ID                                   ;
    t_old_rec.ITEM_DESCRIPTION                         := :old.ITEM_DESCRIPTION                              ;
    t_old_rec.UNIT_MEAS_LOOKUP_CODE                    := :old.UNIT_MEAS_LOOKUP_CODE                         ;
    t_old_rec.UNIT_PRICE                               := :old.UNIT_PRICE                                    ;
    t_old_rec.QUANTITY                                 := :old.QUANTITY                                      ;
    t_old_rec.DELIVER_TO_LOCATION_ID                   := :old.DELIVER_TO_LOCATION_ID                        ;
    t_old_rec.TO_PERSON_ID                             := :old.TO_PERSON_ID                                  ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.SOURCE_TYPE_CODE                         := :old.SOURCE_TYPE_CODE                              ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.ITEM_ID                                  := :old.ITEM_ID                                       ;
    t_old_rec.ITEM_REVISION                            := :old.ITEM_REVISION                                 ;
    t_old_rec.QUANTITY_DELIVERED                       := :old.QUANTITY_DELIVERED                            ;
    t_old_rec.SUGGESTED_BUYER_ID                       := :old.SUGGESTED_BUYER_ID                            ;
    t_old_rec.ENCUMBERED_FLAG                          := :old.ENCUMBERED_FLAG                               ;
    t_old_rec.RFQ_REQUIRED_FLAG                        := :old.RFQ_REQUIRED_FLAG                             ;
    t_old_rec.NEED_BY_DATE                             := :old.NEED_BY_DATE                                  ;
    t_old_rec.LINE_LOCATION_ID                         := :old.LINE_LOCATION_ID                              ;
    t_old_rec.MODIFIED_BY_AGENT_FLAG                   := :old.MODIFIED_BY_AGENT_FLAG                        ;
    t_old_rec.PARENT_REQ_LINE_ID                       := :old.PARENT_REQ_LINE_ID                            ;
    t_old_rec.JUSTIFICATION                            := :old.JUSTIFICATION                                 ;
    t_old_rec.NOTE_TO_AGENT                            := :old.NOTE_TO_AGENT                                 ;
    t_old_rec.NOTE_TO_RECEIVER                         := :old.NOTE_TO_RECEIVER                              ;
    t_old_rec.PURCHASING_AGENT_ID                      := :old.PURCHASING_AGENT_ID                           ;
    t_old_rec.DOCUMENT_TYPE_CODE                       := :old.DOCUMENT_TYPE_CODE                            ;
    t_old_rec.BLANKET_PO_HEADER_ID                     := :old.BLANKET_PO_HEADER_ID                          ;
    t_old_rec.BLANKET_PO_LINE_NUM                      := :old.BLANKET_PO_LINE_NUM                           ;
    t_old_rec.CURRENCY_CODE                            := :old.CURRENCY_CODE                                 ;
    t_old_rec.RATE_TYPE                                := :old.RATE_TYPE                                     ;
    t_old_rec.RATE_DATE                                := :old.RATE_DATE                                     ;
    t_old_rec.RATE                                     := :old.RATE                                          ;
    t_old_rec.CURRENCY_UNIT_PRICE                      := :old.CURRENCY_UNIT_PRICE                           ;
    t_old_rec.SUGGESTED_VENDOR_NAME                    := :old.SUGGESTED_VENDOR_NAME                         ;
    t_old_rec.SUGGESTED_VENDOR_LOCATION                := :old.SUGGESTED_VENDOR_LOCATION                     ;
    t_old_rec.SUGGESTED_VENDOR_CONTACT                 := :old.SUGGESTED_VENDOR_CONTACT                      ;
    t_old_rec.SUGGESTED_VENDOR_PHONE                   := :old.SUGGESTED_VENDOR_PHONE                        ;
    t_old_rec.SUGGESTED_VENDOR_PRODUCT_CODE            := :old.SUGGESTED_VENDOR_PRODUCT_CODE                 ;
    t_old_rec.UN_NUMBER_ID                             := :old.UN_NUMBER_ID                                  ;
    t_old_rec.HAZARD_CLASS_ID                          := :old.HAZARD_CLASS_ID                               ;
    t_old_rec.MUST_USE_SUGG_VENDOR_FLAG                := :old.MUST_USE_SUGG_VENDOR_FLAG                     ;
    t_old_rec.REFERENCE_NUM                            := :old.REFERENCE_NUM                                 ;
    t_old_rec.ON_RFQ_FLAG                              := :old.ON_RFQ_FLAG                                   ;
    t_old_rec.URGENT_FLAG                              := :old.URGENT_FLAG                                   ;
    t_old_rec.CANCEL_FLAG                              := :old.CANCEL_FLAG                                   ;
    t_old_rec.SOURCE_ORGANIZATION_ID                   := :old.SOURCE_ORGANIZATION_ID                        ;
    t_old_rec.SOURCE_SUBINVENTORY                      := :old.SOURCE_SUBINVENTORY                           ;
    t_old_rec.DESTINATION_TYPE_CODE                    := :old.DESTINATION_TYPE_CODE                         ;
    t_old_rec.DESTINATION_ORGANIZATION_ID              := :old.DESTINATION_ORGANIZATION_ID                   ;
    t_old_rec.DESTINATION_SUBINVENTORY                 := :old.DESTINATION_SUBINVENTORY                      ;
    t_old_rec.QUANTITY_CANCELLED                       := :old.QUANTITY_CANCELLED                            ;
    t_old_rec.CANCEL_DATE                              := :old.CANCEL_DATE                                   ;
    t_old_rec.CANCEL_REASON                            := :old.CANCEL_REASON                                 ;
    t_old_rec.CLOSED_CODE                              := :old.CLOSED_CODE                                   ;
    t_old_rec.AGENT_RETURN_NOTE                        := :old.AGENT_RETURN_NOTE                             ;
    t_old_rec.CHANGED_AFTER_RESEARCH_FLAG              := :old.CHANGED_AFTER_RESEARCH_FLAG                   ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.VENDOR_CONTACT_ID                        := :old.VENDOR_CONTACT_ID                             ;
    t_old_rec.RESEARCH_AGENT_ID                        := :old.RESEARCH_AGENT_ID                             ;
    t_old_rec.ON_LINE_FLAG                             := :old.ON_LINE_FLAG                                  ;
    t_old_rec.WIP_ENTITY_ID                            := :old.WIP_ENTITY_ID                                 ;
    t_old_rec.WIP_LINE_ID                              := :old.WIP_LINE_ID                                   ;
    t_old_rec.WIP_REPETITIVE_SCHEDULE_ID               := :old.WIP_REPETITIVE_SCHEDULE_ID                    ;
    t_old_rec.WIP_OPERATION_SEQ_NUM                    := :old.WIP_OPERATION_SEQ_NUM                         ;
    t_old_rec.WIP_RESOURCE_SEQ_NUM                     := :old.WIP_RESOURCE_SEQ_NUM                          ;
    t_old_rec.ATTRIBUTE_CATEGORY                       := :old.ATTRIBUTE_CATEGORY                            ;
    t_old_rec.DESTINATION_CONTEXT                      := :old.DESTINATION_CONTEXT                           ;
    t_old_rec.INVENTORY_SOURCE_CONTEXT                 := :old.INVENTORY_SOURCE_CONTEXT                      ;
    t_old_rec.VENDOR_SOURCE_CONTEXT                    := :old.VENDOR_SOURCE_CONTEXT                         ;
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
    t_old_rec.BOM_RESOURCE_ID                          := :old.BOM_RESOURCE_ID                               ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.GOVERNMENT_CONTEXT                       := :old.GOVERNMENT_CONTEXT                            ;
    t_old_rec.CLOSED_REASON                            := :old.CLOSED_REASON                                 ;
    t_old_rec.CLOSED_DATE                              := :old.CLOSED_DATE                                   ;
    t_old_rec.TRANSACTION_REASON_CODE                  := :old.TRANSACTION_REASON_CODE                       ;
    t_old_rec.QUANTITY_RECEIVED                        := :old.QUANTITY_RECEIVED                             ;
    t_old_rec.SOURCE_REQ_LINE_ID                       := :old.SOURCE_REQ_LINE_ID                            ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
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
    t_old_rec.KANBAN_CARD_ID                           := :old.KANBAN_CARD_ID                                ;
    t_old_rec.CATALOG_TYPE                             := :old.CATALOG_TYPE                                  ;
    t_old_rec.CATALOG_SOURCE                           := :old.CATALOG_SOURCE                                ;
    t_old_rec.MANUFACTURER_ID                          := :old.MANUFACTURER_ID                               ;
    t_old_rec.MANUFACTURER_NAME                        := :old.MANUFACTURER_NAME                             ;
    t_old_rec.MANUFACTURER_PART_NUMBER                 := :old.MANUFACTURER_PART_NUMBER                      ;
    t_old_rec.REQUESTER_EMAIL                          := :old.REQUESTER_EMAIL                               ;
    t_old_rec.REQUESTER_FAX                            := :old.REQUESTER_FAX                                 ;
    t_old_rec.REQUESTER_PHONE                          := :old.REQUESTER_PHONE                               ;
    t_old_rec.UNSPSC_CODE                              := :old.UNSPSC_CODE                                   ;
    t_old_rec.OTHER_CATEGORY_CODE                      := :old.OTHER_CATEGORY_CODE                           ;
    t_old_rec.SUPPLIER_DUNS                            := :old.SUPPLIER_DUNS                                 ;
    t_old_rec.TAX_STATUS_INDICATOR                     := :old.TAX_STATUS_INDICATOR                          ;
    t_old_rec.PCARD_FLAG                               := :old.PCARD_FLAG                                    ;
    t_old_rec.NEW_SUPPLIER_FLAG                        := :old.NEW_SUPPLIER_FLAG                             ;
    t_old_rec.AUTO_RECEIVE_FLAG                        := :old.AUTO_RECEIVE_FLAG                             ;
    t_old_rec.TAX_USER_OVERRIDE_FLAG                   := :old.TAX_USER_OVERRIDE_FLAG                        ;
    t_old_rec.TAX_CODE_ID                              := :old.TAX_CODE_ID                                   ;
    t_old_rec.NOTE_TO_VENDOR                           := :old.NOTE_TO_VENDOR                                ;
    t_old_rec.OKE_CONTRACT_VERSION_ID                  := :old.OKE_CONTRACT_VERSION_ID                       ;
    t_old_rec.OKE_CONTRACT_HEADER_ID                   := :old.OKE_CONTRACT_HEADER_ID                        ;
    t_old_rec.ITEM_SOURCE_ID                           := :old.ITEM_SOURCE_ID                                ;
    t_old_rec.SUPPLIER_REF_NUMBER                      := :old.SUPPLIER_REF_NUMBER                           ;
    t_old_rec.SECONDARY_UNIT_OF_MEASURE                := :old.SECONDARY_UNIT_OF_MEASURE                     ;
    t_old_rec.SECONDARY_QUANTITY                       := :old.SECONDARY_QUANTITY                            ;
    t_old_rec.PREFERRED_GRADE                          := :old.PREFERRED_GRADE                               ;
    t_old_rec.SECONDARY_QUANTITY_RECEIVED              := :old.SECONDARY_QUANTITY_RECEIVED                   ;
    t_old_rec.SECONDARY_QUANTITY_CANCELLED             := :old.SECONDARY_QUANTITY_CANCELLED                  ;
    t_old_rec.VMI_FLAG                                 := :old.VMI_FLAG                                      ;
    t_old_rec.AUCTION_HEADER_ID                        := :old.AUCTION_HEADER_ID                             ;
    t_old_rec.AUCTION_DISPLAY_NUMBER                   := :old.AUCTION_DISPLAY_NUMBER                        ;
    t_old_rec.AUCTION_LINE_NUMBER                      := :old.AUCTION_LINE_NUMBER                           ;
    t_old_rec.REQS_IN_POOL_FLAG                        := :old.REQS_IN_POOL_FLAG                             ;
    t_old_rec.BID_NUMBER                               := :old.BID_NUMBER                                    ;
    t_old_rec.BID_LINE_NUMBER                          := :old.BID_LINE_NUMBER                               ;
    t_old_rec.NONCAT_TEMPLATE_ID                       := :old.NONCAT_TEMPLATE_ID                            ;
    t_old_rec.SUGGESTED_VENDOR_CONTACT_FAX             := :old.SUGGESTED_VENDOR_CONTACT_FAX                  ;
    t_old_rec.SUGGESTED_VENDOR_CONTACT_EMAIL           := :old.SUGGESTED_VENDOR_CONTACT_EMAIL                ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.CURRENCY_AMOUNT                          := :old.CURRENCY_AMOUNT                               ;
    t_old_rec.LABOR_REQ_LINE_ID                        := :old.LABOR_REQ_LINE_ID                             ;
    t_old_rec.JOB_ID                                   := :old.JOB_ID                                        ;
    t_old_rec.JOB_LONG_DESCRIPTION                     := :old.JOB_LONG_DESCRIPTION                          ;
    t_old_rec.CONTRACTOR_STATUS                        := :old.CONTRACTOR_STATUS                             ;
    t_old_rec.CONTACT_INFORMATION                      := :old.CONTACT_INFORMATION                           ;
    t_old_rec.SUGGESTED_SUPPLIER_FLAG                  := :old.SUGGESTED_SUPPLIER_FLAG                       ;
    t_old_rec.CANDIDATE_SCREENING_REQD_FLAG            := :old.CANDIDATE_SCREENING_REQD_FLAG                 ;
    t_old_rec.CANDIDATE_FIRST_NAME                     := :old.CANDIDATE_FIRST_NAME                          ;
    t_old_rec.CANDIDATE_LAST_NAME                      := :old.CANDIDATE_LAST_NAME                           ;
    t_old_rec.ASSIGNMENT_END_DATE                      := :old.ASSIGNMENT_END_DATE                           ;
    t_old_rec.OVERTIME_ALLOWED_FLAG                    := :old.OVERTIME_ALLOWED_FLAG                         ;
    t_old_rec.CONTRACTOR_REQUISITION_FLAG              := :old.CONTRACTOR_REQUISITION_FLAG                   ;
    t_old_rec.DROP_SHIP_FLAG                           := :old.DROP_SHIP_FLAG                                ;
    t_old_rec.ASSIGNMENT_START_DATE                    := :old.ASSIGNMENT_START_DATE                         ;
    t_old_rec.ORDER_TYPE_LOOKUP_CODE                   := :old.ORDER_TYPE_LOOKUP_CODE                        ;
    t_old_rec.PURCHASE_BASIS                           := :old.PURCHASE_BASIS                                ;
    t_old_rec.MATCHING_BASIS                           := :old.MATCHING_BASIS                                ;
    t_old_rec.NEGOTIATED_BY_PREPARER_FLAG              := :old.NEGOTIATED_BY_PREPARER_FLAG                   ;
    t_old_rec.SHIP_METHOD                              := :old.SHIP_METHOD                                   ;
    t_old_rec.ESTIMATED_PICKUP_DATE                    := :old.ESTIMATED_PICKUP_DATE                         ;
    t_old_rec.SUPPLIER_NOTIFIED_FOR_CANCEL             := :old.SUPPLIER_NOTIFIED_FOR_CANCEL                  ;
    t_old_rec.BASE_UNIT_PRICE                          := :old.BASE_UNIT_PRICE                               ;
    t_old_rec.AT_SOURCING_FLAG                         := :old.AT_SOURCING_FLAG                              ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_RLA_ARIUD_T1',
		P_ORG_ID =>  nvl(:new.org_id, :old.org_id)) = FALSE THEN --/*5852041...Added nvl condition*/ pramasub FP
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

      JAI_PO_RLA_TRIGGER_PKG.ARI_T1 (
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

  IF DELETING THEN --pramasub FP start 115.10
	JAI_PO_RLA_TRIGGER_PKG.ARU_T2 (
							pr_old            =>  t_old_rec         ,
							pr_new            =>  t_new_rec         ,
							pv_action         =>  lv_action         ,
							pv_return_code    =>  lv_return_code    ,
							pv_return_message =>  lv_return_message
						  );
  END IF; --pramasub FP end; 115.10
  IF UPDATING THEN

    IF ( NVL( :OLD.line_location_id, -999 ) = -999 AND  :NEW.line_location_id IS NOT NULL ) THEN

      JAI_PO_RLA_TRIGGER_PKG.ARU_T1 (
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

    IF ( NVL( :OLD.Quantity, 0 ) <> NVL( :NEW.Quantity, 0 ) )
	OR ( NVL( :OLD.Unit_Price, 0 ) <> NVL( :NEW.Unit_Price, 0 ) )
	OR ( NVL( :OLD.Unit_Meas_Lookup_Code, 'X' ) <> NVL( :NEW.Unit_Meas_Lookup_Code, 'X' ) )
	OR ( NVL( :OLD.suggested_vendor_name, 'X' ) <> NVL( :NEW.suggested_vendor_name, 'X' ) )
	OR ( NVL( :OLD.suggested_vendor_location, 'X' ) <> NVL( :NEW.suggested_vendor_location, 'X' ) )
	OR ( NVL( :OLD.Destination_Organization_Id, 0 ) <> NVL( :NEW.Destination_Organization_Id, 0 ) ) THEN
	--OR ( NVL( :OLD.CURRENCY_CODE, 'X' ) <> NVL( :NEW.CURRENCY_CODE,' X' ) ) THEN

      JAI_PO_RLA_TRIGGER_PKG.ARU_T2 (
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
IF ( NVL( :OLD.CURRENCY_CODE, 'X' ) <> NVL( :NEW.CURRENCY_CODE,'X' ) ) THEN
      JAI_PO_RLA_TRIGGER_PKG.ARU_T3 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );

      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_RLA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_RLA_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_PO_RLA_ARIUD_T1" DISABLE;
