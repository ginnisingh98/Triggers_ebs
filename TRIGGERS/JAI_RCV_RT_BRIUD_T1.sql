--------------------------------------------------------
--  DDL for Trigger JAI_RCV_RT_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_RCV_RT_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "PO"."RCV_TRANSACTIONS"
FOR EACH ROW
DECLARE
  t_old_rec             RCV_TRANSACTIONS%rowtype ;
  t_new_rec             RCV_TRANSACTIONS%rowtype ;
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

    t_new_rec.TRANSACTION_ID                           := :new.TRANSACTION_ID                                ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.TRANSACTION_TYPE                         := :new.TRANSACTION_TYPE                              ;
    t_new_rec.TRANSACTION_DATE                         := :new.TRANSACTION_DATE                              ;
    t_new_rec.QUANTITY                                 := :new.QUANTITY                                      ;
    t_new_rec.UNIT_OF_MEASURE                          := :new.UNIT_OF_MEASURE                               ;
    t_new_rec.SHIPMENT_HEADER_ID                       := :new.SHIPMENT_HEADER_ID                            ;
    t_new_rec.SHIPMENT_LINE_ID                         := :new.SHIPMENT_LINE_ID                              ;
    t_new_rec.USER_ENTERED_FLAG                        := :new.USER_ENTERED_FLAG                             ;
    t_new_rec.INTERFACE_SOURCE_CODE                    := :new.INTERFACE_SOURCE_CODE                         ;
    t_new_rec.INTERFACE_SOURCE_LINE_ID                 := :new.INTERFACE_SOURCE_LINE_ID                      ;
    t_new_rec.INV_TRANSACTION_ID                       := :new.INV_TRANSACTION_ID                            ;
    t_new_rec.SOURCE_DOCUMENT_CODE                     := :new.SOURCE_DOCUMENT_CODE                          ;
    t_new_rec.DESTINATION_TYPE_CODE                    := :new.DESTINATION_TYPE_CODE                         ;
    t_new_rec.PRIMARY_QUANTITY                         := :new.PRIMARY_QUANTITY                              ;
    t_new_rec.PRIMARY_UNIT_OF_MEASURE                  := :new.PRIMARY_UNIT_OF_MEASURE                       ;
    t_new_rec.UOM_CODE                                 := :new.UOM_CODE                                      ;
    t_new_rec.EMPLOYEE_ID                              := :new.EMPLOYEE_ID                                   ;
    t_new_rec.PARENT_TRANSACTION_ID                    := :new.PARENT_TRANSACTION_ID                         ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.PO_RELEASE_ID                            := :new.PO_RELEASE_ID                                 ;
    t_new_rec.PO_LINE_ID                               := :new.PO_LINE_ID                                    ;
    t_new_rec.PO_LINE_LOCATION_ID                      := :new.PO_LINE_LOCATION_ID                           ;
    t_new_rec.PO_DISTRIBUTION_ID                       := :new.PO_DISTRIBUTION_ID                            ;
    t_new_rec.PO_REVISION_NUM                          := :new.PO_REVISION_NUM                               ;
    t_new_rec.REQUISITION_LINE_ID                      := :new.REQUISITION_LINE_ID                           ;
    t_new_rec.PO_UNIT_PRICE                            := :new.PO_UNIT_PRICE                                 ;
    t_new_rec.CURRENCY_CODE                            := :new.CURRENCY_CODE                                 ;
    t_new_rec.CURRENCY_CONVERSION_TYPE                 := :new.CURRENCY_CONVERSION_TYPE                      ;
    t_new_rec.CURRENCY_CONVERSION_RATE                 := :new.CURRENCY_CONVERSION_RATE                      ;
    t_new_rec.CURRENCY_CONVERSION_DATE                 := :new.CURRENCY_CONVERSION_DATE                      ;
    t_new_rec.ROUTING_HEADER_ID                        := :new.ROUTING_HEADER_ID                             ;
    t_new_rec.ROUTING_STEP_ID                          := :new.ROUTING_STEP_ID                               ;
    t_new_rec.DELIVER_TO_PERSON_ID                     := :new.DELIVER_TO_PERSON_ID                          ;
    t_new_rec.DELIVER_TO_LOCATION_ID                   := :new.DELIVER_TO_LOCATION_ID                        ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.ORGANIZATION_ID                          := :new.ORGANIZATION_ID                               ;
    t_new_rec.SUBINVENTORY                             := :new.SUBINVENTORY                                  ;
    t_new_rec.LOCATOR_ID                               := :new.LOCATOR_ID                                    ;
    t_new_rec.WIP_ENTITY_ID                            := :new.WIP_ENTITY_ID                                 ;
    t_new_rec.WIP_LINE_ID                              := :new.WIP_LINE_ID                                   ;
    t_new_rec.WIP_REPETITIVE_SCHEDULE_ID               := :new.WIP_REPETITIVE_SCHEDULE_ID                    ;
    t_new_rec.WIP_OPERATION_SEQ_NUM                    := :new.WIP_OPERATION_SEQ_NUM                         ;
    t_new_rec.WIP_RESOURCE_SEQ_NUM                     := :new.WIP_RESOURCE_SEQ_NUM                          ;
    t_new_rec.BOM_RESOURCE_ID                          := :new.BOM_RESOURCE_ID                               ;
    t_new_rec.LOCATION_ID                              := :new.LOCATION_ID                                   ;
    t_new_rec.SUBSTITUTE_UNORDERED_CODE                := :new.SUBSTITUTE_UNORDERED_CODE                     ;
    t_new_rec.RECEIPT_EXCEPTION_FLAG                   := :new.RECEIPT_EXCEPTION_FLAG                        ;
    t_new_rec.INSPECTION_STATUS_CODE                   := :new.INSPECTION_STATUS_CODE                        ;
    t_new_rec.ACCRUAL_STATUS_CODE                      := :new.ACCRUAL_STATUS_CODE                           ;
    t_new_rec.INSPECTION_QUALITY_CODE                  := :new.INSPECTION_QUALITY_CODE                       ;
    t_new_rec.VENDOR_LOT_NUM                           := :new.VENDOR_LOT_NUM                                ;
    t_new_rec.RMA_REFERENCE                            := :new.RMA_REFERENCE                                 ;
    t_new_rec.COMMENTS                                 := :new.COMMENTS                                      ;
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
    t_new_rec.REQ_DISTRIBUTION_ID                      := :new.REQ_DISTRIBUTION_ID                           ;
    t_new_rec.DEPARTMENT_CODE                          := :new.DEPARTMENT_CODE                               ;
    t_new_rec.REASON_ID                                := :new.REASON_ID                                     ;
    t_new_rec.DESTINATION_CONTEXT                      := :new.DESTINATION_CONTEXT                           ;
    t_new_rec.LOCATOR_ATTRIBUTE                        := :new.LOCATOR_ATTRIBUTE                             ;
    t_new_rec.CHILD_INSPECTION_FLAG                    := :new.CHILD_INSPECTION_FLAG                         ;
    t_new_rec.SOURCE_DOC_UNIT_OF_MEASURE               := :new.SOURCE_DOC_UNIT_OF_MEASURE                    ;
    t_new_rec.SOURCE_DOC_QUANTITY                      := :new.SOURCE_DOC_QUANTITY                           ;
    t_new_rec.INTERFACE_TRANSACTION_ID                 := :new.INTERFACE_TRANSACTION_ID                      ;
    t_new_rec.GROUP_ID                                 := :new.GROUP_ID                                      ;
    t_new_rec.MOVEMENT_ID                              := :new.MOVEMENT_ID                                   ;
    t_new_rec.INVOICE_ID                               := :new.INVOICE_ID                                    ;
    t_new_rec.INVOICE_STATUS_CODE                      := :new.INVOICE_STATUS_CODE                           ;
    t_new_rec.QA_COLLECTION_ID                         := :new.QA_COLLECTION_ID                              ;
    t_new_rec.MRC_CURRENCY_CONVERSION_TYPE             := :new.MRC_CURRENCY_CONVERSION_TYPE                  ;
    t_new_rec.MRC_CURRENCY_CONVERSION_DATE             := :new.MRC_CURRENCY_CONVERSION_DATE                  ;
    t_new_rec.MRC_CURRENCY_CONVERSION_RATE             := :new.MRC_CURRENCY_CONVERSION_RATE                  ;
    t_new_rec.COUNTRY_OF_ORIGIN_CODE                   := :new.COUNTRY_OF_ORIGIN_CODE                        ;
    t_new_rec.MVT_STAT_STATUS                          := :new.MVT_STAT_STATUS                               ;
    t_new_rec.QUANTITY_BILLED                          := :new.QUANTITY_BILLED                               ;
    t_new_rec.MATCH_FLAG                               := :new.MATCH_FLAG                                    ;
    t_new_rec.AMOUNT_BILLED                            := :new.AMOUNT_BILLED                                 ;
    t_new_rec.MATCH_OPTION                             := :new.MATCH_OPTION                                  ;
    t_new_rec.OE_ORDER_HEADER_ID                       := :new.OE_ORDER_HEADER_ID                            ;
    t_new_rec.OE_ORDER_LINE_ID                         := :new.OE_ORDER_LINE_ID                              ;
    t_new_rec.CUSTOMER_ID                              := :new.CUSTOMER_ID                                   ;
    t_new_rec.CUSTOMER_SITE_ID                         := :new.CUSTOMER_SITE_ID                              ;
    t_new_rec.LPN_ID                                   := :new.LPN_ID                                        ;
    t_new_rec.TRANSFER_LPN_ID                          := :new.TRANSFER_LPN_ID                               ;
    t_new_rec.MOBILE_TXN                               := :new.MOBILE_TXN                                    ;
    t_new_rec.SECONDARY_QUANTITY                       := :new.SECONDARY_QUANTITY                            ;
    t_new_rec.SECONDARY_UNIT_OF_MEASURE                := :new.SECONDARY_UNIT_OF_MEASURE                     ;
    t_new_rec.QC_GRADE                                 := :new.QC_GRADE                                      ;
    t_new_rec.SECONDARY_UOM_CODE                       := :new.SECONDARY_UOM_CODE                            ;
    t_new_rec.PA_ADDITION_FLAG                         := :new.PA_ADDITION_FLAG                              ;
    t_new_rec.CONSIGNED_FLAG                           := :new.CONSIGNED_FLAG                                ;
    t_new_rec.SOURCE_TRANSACTION_NUM                   := :new.SOURCE_TRANSACTION_NUM                        ;
    t_new_rec.FROM_SUBINVENTORY                        := :new.FROM_SUBINVENTORY                             ;
    t_new_rec.FROM_LOCATOR_ID                          := :new.FROM_LOCATOR_ID                               ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.DROPSHIP_TYPE_CODE                       := :new.DROPSHIP_TYPE_CODE                            ;
    t_new_rec.LPN_GROUP_ID                             := :new.LPN_GROUP_ID                                  ;
    t_new_rec.JOB_ID                                   := :new.JOB_ID                                        ;
    t_new_rec.TIMECARD_ID                              := :new.TIMECARD_ID                                   ;
    t_new_rec.TIMECARD_OVN                             := :new.TIMECARD_OVN                                  ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
   --Reverted the change in R12  t_new_rec.group_id                                 := :new.group_id ; /*Added by nprashar for bug # 8566481, FP  from 8594501 */
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.TRANSACTION_ID                           := :old.TRANSACTION_ID                                ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.TRANSACTION_TYPE                         := :old.TRANSACTION_TYPE                              ;
    t_old_rec.TRANSACTION_DATE                         := :old.TRANSACTION_DATE                              ;
    t_old_rec.QUANTITY                                 := :old.QUANTITY                                      ;
    t_old_rec.UNIT_OF_MEASURE                          := :old.UNIT_OF_MEASURE                               ;
    t_old_rec.SHIPMENT_HEADER_ID                       := :old.SHIPMENT_HEADER_ID                            ;
    t_old_rec.SHIPMENT_LINE_ID                         := :old.SHIPMENT_LINE_ID                              ;
    t_old_rec.USER_ENTERED_FLAG                        := :old.USER_ENTERED_FLAG                             ;
    t_old_rec.INTERFACE_SOURCE_CODE                    := :old.INTERFACE_SOURCE_CODE                         ;
    t_old_rec.INTERFACE_SOURCE_LINE_ID                 := :old.INTERFACE_SOURCE_LINE_ID                      ;
    t_old_rec.INV_TRANSACTION_ID                       := :old.INV_TRANSACTION_ID                            ;
    t_old_rec.SOURCE_DOCUMENT_CODE                     := :old.SOURCE_DOCUMENT_CODE                          ;
    t_old_rec.DESTINATION_TYPE_CODE                    := :old.DESTINATION_TYPE_CODE                         ;
    t_old_rec.PRIMARY_QUANTITY                         := :old.PRIMARY_QUANTITY                              ;
    t_old_rec.PRIMARY_UNIT_OF_MEASURE                  := :old.PRIMARY_UNIT_OF_MEASURE                       ;
    t_old_rec.UOM_CODE                                 := :old.UOM_CODE                                      ;
    t_old_rec.EMPLOYEE_ID                              := :old.EMPLOYEE_ID                                   ;
    t_old_rec.PARENT_TRANSACTION_ID                    := :old.PARENT_TRANSACTION_ID                         ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.PO_RELEASE_ID                            := :old.PO_RELEASE_ID                                 ;
    t_old_rec.PO_LINE_ID                               := :old.PO_LINE_ID                                    ;
    t_old_rec.PO_LINE_LOCATION_ID                      := :old.PO_LINE_LOCATION_ID                           ;
    t_old_rec.PO_DISTRIBUTION_ID                       := :old.PO_DISTRIBUTION_ID                            ;
    t_old_rec.PO_REVISION_NUM                          := :old.PO_REVISION_NUM                               ;
    t_old_rec.REQUISITION_LINE_ID                      := :old.REQUISITION_LINE_ID                           ;
    t_old_rec.PO_UNIT_PRICE                            := :old.PO_UNIT_PRICE                                 ;
    t_old_rec.CURRENCY_CODE                            := :old.CURRENCY_CODE                                 ;
    t_old_rec.CURRENCY_CONVERSION_TYPE                 := :old.CURRENCY_CONVERSION_TYPE                      ;
    t_old_rec.CURRENCY_CONVERSION_RATE                 := :old.CURRENCY_CONVERSION_RATE                      ;
    t_old_rec.CURRENCY_CONVERSION_DATE                 := :old.CURRENCY_CONVERSION_DATE                      ;
    t_old_rec.ROUTING_HEADER_ID                        := :old.ROUTING_HEADER_ID                             ;
    t_old_rec.ROUTING_STEP_ID                          := :old.ROUTING_STEP_ID                               ;
    t_old_rec.DELIVER_TO_PERSON_ID                     := :old.DELIVER_TO_PERSON_ID                          ;
    t_old_rec.DELIVER_TO_LOCATION_ID                   := :old.DELIVER_TO_LOCATION_ID                        ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.ORGANIZATION_ID                          := :old.ORGANIZATION_ID                               ;
    t_old_rec.SUBINVENTORY                             := :old.SUBINVENTORY                                  ;
    t_old_rec.LOCATOR_ID                               := :old.LOCATOR_ID                                    ;
    t_old_rec.WIP_ENTITY_ID                            := :old.WIP_ENTITY_ID                                 ;
    t_old_rec.WIP_LINE_ID                              := :old.WIP_LINE_ID                                   ;
    t_old_rec.WIP_REPETITIVE_SCHEDULE_ID               := :old.WIP_REPETITIVE_SCHEDULE_ID                    ;
    t_old_rec.WIP_OPERATION_SEQ_NUM                    := :old.WIP_OPERATION_SEQ_NUM                         ;
    t_old_rec.WIP_RESOURCE_SEQ_NUM                     := :old.WIP_RESOURCE_SEQ_NUM                          ;
    t_old_rec.BOM_RESOURCE_ID                          := :old.BOM_RESOURCE_ID                               ;
    t_old_rec.LOCATION_ID                              := :old.LOCATION_ID                                   ;
    t_old_rec.SUBSTITUTE_UNORDERED_CODE                := :old.SUBSTITUTE_UNORDERED_CODE                     ;
    t_old_rec.RECEIPT_EXCEPTION_FLAG                   := :old.RECEIPT_EXCEPTION_FLAG                        ;
    t_old_rec.INSPECTION_STATUS_CODE                   := :old.INSPECTION_STATUS_CODE                        ;
    t_old_rec.ACCRUAL_STATUS_CODE                      := :old.ACCRUAL_STATUS_CODE                           ;
    t_old_rec.INSPECTION_QUALITY_CODE                  := :old.INSPECTION_QUALITY_CODE                       ;
    t_old_rec.VENDOR_LOT_NUM                           := :old.VENDOR_LOT_NUM                                ;
    t_old_rec.RMA_REFERENCE                            := :old.RMA_REFERENCE                                 ;
    t_old_rec.COMMENTS                                 := :old.COMMENTS                                      ;
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
    t_old_rec.REQ_DISTRIBUTION_ID                      := :old.REQ_DISTRIBUTION_ID                           ;
    t_old_rec.DEPARTMENT_CODE                          := :old.DEPARTMENT_CODE                               ;
    t_old_rec.REASON_ID                                := :old.REASON_ID                                     ;
    t_old_rec.DESTINATION_CONTEXT                      := :old.DESTINATION_CONTEXT                           ;
    t_old_rec.LOCATOR_ATTRIBUTE                        := :old.LOCATOR_ATTRIBUTE                             ;
    t_old_rec.CHILD_INSPECTION_FLAG                    := :old.CHILD_INSPECTION_FLAG                         ;
    t_old_rec.SOURCE_DOC_UNIT_OF_MEASURE               := :old.SOURCE_DOC_UNIT_OF_MEASURE                    ;
    t_old_rec.SOURCE_DOC_QUANTITY                      := :old.SOURCE_DOC_QUANTITY                           ;
    t_old_rec.INTERFACE_TRANSACTION_ID                 := :old.INTERFACE_TRANSACTION_ID                      ;
    t_old_rec.GROUP_ID                                 := :old.GROUP_ID                                      ;
    t_old_rec.MOVEMENT_ID                              := :old.MOVEMENT_ID                                   ;
    t_old_rec.INVOICE_ID                               := :old.INVOICE_ID                                    ;
    t_old_rec.INVOICE_STATUS_CODE                      := :old.INVOICE_STATUS_CODE                           ;
    t_old_rec.QA_COLLECTION_ID                         := :old.QA_COLLECTION_ID                              ;
    t_old_rec.MRC_CURRENCY_CONVERSION_TYPE             := :old.MRC_CURRENCY_CONVERSION_TYPE                  ;
    t_old_rec.MRC_CURRENCY_CONVERSION_DATE             := :old.MRC_CURRENCY_CONVERSION_DATE                  ;
    t_old_rec.MRC_CURRENCY_CONVERSION_RATE             := :old.MRC_CURRENCY_CONVERSION_RATE                  ;
    t_old_rec.COUNTRY_OF_ORIGIN_CODE                   := :old.COUNTRY_OF_ORIGIN_CODE                        ;
    t_old_rec.MVT_STAT_STATUS                          := :old.MVT_STAT_STATUS                               ;
    t_old_rec.QUANTITY_BILLED                          := :old.QUANTITY_BILLED                               ;
    t_old_rec.MATCH_FLAG                               := :old.MATCH_FLAG                                    ;
    t_old_rec.AMOUNT_BILLED                            := :old.AMOUNT_BILLED                                 ;
    t_old_rec.MATCH_OPTION                             := :old.MATCH_OPTION                                  ;
    t_old_rec.OE_ORDER_HEADER_ID                       := :old.OE_ORDER_HEADER_ID                            ;
    t_old_rec.OE_ORDER_LINE_ID                         := :old.OE_ORDER_LINE_ID                              ;
    t_old_rec.CUSTOMER_ID                              := :old.CUSTOMER_ID                                   ;
    t_old_rec.CUSTOMER_SITE_ID                         := :old.CUSTOMER_SITE_ID                              ;
    t_old_rec.LPN_ID                                   := :old.LPN_ID                                        ;
    t_old_rec.TRANSFER_LPN_ID                          := :old.TRANSFER_LPN_ID                               ;
    t_old_rec.MOBILE_TXN                               := :old.MOBILE_TXN                                    ;
    t_old_rec.SECONDARY_QUANTITY                       := :old.SECONDARY_QUANTITY                            ;
    t_old_rec.SECONDARY_UNIT_OF_MEASURE                := :old.SECONDARY_UNIT_OF_MEASURE                     ;
    t_old_rec.QC_GRADE                                 := :old.QC_GRADE                                      ;
    t_old_rec.SECONDARY_UOM_CODE                       := :old.SECONDARY_UOM_CODE                            ;
    t_old_rec.PA_ADDITION_FLAG                         := :old.PA_ADDITION_FLAG                              ;
    t_old_rec.CONSIGNED_FLAG                           := :old.CONSIGNED_FLAG                                ;
    t_old_rec.SOURCE_TRANSACTION_NUM                   := :old.SOURCE_TRANSACTION_NUM                        ;
    t_old_rec.FROM_SUBINVENTORY                        := :old.FROM_SUBINVENTORY                             ;
    t_old_rec.FROM_LOCATOR_ID                          := :old.FROM_LOCATOR_ID                               ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.DROPSHIP_TYPE_CODE                       := :old.DROPSHIP_TYPE_CODE                            ;
    t_old_rec.LPN_GROUP_ID                             := :old.LPN_GROUP_ID                                  ;
    t_old_rec.JOB_ID                                   := :old.JOB_ID                                        ;
    t_old_rec.TIMECARD_ID                              := :old.TIMECARD_ID                                   ;
    t_old_rec.TIMECARD_OVN                             := :old.TIMECARD_OVN                                  ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
  END populate_old ;

    /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.TRANSACTION_ID                           := t_new_rec.TRANSACTION_ID                                ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.REQUEST_ID                               := t_new_rec.REQUEST_ID                                    ;
    :new.PROGRAM_APPLICATION_ID                   := t_new_rec.PROGRAM_APPLICATION_ID                        ;
    :new.PROGRAM_ID                               := t_new_rec.PROGRAM_ID                                    ;
    :new.PROGRAM_UPDATE_DATE                      := t_new_rec.PROGRAM_UPDATE_DATE                           ;
    :new.TRANSACTION_TYPE                         := t_new_rec.TRANSACTION_TYPE                              ;
    :new.TRANSACTION_DATE                         := t_new_rec.TRANSACTION_DATE                              ;
    :new.QUANTITY                                 := t_new_rec.QUANTITY                                      ;
    :new.UNIT_OF_MEASURE                          := t_new_rec.UNIT_OF_MEASURE                               ;
    :new.SHIPMENT_HEADER_ID                       := t_new_rec.SHIPMENT_HEADER_ID                            ;
    :new.SHIPMENT_LINE_ID                         := t_new_rec.SHIPMENT_LINE_ID                              ;
    :new.USER_ENTERED_FLAG                        := t_new_rec.USER_ENTERED_FLAG                             ;
    :new.INTERFACE_SOURCE_CODE                    := t_new_rec.INTERFACE_SOURCE_CODE                         ;
    :new.INTERFACE_SOURCE_LINE_ID                 := t_new_rec.INTERFACE_SOURCE_LINE_ID                      ;
    :new.INV_TRANSACTION_ID                       := t_new_rec.INV_TRANSACTION_ID                            ;
    :new.SOURCE_DOCUMENT_CODE                     := t_new_rec.SOURCE_DOCUMENT_CODE                          ;
    :new.DESTINATION_TYPE_CODE                    := t_new_rec.DESTINATION_TYPE_CODE                         ;
    :new.PRIMARY_QUANTITY                         := t_new_rec.PRIMARY_QUANTITY                              ;
    :new.PRIMARY_UNIT_OF_MEASURE                  := t_new_rec.PRIMARY_UNIT_OF_MEASURE                       ;
    :new.UOM_CODE                                 := t_new_rec.UOM_CODE                                      ;
    :new.EMPLOYEE_ID                              := t_new_rec.EMPLOYEE_ID                                   ;
    :new.PARENT_TRANSACTION_ID                    := t_new_rec.PARENT_TRANSACTION_ID                         ;
    :new.PO_HEADER_ID                             := t_new_rec.PO_HEADER_ID                                  ;
    :new.PO_RELEASE_ID                            := t_new_rec.PO_RELEASE_ID                                 ;
    :new.PO_LINE_ID                               := t_new_rec.PO_LINE_ID                                    ;
    :new.PO_LINE_LOCATION_ID                      := t_new_rec.PO_LINE_LOCATION_ID                           ;
    :new.PO_DISTRIBUTION_ID                       := t_new_rec.PO_DISTRIBUTION_ID                            ;
    :new.PO_REVISION_NUM                          := t_new_rec.PO_REVISION_NUM                               ;
    :new.REQUISITION_LINE_ID                      := t_new_rec.REQUISITION_LINE_ID                           ;
    :new.PO_UNIT_PRICE                            := t_new_rec.PO_UNIT_PRICE                                 ;
    :new.CURRENCY_CODE                            := t_new_rec.CURRENCY_CODE                                 ;
    :new.CURRENCY_CONVERSION_TYPE                 := t_new_rec.CURRENCY_CONVERSION_TYPE                      ;
    :new.CURRENCY_CONVERSION_RATE                 := t_new_rec.CURRENCY_CONVERSION_RATE                      ;
    :new.CURRENCY_CONVERSION_DATE                 := t_new_rec.CURRENCY_CONVERSION_DATE                      ;
    :new.ROUTING_HEADER_ID                        := t_new_rec.ROUTING_HEADER_ID                             ;
    :new.ROUTING_STEP_ID                          := t_new_rec.ROUTING_STEP_ID                               ;
    :new.DELIVER_TO_PERSON_ID                     := t_new_rec.DELIVER_TO_PERSON_ID                          ;
    :new.DELIVER_TO_LOCATION_ID                   := t_new_rec.DELIVER_TO_LOCATION_ID                        ;
    :new.VENDOR_ID                                := t_new_rec.VENDOR_ID                                     ;
    :new.VENDOR_SITE_ID                           := t_new_rec.VENDOR_SITE_ID                                ;
    :new.ORGANIZATION_ID                          := t_new_rec.ORGANIZATION_ID                               ;
    :new.SUBINVENTORY                             := t_new_rec.SUBINVENTORY                                  ;
    :new.LOCATOR_ID                               := t_new_rec.LOCATOR_ID                                    ;
    :new.WIP_ENTITY_ID                            := t_new_rec.WIP_ENTITY_ID                                 ;
    :new.WIP_LINE_ID                              := t_new_rec.WIP_LINE_ID                                   ;
    :new.WIP_REPETITIVE_SCHEDULE_ID               := t_new_rec.WIP_REPETITIVE_SCHEDULE_ID                    ;
    :new.WIP_OPERATION_SEQ_NUM                    := t_new_rec.WIP_OPERATION_SEQ_NUM                         ;
    :new.WIP_RESOURCE_SEQ_NUM                     := t_new_rec.WIP_RESOURCE_SEQ_NUM                          ;
    :new.BOM_RESOURCE_ID                          := t_new_rec.BOM_RESOURCE_ID                               ;
    :new.LOCATION_ID                              := t_new_rec.LOCATION_ID                                   ;
    :new.SUBSTITUTE_UNORDERED_CODE                := t_new_rec.SUBSTITUTE_UNORDERED_CODE                     ;
    :new.RECEIPT_EXCEPTION_FLAG                   := t_new_rec.RECEIPT_EXCEPTION_FLAG                        ;
    :new.INSPECTION_STATUS_CODE                   := t_new_rec.INSPECTION_STATUS_CODE                        ;
    :new.ACCRUAL_STATUS_CODE                      := t_new_rec.ACCRUAL_STATUS_CODE                           ;
    :new.INSPECTION_QUALITY_CODE                  := t_new_rec.INSPECTION_QUALITY_CODE                       ;
    :new.VENDOR_LOT_NUM                           := t_new_rec.VENDOR_LOT_NUM                                ;
    :new.RMA_REFERENCE                            := t_new_rec.RMA_REFERENCE                                 ;
    :new.COMMENTS                                 := t_new_rec.COMMENTS                                      ;
    :new.ATTRIBUTE_CATEGORY                       := t_new_rec.ATTRIBUTE_CATEGORY                            ;
    :new.ATTRIBUTE1                               := t_new_rec.ATTRIBUTE1                                    ;
    :new.ATTRIBUTE2                               := t_new_rec.ATTRIBUTE2                                    ;
    :new.ATTRIBUTE3                               := t_new_rec.ATTRIBUTE3                                    ;
    :new.ATTRIBUTE4                               := t_new_rec.ATTRIBUTE4                                    ;
    :new.ATTRIBUTE5                               := t_new_rec.ATTRIBUTE5                                    ;
    :new.ATTRIBUTE6                               := t_new_rec.ATTRIBUTE6                                    ;
    :new.ATTRIBUTE7                               := t_new_rec.ATTRIBUTE7                                    ;
    :new.ATTRIBUTE8                               := t_new_rec.ATTRIBUTE8                                    ;
    :new.ATTRIBUTE9                               := t_new_rec.ATTRIBUTE9                                    ;
    :new.ATTRIBUTE10                              := t_new_rec.ATTRIBUTE10                                   ;
    :new.ATTRIBUTE11                              := t_new_rec.ATTRIBUTE11                                   ;
    :new.ATTRIBUTE12                              := t_new_rec.ATTRIBUTE12                                   ;
    :new.ATTRIBUTE13                              := t_new_rec.ATTRIBUTE13                                   ;
    :new.ATTRIBUTE14                              := t_new_rec.ATTRIBUTE14                                   ;
    :new.ATTRIBUTE15                              := t_new_rec.ATTRIBUTE15                                   ;
    :new.REQ_DISTRIBUTION_ID                      := t_new_rec.REQ_DISTRIBUTION_ID                           ;
    :new.DEPARTMENT_CODE                          := t_new_rec.DEPARTMENT_CODE                               ;
    :new.REASON_ID                                := t_new_rec.REASON_ID                                     ;
    :new.DESTINATION_CONTEXT                      := t_new_rec.DESTINATION_CONTEXT                           ;
    :new.LOCATOR_ATTRIBUTE                        := t_new_rec.LOCATOR_ATTRIBUTE                             ;
    :new.CHILD_INSPECTION_FLAG                    := t_new_rec.CHILD_INSPECTION_FLAG                         ;
    :new.SOURCE_DOC_UNIT_OF_MEASURE               := t_new_rec.SOURCE_DOC_UNIT_OF_MEASURE                    ;
    :new.SOURCE_DOC_QUANTITY                      := t_new_rec.SOURCE_DOC_QUANTITY                           ;
    :new.INTERFACE_TRANSACTION_ID                 := t_new_rec.INTERFACE_TRANSACTION_ID                      ;
    :new.GROUP_ID                                 := t_new_rec.GROUP_ID                                      ;
    :new.MOVEMENT_ID                              := t_new_rec.MOVEMENT_ID                                   ;
    :new.INVOICE_ID                               := t_new_rec.INVOICE_ID                                    ;
    :new.INVOICE_STATUS_CODE                      := t_new_rec.INVOICE_STATUS_CODE                           ;
    :new.QA_COLLECTION_ID                         := t_new_rec.QA_COLLECTION_ID                              ;
    :new.MRC_CURRENCY_CONVERSION_TYPE             := t_new_rec.MRC_CURRENCY_CONVERSION_TYPE                  ;
    :new.MRC_CURRENCY_CONVERSION_DATE             := t_new_rec.MRC_CURRENCY_CONVERSION_DATE                  ;
    :new.MRC_CURRENCY_CONVERSION_RATE             := t_new_rec.MRC_CURRENCY_CONVERSION_RATE                  ;
    :new.COUNTRY_OF_ORIGIN_CODE                   := t_new_rec.COUNTRY_OF_ORIGIN_CODE                        ;
    :new.MVT_STAT_STATUS                          := t_new_rec.MVT_STAT_STATUS                               ;
    :new.QUANTITY_BILLED                          := t_new_rec.QUANTITY_BILLED                               ;
    :new.MATCH_FLAG                               := t_new_rec.MATCH_FLAG                                    ;
    :new.AMOUNT_BILLED                            := t_new_rec.AMOUNT_BILLED                                 ;
    :new.MATCH_OPTION                             := t_new_rec.MATCH_OPTION                                  ;
    :new.OE_ORDER_HEADER_ID                       := t_new_rec.OE_ORDER_HEADER_ID                            ;
    :new.OE_ORDER_LINE_ID                         := t_new_rec.OE_ORDER_LINE_ID                              ;
    :new.CUSTOMER_ID                              := t_new_rec.CUSTOMER_ID                                   ;
    :new.CUSTOMER_SITE_ID                         := t_new_rec.CUSTOMER_SITE_ID                              ;
    :new.LPN_ID                                   := t_new_rec.LPN_ID                                        ;
    :new.TRANSFER_LPN_ID                          := t_new_rec.TRANSFER_LPN_ID                               ;
    :new.MOBILE_TXN                               := t_new_rec.MOBILE_TXN                                    ;
    :new.SECONDARY_QUANTITY                       := t_new_rec.SECONDARY_QUANTITY                            ;
    :new.SECONDARY_UNIT_OF_MEASURE                := t_new_rec.SECONDARY_UNIT_OF_MEASURE                     ;
    :new.QC_GRADE                                 := t_new_rec.QC_GRADE                                      ;
    :new.SECONDARY_UOM_CODE                       := t_new_rec.SECONDARY_UOM_CODE                            ;
    :new.PA_ADDITION_FLAG                         := t_new_rec.PA_ADDITION_FLAG                              ;
    :new.CONSIGNED_FLAG                           := t_new_rec.CONSIGNED_FLAG                                ;
    :new.SOURCE_TRANSACTION_NUM                   := t_new_rec.SOURCE_TRANSACTION_NUM                        ;
    :new.FROM_SUBINVENTORY                        := t_new_rec.FROM_SUBINVENTORY                             ;
    :new.FROM_LOCATOR_ID                          := t_new_rec.FROM_LOCATOR_ID                               ;
    :new.AMOUNT                                   := t_new_rec.AMOUNT                                        ;
    :new.DROPSHIP_TYPE_CODE                       := t_new_rec.DROPSHIP_TYPE_CODE                            ;
    :new.LPN_GROUP_ID                             := t_new_rec.LPN_GROUP_ID                                  ;
    :new.JOB_ID                                   := t_new_rec.JOB_ID                                        ;
    :new.TIMECARD_ID                              := t_new_rec.TIMECARD_ID                                   ;
    :new.TIMECARD_OVN                             := t_new_rec.TIMECARD_OVN                                  ;
    :new.PROJECT_ID                               := t_new_rec.PROJECT_ID                                    ;
    :new.TASK_ID                                  := t_new_rec.TASK_ID                                       ;
  --Reverted the chnage in r12  :new.group_id                                 := t_new_rec.group_id;  /*Added by nprashar for bug # 8566481, FP from 8594501 */
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


  /*
  || make a call to the INR check package.
  */
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_RCV_RT_BRIUD_T1', p_inventory_orgn_id  =>  :new.organization_id ) = FALSE THEN
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

    IF ( (:NEW.TRANSACTION_TYPE IN ('RECEIVE','RETURN TO VENDOR', 'CORRECT'))
    OR (:NEW.TRANSACTION_TYPE <> 'RECEIVE' AND :NEW.CUSTOMER_ID IS NULL)
    OR (:NEW.TRANSACTION_TYPE IN ('DELIVER','RETURN TO RECEIVING') AND :NEW.CUSTOMER_ID IS NOT NULL ) )
    THEN

      JAI_RCV_RT_TRIGGER_PKG.BRI_T1 (
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

  /*
  || assign the new record values depending upon the triggering event.
  */
  IF UPDATING OR INSERTING THEN
     populate_t_new_rec;
  END IF;

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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_RCV_RT_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_RCV_RT_BRIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_RCV_RT_BRIUD_T1" DISABLE;
