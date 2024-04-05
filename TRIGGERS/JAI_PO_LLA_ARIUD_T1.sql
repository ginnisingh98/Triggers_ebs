--------------------------------------------------------
--  DDL for Trigger JAI_PO_LLA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_LLA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."PO_LINE_LOCATIONS_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             PO_LINE_LOCATIONS_ALL%rowtype ;
  t_new_rec             PO_LINE_LOCATIONS_ALL%rowtype ;
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

    t_new_rec.LINE_LOCATION_ID                         := :new.LINE_LOCATION_ID                              ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.PO_LINE_ID                               := :new.PO_LINE_ID                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.QUANTITY                                 := :new.QUANTITY                                      ;
    t_new_rec.QUANTITY_RECEIVED                        := :new.QUANTITY_RECEIVED                             ;
    t_new_rec.QUANTITY_ACCEPTED                        := :new.QUANTITY_ACCEPTED                             ;
    t_new_rec.QUANTITY_REJECTED                        := :new.QUANTITY_REJECTED                             ;
    t_new_rec.QUANTITY_BILLED                          := :new.QUANTITY_BILLED                               ;
    t_new_rec.QUANTITY_CANCELLED                       := :new.QUANTITY_CANCELLED                            ;
    t_new_rec.UNIT_MEAS_LOOKUP_CODE                    := :new.UNIT_MEAS_LOOKUP_CODE                         ;
    t_new_rec.PO_RELEASE_ID                            := :new.PO_RELEASE_ID                                 ;
    t_new_rec.SHIP_TO_LOCATION_ID                      := :new.SHIP_TO_LOCATION_ID                           ;
    t_new_rec.SHIP_VIA_LOOKUP_CODE                     := :new.SHIP_VIA_LOOKUP_CODE                          ;
    t_new_rec.NEED_BY_DATE                             := :new.NEED_BY_DATE                                  ;
    t_new_rec.PROMISED_DATE                            := :new.PROMISED_DATE                                 ;
    t_new_rec.LAST_ACCEPT_DATE                         := :new.LAST_ACCEPT_DATE                              ;
    t_new_rec.PRICE_OVERRIDE                           := :new.PRICE_OVERRIDE                                ;
    t_new_rec.ENCUMBERED_FLAG                          := :new.ENCUMBERED_FLAG                               ;
    t_new_rec.ENCUMBERED_DATE                          := :new.ENCUMBERED_DATE                               ;
    t_new_rec.UNENCUMBERED_QUANTITY                    := :new.UNENCUMBERED_QUANTITY                         ;
    t_new_rec.FOB_LOOKUP_CODE                          := :new.FOB_LOOKUP_CODE                               ;
    t_new_rec.FREIGHT_TERMS_LOOKUP_CODE                := :new.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_new_rec.TAXABLE_FLAG                             := :new.TAXABLE_FLAG                                  ;
    t_new_rec.TAX_NAME                                 := :new.TAX_NAME                                      ;
    t_new_rec.ESTIMATED_TAX_AMOUNT                     := :new.ESTIMATED_TAX_AMOUNT                          ;
    t_new_rec.FROM_HEADER_ID                           := :new.FROM_HEADER_ID                                ;
    t_new_rec.FROM_LINE_ID                             := :new.FROM_LINE_ID                                  ;
    t_new_rec.FROM_LINE_LOCATION_ID                    := :new.FROM_LINE_LOCATION_ID                         ;
    t_new_rec.START_DATE                               := :new.START_DATE                                    ;
    t_new_rec.END_DATE                                 := :new.END_DATE                                      ;
    t_new_rec.LEAD_TIME                                := :new.LEAD_TIME                                     ;
    t_new_rec.LEAD_TIME_UNIT                           := :new.LEAD_TIME_UNIT                                ;
    t_new_rec.PRICE_DISCOUNT                           := :new.PRICE_DISCOUNT                                ;
    t_new_rec.TERMS_ID                                 := :new.TERMS_ID                                      ;
    t_new_rec.APPROVED_FLAG                            := :new.APPROVED_FLAG                                 ;
    t_new_rec.APPROVED_DATE                            := :new.APPROVED_DATE                                 ;
    t_new_rec.CLOSED_FLAG                              := :new.CLOSED_FLAG                                   ;
    t_new_rec.CANCEL_FLAG                              := :new.CANCEL_FLAG                                   ;
    t_new_rec.CANCELLED_BY                             := :new.CANCELLED_BY                                  ;
    t_new_rec.CANCEL_DATE                              := :new.CANCEL_DATE                                   ;
    t_new_rec.CANCEL_REASON                            := :new.CANCEL_REASON                                 ;
    t_new_rec.FIRM_STATUS_LOOKUP_CODE                  := :new.FIRM_STATUS_LOOKUP_CODE                       ;
    t_new_rec.FIRM_DATE                                := :new.FIRM_DATE                                     ;
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
    t_new_rec.UNIT_OF_MEASURE_CLASS                    := :new.UNIT_OF_MEASURE_CLASS                         ;
    t_new_rec.ENCUMBER_NOW                             := :new.ENCUMBER_NOW                                  ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.INSPECTION_REQUIRED_FLAG                 := :new.INSPECTION_REQUIRED_FLAG                      ;
    t_new_rec.RECEIPT_REQUIRED_FLAG                    := :new.RECEIPT_REQUIRED_FLAG                         ;
    t_new_rec.QTY_RCV_TOLERANCE                        := :new.QTY_RCV_TOLERANCE                             ;
    t_new_rec.QTY_RCV_EXCEPTION_CODE                   := :new.QTY_RCV_EXCEPTION_CODE                        ;
    t_new_rec.ENFORCE_SHIP_TO_LOCATION_CODE            := :new.ENFORCE_SHIP_TO_LOCATION_CODE                 ;
    t_new_rec.ALLOW_SUBSTITUTE_RECEIPTS_FLAG           := :new.ALLOW_SUBSTITUTE_RECEIPTS_FLAG                ;
    t_new_rec.DAYS_EARLY_RECEIPT_ALLOWED               := :new.DAYS_EARLY_RECEIPT_ALLOWED                    ;
    t_new_rec.DAYS_LATE_RECEIPT_ALLOWED                := :new.DAYS_LATE_RECEIPT_ALLOWED                     ;
    t_new_rec.RECEIPT_DAYS_EXCEPTION_CODE              := :new.RECEIPT_DAYS_EXCEPTION_CODE                   ;
    t_new_rec.INVOICE_CLOSE_TOLERANCE                  := :new.INVOICE_CLOSE_TOLERANCE                       ;
    t_new_rec.RECEIVE_CLOSE_TOLERANCE                  := :new.RECEIVE_CLOSE_TOLERANCE                       ;
    t_new_rec.SHIP_TO_ORGANIZATION_ID                  := :new.SHIP_TO_ORGANIZATION_ID                       ;
    t_new_rec.SHIPMENT_NUM                             := :new.SHIPMENT_NUM                                  ;
    t_new_rec.SOURCE_SHIPMENT_ID                       := :new.SOURCE_SHIPMENT_ID                            ;
    t_new_rec.SHIPMENT_TYPE                            := :new.SHIPMENT_TYPE                                 ;
    t_new_rec.CLOSED_CODE                              := :new.CLOSED_CODE                                   ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.GOVERNMENT_CONTEXT                       := :new.GOVERNMENT_CONTEXT                            ;
    t_new_rec.RECEIVING_ROUTING_ID                     := :new.RECEIVING_ROUTING_ID                          ;
    t_new_rec.ACCRUE_ON_RECEIPT_FLAG                   := :new.ACCRUE_ON_RECEIPT_FLAG                        ;
    t_new_rec.CLOSED_REASON                            := :new.CLOSED_REASON                                 ;
    t_new_rec.CLOSED_DATE                              := :new.CLOSED_DATE                                   ;
    t_new_rec.CLOSED_BY                                := :new.CLOSED_BY                                     ;
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
    t_new_rec.QUANTITY_SHIPPED                         := :new.QUANTITY_SHIPPED                              ;
    t_new_rec.COUNTRY_OF_ORIGIN_CODE                   := :new.COUNTRY_OF_ORIGIN_CODE                        ;
    t_new_rec.TAX_USER_OVERRIDE_FLAG                   := :new.TAX_USER_OVERRIDE_FLAG                        ;
    t_new_rec.MATCH_OPTION                             := :new.MATCH_OPTION                                  ;
    t_new_rec.TAX_CODE_ID                              := :new.TAX_CODE_ID                                   ;
    t_new_rec.CALCULATE_TAX_FLAG                       := :new.CALCULATE_TAX_FLAG                            ;
    t_new_rec.CHANGE_PROMISED_DATE_REASON              := :new.CHANGE_PROMISED_DATE_REASON                   ;
    t_new_rec.NOTE_TO_RECEIVER                         := :new.NOTE_TO_RECEIVER                              ;
    t_new_rec.SECONDARY_QUANTITY                       := :new.SECONDARY_QUANTITY                            ;
    t_new_rec.SECONDARY_UNIT_OF_MEASURE                := :new.SECONDARY_UNIT_OF_MEASURE                     ;
    t_new_rec.PREFERRED_GRADE                          := :new.PREFERRED_GRADE                               ;
    t_new_rec.SECONDARY_QUANTITY_RECEIVED              := :new.SECONDARY_QUANTITY_RECEIVED                   ;
    t_new_rec.SECONDARY_QUANTITY_ACCEPTED              := :new.SECONDARY_QUANTITY_ACCEPTED                   ;
    t_new_rec.SECONDARY_QUANTITY_REJECTED              := :new.SECONDARY_QUANTITY_REJECTED                   ;
    t_new_rec.SECONDARY_QUANTITY_CANCELLED             := :new.SECONDARY_QUANTITY_CANCELLED                  ;
    t_new_rec.VMI_FLAG                                 := :new.VMI_FLAG                                      ;
    t_new_rec.CONSIGNED_FLAG                           := :new.CONSIGNED_FLAG                                ;
    t_new_rec.RETROACTIVE_DATE                         := :new.RETROACTIVE_DATE                              ;
    t_new_rec.SUPPLIER_ORDER_LINE_NUMBER               := :new.SUPPLIER_ORDER_LINE_NUMBER                    ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.AMOUNT_RECEIVED                          := :new.AMOUNT_RECEIVED                               ;
    t_new_rec.AMOUNT_BILLED                            := :new.AMOUNT_BILLED                                 ;
    t_new_rec.AMOUNT_CANCELLED                         := :new.AMOUNT_CANCELLED                              ;
    t_new_rec.AMOUNT_REJECTED                          := :new.AMOUNT_REJECTED                               ;
    t_new_rec.AMOUNT_ACCEPTED                          := :new.AMOUNT_ACCEPTED                               ;
    t_new_rec.DROP_SHIP_FLAG                           := :new.DROP_SHIP_FLAG                                ;
    t_new_rec.SALES_ORDER_UPDATE_DATE                  := :new.SALES_ORDER_UPDATE_DATE                       ;
    t_new_rec.TRANSACTION_FLOW_HEADER_ID               := :new.TRANSACTION_FLOW_HEADER_ID                    ;
    t_new_rec.FINAL_MATCH_FLAG                         := :new.FINAL_MATCH_FLAG                              ;
    t_new_rec.MANUAL_PRICE_CHANGE_FLAG                 := :new.MANUAL_PRICE_CHANGE_FLAG                      ;
    t_new_rec.SHIPMENT_CLOSED_DATE                     := :new.SHIPMENT_CLOSED_DATE                          ;
    t_new_rec.CLOSED_FOR_RECEIVING_DATE                := :new.CLOSED_FOR_RECEIVING_DATE                     ;
    t_new_rec.CLOSED_FOR_INVOICE_DATE                  := :new.CLOSED_FOR_INVOICE_DATE                       ;
    t_new_rec.SECONDARY_QUANTITY_SHIPPED               := :new.SECONDARY_QUANTITY_SHIPPED                    ;
    t_new_rec.VALUE_BASIS                              := :new.VALUE_BASIS                                   ;
    t_new_rec.MATCHING_BASIS                           := :new.MATCHING_BASIS                                ;
    t_new_rec.PAYMENT_TYPE                             := :new.PAYMENT_TYPE                                  ;
    t_new_rec.DESCRIPTION                              := :new.DESCRIPTION                                   ;
    t_new_rec.WORK_APPROVER_ID                         := :new.WORK_APPROVER_ID                              ;
    t_new_rec.BID_PAYMENT_ID                           := :new.BID_PAYMENT_ID                                ;
    t_new_rec.QUANTITY_FINANCED                        := :new.QUANTITY_FINANCED                             ;
    t_new_rec.AMOUNT_FINANCED                          := :new.AMOUNT_FINANCED                               ;
    t_new_rec.QUANTITY_RECOUPED                        := :new.QUANTITY_RECOUPED                             ;
    t_new_rec.AMOUNT_RECOUPED                          := :new.AMOUNT_RECOUPED                               ;
    t_new_rec.RETAINAGE_WITHHELD_AMOUNT                := :new.RETAINAGE_WITHHELD_AMOUNT                     ;
    t_new_rec.RETAINAGE_RELEASED_AMOUNT                := :new.RETAINAGE_RELEASED_AMOUNT                     ;
    t_new_rec.AMOUNT_SHIPPED                           := :new.AMOUNT_SHIPPED                                ;
    t_new_rec.OUTSOURCED_ASSEMBLY                      := :new.OUTSOURCED_ASSEMBLY                           ;
    t_new_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :new.TAX_ATTRIBUTE_UPDATE_CODE                     ;
    t_new_rec.ORIGINAL_SHIPMENT_ID                     := :new.ORIGINAL_SHIPMENT_ID                          ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.LINE_LOCATION_ID                         := :old.LINE_LOCATION_ID                              ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.PO_LINE_ID                               := :old.PO_LINE_ID                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.QUANTITY                                 := :old.QUANTITY                                      ;
    t_old_rec.QUANTITY_RECEIVED                        := :old.QUANTITY_RECEIVED                             ;
    t_old_rec.QUANTITY_ACCEPTED                        := :old.QUANTITY_ACCEPTED                             ;
    t_old_rec.QUANTITY_REJECTED                        := :old.QUANTITY_REJECTED                             ;
    t_old_rec.QUANTITY_BILLED                          := :old.QUANTITY_BILLED                               ;
    t_old_rec.QUANTITY_CANCELLED                       := :old.QUANTITY_CANCELLED                            ;
    t_old_rec.UNIT_MEAS_LOOKUP_CODE                    := :old.UNIT_MEAS_LOOKUP_CODE                         ;
    t_old_rec.PO_RELEASE_ID                            := :old.PO_RELEASE_ID                                 ;
    t_old_rec.SHIP_TO_LOCATION_ID                      := :old.SHIP_TO_LOCATION_ID                           ;
    t_old_rec.SHIP_VIA_LOOKUP_CODE                     := :old.SHIP_VIA_LOOKUP_CODE                          ;
    t_old_rec.NEED_BY_DATE                             := :old.NEED_BY_DATE                                  ;
    t_old_rec.PROMISED_DATE                            := :old.PROMISED_DATE                                 ;
    t_old_rec.LAST_ACCEPT_DATE                         := :old.LAST_ACCEPT_DATE                              ;
    t_old_rec.PRICE_OVERRIDE                           := :old.PRICE_OVERRIDE                                ;
    t_old_rec.ENCUMBERED_FLAG                          := :old.ENCUMBERED_FLAG                               ;
    t_old_rec.ENCUMBERED_DATE                          := :old.ENCUMBERED_DATE                               ;
    t_old_rec.UNENCUMBERED_QUANTITY                    := :old.UNENCUMBERED_QUANTITY                         ;
    t_old_rec.FOB_LOOKUP_CODE                          := :old.FOB_LOOKUP_CODE                               ;
    t_old_rec.FREIGHT_TERMS_LOOKUP_CODE                := :old.FREIGHT_TERMS_LOOKUP_CODE                     ;
    t_old_rec.TAXABLE_FLAG                             := :old.TAXABLE_FLAG                                  ;
    t_old_rec.TAX_NAME                                 := :old.TAX_NAME                                      ;
    t_old_rec.ESTIMATED_TAX_AMOUNT                     := :old.ESTIMATED_TAX_AMOUNT                          ;
    t_old_rec.FROM_HEADER_ID                           := :old.FROM_HEADER_ID                                ;
    t_old_rec.FROM_LINE_ID                             := :old.FROM_LINE_ID                                  ;
    t_old_rec.FROM_LINE_LOCATION_ID                    := :old.FROM_LINE_LOCATION_ID                         ;
    t_old_rec.START_DATE                               := :old.START_DATE                                    ;
    t_old_rec.END_DATE                                 := :old.END_DATE                                      ;
    t_old_rec.LEAD_TIME                                := :old.LEAD_TIME                                     ;
    t_old_rec.LEAD_TIME_UNIT                           := :old.LEAD_TIME_UNIT                                ;
    t_old_rec.PRICE_DISCOUNT                           := :old.PRICE_DISCOUNT                                ;
    t_old_rec.TERMS_ID                                 := :old.TERMS_ID                                      ;
    t_old_rec.APPROVED_FLAG                            := :old.APPROVED_FLAG                                 ;
    t_old_rec.APPROVED_DATE                            := :old.APPROVED_DATE                                 ;
    t_old_rec.CLOSED_FLAG                              := :old.CLOSED_FLAG                                   ;
    t_old_rec.CANCEL_FLAG                              := :old.CANCEL_FLAG                                   ;
    t_old_rec.CANCELLED_BY                             := :old.CANCELLED_BY                                  ;
    t_old_rec.CANCEL_DATE                              := :old.CANCEL_DATE                                   ;
    t_old_rec.CANCEL_REASON                            := :old.CANCEL_REASON                                 ;
    t_old_rec.FIRM_STATUS_LOOKUP_CODE                  := :old.FIRM_STATUS_LOOKUP_CODE                       ;
    t_old_rec.FIRM_DATE                                := :old.FIRM_DATE                                     ;
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
    t_old_rec.UNIT_OF_MEASURE_CLASS                    := :old.UNIT_OF_MEASURE_CLASS                         ;
    t_old_rec.ENCUMBER_NOW                             := :old.ENCUMBER_NOW                                  ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.INSPECTION_REQUIRED_FLAG                 := :old.INSPECTION_REQUIRED_FLAG                      ;
    t_old_rec.RECEIPT_REQUIRED_FLAG                    := :old.RECEIPT_REQUIRED_FLAG                         ;
    t_old_rec.QTY_RCV_TOLERANCE                        := :old.QTY_RCV_TOLERANCE                             ;
    t_old_rec.QTY_RCV_EXCEPTION_CODE                   := :old.QTY_RCV_EXCEPTION_CODE                        ;
    t_old_rec.ENFORCE_SHIP_TO_LOCATION_CODE            := :old.ENFORCE_SHIP_TO_LOCATION_CODE                 ;
    t_old_rec.ALLOW_SUBSTITUTE_RECEIPTS_FLAG           := :old.ALLOW_SUBSTITUTE_RECEIPTS_FLAG                ;
    t_old_rec.DAYS_EARLY_RECEIPT_ALLOWED               := :old.DAYS_EARLY_RECEIPT_ALLOWED                    ;
    t_old_rec.DAYS_LATE_RECEIPT_ALLOWED                := :old.DAYS_LATE_RECEIPT_ALLOWED                     ;
    t_old_rec.RECEIPT_DAYS_EXCEPTION_CODE              := :old.RECEIPT_DAYS_EXCEPTION_CODE                   ;
    t_old_rec.INVOICE_CLOSE_TOLERANCE                  := :old.INVOICE_CLOSE_TOLERANCE                       ;
    t_old_rec.RECEIVE_CLOSE_TOLERANCE                  := :old.RECEIVE_CLOSE_TOLERANCE                       ;
    t_old_rec.SHIP_TO_ORGANIZATION_ID                  := :old.SHIP_TO_ORGANIZATION_ID                       ;
    t_old_rec.SHIPMENT_NUM                             := :old.SHIPMENT_NUM                                  ;
    t_old_rec.SOURCE_SHIPMENT_ID                       := :old.SOURCE_SHIPMENT_ID                            ;
    t_old_rec.SHIPMENT_TYPE                            := :old.SHIPMENT_TYPE                                 ;
    t_old_rec.CLOSED_CODE                              := :old.CLOSED_CODE                                   ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.GOVERNMENT_CONTEXT                       := :old.GOVERNMENT_CONTEXT                            ;
    t_old_rec.RECEIVING_ROUTING_ID                     := :old.RECEIVING_ROUTING_ID                          ;
    t_old_rec.ACCRUE_ON_RECEIPT_FLAG                   := :old.ACCRUE_ON_RECEIPT_FLAG                        ;
    t_old_rec.CLOSED_REASON                            := :old.CLOSED_REASON                                 ;
    t_old_rec.CLOSED_DATE                              := :old.CLOSED_DATE                                   ;
    t_old_rec.CLOSED_BY                                := :old.CLOSED_BY                                     ;
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
    t_old_rec.QUANTITY_SHIPPED                         := :old.QUANTITY_SHIPPED                              ;
    t_old_rec.COUNTRY_OF_ORIGIN_CODE                   := :old.COUNTRY_OF_ORIGIN_CODE                        ;
    t_old_rec.TAX_USER_OVERRIDE_FLAG                   := :old.TAX_USER_OVERRIDE_FLAG                        ;
    t_old_rec.MATCH_OPTION                             := :old.MATCH_OPTION                                  ;
    t_old_rec.TAX_CODE_ID                              := :old.TAX_CODE_ID                                   ;
    t_old_rec.CALCULATE_TAX_FLAG                       := :old.CALCULATE_TAX_FLAG                            ;
    t_old_rec.CHANGE_PROMISED_DATE_REASON              := :old.CHANGE_PROMISED_DATE_REASON                   ;
    t_old_rec.NOTE_TO_RECEIVER                         := :old.NOTE_TO_RECEIVER                              ;
    t_old_rec.SECONDARY_QUANTITY                       := :old.SECONDARY_QUANTITY                            ;
    t_old_rec.SECONDARY_UNIT_OF_MEASURE                := :old.SECONDARY_UNIT_OF_MEASURE                     ;
    t_old_rec.PREFERRED_GRADE                          := :old.PREFERRED_GRADE                               ;
    t_old_rec.SECONDARY_QUANTITY_RECEIVED              := :old.SECONDARY_QUANTITY_RECEIVED                   ;
    t_old_rec.SECONDARY_QUANTITY_ACCEPTED              := :old.SECONDARY_QUANTITY_ACCEPTED                   ;
    t_old_rec.SECONDARY_QUANTITY_REJECTED              := :old.SECONDARY_QUANTITY_REJECTED                   ;
    t_old_rec.SECONDARY_QUANTITY_CANCELLED             := :old.SECONDARY_QUANTITY_CANCELLED                  ;
    t_old_rec.VMI_FLAG                                 := :old.VMI_FLAG                                      ;
    t_old_rec.CONSIGNED_FLAG                           := :old.CONSIGNED_FLAG                                ;
    t_old_rec.RETROACTIVE_DATE                         := :old.RETROACTIVE_DATE                              ;
    t_old_rec.SUPPLIER_ORDER_LINE_NUMBER               := :old.SUPPLIER_ORDER_LINE_NUMBER                    ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.AMOUNT_RECEIVED                          := :old.AMOUNT_RECEIVED                               ;
    t_old_rec.AMOUNT_BILLED                            := :old.AMOUNT_BILLED                                 ;
    t_old_rec.AMOUNT_CANCELLED                         := :old.AMOUNT_CANCELLED                              ;
    t_old_rec.AMOUNT_REJECTED                          := :old.AMOUNT_REJECTED                               ;
    t_old_rec.AMOUNT_ACCEPTED                          := :old.AMOUNT_ACCEPTED                               ;
    t_old_rec.DROP_SHIP_FLAG                           := :old.DROP_SHIP_FLAG                                ;
    t_old_rec.SALES_ORDER_UPDATE_DATE                  := :old.SALES_ORDER_UPDATE_DATE                       ;
    t_old_rec.TRANSACTION_FLOW_HEADER_ID               := :old.TRANSACTION_FLOW_HEADER_ID                    ;
    t_old_rec.FINAL_MATCH_FLAG                         := :old.FINAL_MATCH_FLAG                              ;
    t_old_rec.MANUAL_PRICE_CHANGE_FLAG                 := :old.MANUAL_PRICE_CHANGE_FLAG                      ;
    t_old_rec.SHIPMENT_CLOSED_DATE                     := :old.SHIPMENT_CLOSED_DATE                          ;
    t_old_rec.CLOSED_FOR_RECEIVING_DATE                := :old.CLOSED_FOR_RECEIVING_DATE                     ;
    t_old_rec.CLOSED_FOR_INVOICE_DATE                  := :old.CLOSED_FOR_INVOICE_DATE                       ;
    t_old_rec.SECONDARY_QUANTITY_SHIPPED               := :old.SECONDARY_QUANTITY_SHIPPED                    ;
    t_old_rec.VALUE_BASIS                              := :old.VALUE_BASIS                                   ;
    t_old_rec.MATCHING_BASIS                           := :old.MATCHING_BASIS                                ;
    t_old_rec.PAYMENT_TYPE                             := :old.PAYMENT_TYPE                                  ;
    t_old_rec.DESCRIPTION                              := :old.DESCRIPTION                                   ;
    t_old_rec.WORK_APPROVER_ID                         := :old.WORK_APPROVER_ID                              ;
    t_old_rec.BID_PAYMENT_ID                           := :old.BID_PAYMENT_ID                                ;
    t_old_rec.QUANTITY_FINANCED                        := :old.QUANTITY_FINANCED                             ;
    t_old_rec.AMOUNT_FINANCED                          := :old.AMOUNT_FINANCED                               ;
    t_old_rec.QUANTITY_RECOUPED                        := :old.QUANTITY_RECOUPED                             ;
    t_old_rec.AMOUNT_RECOUPED                          := :old.AMOUNT_RECOUPED                               ;
    t_old_rec.RETAINAGE_WITHHELD_AMOUNT                := :old.RETAINAGE_WITHHELD_AMOUNT                     ;
    t_old_rec.RETAINAGE_RELEASED_AMOUNT                := :old.RETAINAGE_RELEASED_AMOUNT                     ;
    t_old_rec.AMOUNT_SHIPPED                           := :old.AMOUNT_SHIPPED                                ;
    t_old_rec.OUTSOURCED_ASSEMBLY                      := :old.OUTSOURCED_ASSEMBLY                           ;
    t_old_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :old.TAX_ATTRIBUTE_UPDATE_CODE                     ;
    t_old_rec.ORIGINAL_SHIPMENT_ID                     := :old.ORIGINAL_SHIPMENT_ID                          ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_LLA_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

      JAI_PO_LLA_TRIGGER_PKG.ARI_T1 (
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

    IF ( nvl( :NEW.quantity, 0 ) <> nvl( :OLD.quantity, 0 ) OR ( nvl(:OLD.cancel_flag,'N')  <> 'Y'  AND nvl(:NEW.cancel_flag,'N') = 'Y'  )
OR nvl(:NEW.price_override, 0 ) <> nvl( :OLD.price_override, 0 ) OR nvl( :NEW.unit_meas_lookup_code, 'X' ) <> nvl( :OLD.unit_meas_lookup_code, 'X' ) ) THEN

      JAI_PO_LLA_TRIGGER_PKG.ARU_T1 (
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

  IF DELETING THEN

      JAI_PO_LLA_TRIGGER_PKG.ARD_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_LLA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_LLA_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_PO_LLA_ARIUD_T1" DISABLE;
