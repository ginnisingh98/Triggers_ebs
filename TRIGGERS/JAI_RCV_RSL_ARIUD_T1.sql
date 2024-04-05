--------------------------------------------------------
--  DDL for Trigger JAI_RCV_RSL_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_RCV_RSL_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."RCV_SHIPMENT_LINES"
FOR EACH ROW
DECLARE
  t_old_rec             RCV_SHIPMENT_LINES%rowtype ;
  t_new_rec             RCV_SHIPMENT_LINES%rowtype ;
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

    t_new_rec.SHIPMENT_LINE_ID                         := :new.SHIPMENT_LINE_ID                              ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.SHIPMENT_HEADER_ID                       := :new.SHIPMENT_HEADER_ID                            ;
    t_new_rec.LINE_NUM                                 := :new.LINE_NUM                                      ;
    t_new_rec.CATEGORY_ID                              := :new.CATEGORY_ID                                   ;
    t_new_rec.QUANTITY_SHIPPED                         := :new.QUANTITY_SHIPPED                              ;
    t_new_rec.QUANTITY_RECEIVED                        := :new.QUANTITY_RECEIVED                             ;
    t_new_rec.UNIT_OF_MEASURE                          := :new.UNIT_OF_MEASURE                               ;
    t_new_rec.ITEM_DESCRIPTION                         := :new.ITEM_DESCRIPTION                              ;
    t_new_rec.ITEM_ID                                  := :new.ITEM_ID                                       ;
    t_new_rec.ITEM_REVISION                            := :new.ITEM_REVISION                                 ;
    t_new_rec.VENDOR_ITEM_NUM                          := :new.VENDOR_ITEM_NUM                               ;
    t_new_rec.VENDOR_LOT_NUM                           := :new.VENDOR_LOT_NUM                                ;
    t_new_rec.UOM_CONVERSION_RATE                      := :new.UOM_CONVERSION_RATE                           ;
    t_new_rec.SHIPMENT_LINE_STATUS_CODE                := :new.SHIPMENT_LINE_STATUS_CODE                     ;
    t_new_rec.SOURCE_DOCUMENT_CODE                     := :new.SOURCE_DOCUMENT_CODE                          ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.PO_RELEASE_ID                            := :new.PO_RELEASE_ID                                 ;
    t_new_rec.PO_LINE_ID                               := :new.PO_LINE_ID                                    ;
    t_new_rec.PO_LINE_LOCATION_ID                      := :new.PO_LINE_LOCATION_ID                           ;
    t_new_rec.PO_DISTRIBUTION_ID                       := :new.PO_DISTRIBUTION_ID                            ;
    t_new_rec.REQUISITION_LINE_ID                      := :new.REQUISITION_LINE_ID                           ;
    t_new_rec.REQ_DISTRIBUTION_ID                      := :new.REQ_DISTRIBUTION_ID                           ;
    t_new_rec.ROUTING_HEADER_ID                        := :new.ROUTING_HEADER_ID                             ;
    t_new_rec.PACKING_SLIP                             := :new.PACKING_SLIP                                  ;
    t_new_rec.FROM_ORGANIZATION_ID                     := :new.FROM_ORGANIZATION_ID                          ;
    t_new_rec.DELIVER_TO_PERSON_ID                     := :new.DELIVER_TO_PERSON_ID                          ;
    t_new_rec.EMPLOYEE_ID                              := :new.EMPLOYEE_ID                                   ;
    t_new_rec.DESTINATION_TYPE_CODE                    := :new.DESTINATION_TYPE_CODE                         ;
    t_new_rec.TO_ORGANIZATION_ID                       := :new.TO_ORGANIZATION_ID                            ;
    t_new_rec.TO_SUBINVENTORY                          := :new.TO_SUBINVENTORY                               ;
    t_new_rec.LOCATOR_ID                               := :new.LOCATOR_ID                                    ;
    t_new_rec.DELIVER_TO_LOCATION_ID                   := :new.DELIVER_TO_LOCATION_ID                        ;
    t_new_rec.CHARGE_ACCOUNT_ID                        := :new.CHARGE_ACCOUNT_ID                             ;
    t_new_rec.TRANSPORTATION_ACCOUNT_ID                := :new.TRANSPORTATION_ACCOUNT_ID                     ;
    t_new_rec.SHIPMENT_UNIT_PRICE                      := :new.SHIPMENT_UNIT_PRICE                           ;
    t_new_rec.TRANSFER_COST                            := :new.TRANSFER_COST                                 ;
    t_new_rec.TRANSPORTATION_COST                      := :new.TRANSPORTATION_COST                           ;
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
    t_new_rec.REASON_ID                                := :new.REASON_ID                                     ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.GOVERNMENT_CONTEXT                       := :new.GOVERNMENT_CONTEXT                            ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.DESTINATION_CONTEXT                      := :new.DESTINATION_CONTEXT                           ;
    t_new_rec.PRIMARY_UNIT_OF_MEASURE                  := :new.PRIMARY_UNIT_OF_MEASURE                       ;
    t_new_rec.EXCESS_TRANSPORT_REASON                  := :new.EXCESS_TRANSPORT_REASON                       ;
    t_new_rec.EXCESS_TRANSPORT_RESPONSIBLE             := :new.EXCESS_TRANSPORT_RESPONSIBLE                  ;
    t_new_rec.EXCESS_TRANSPORT_AUTH_NUM                := :new.EXCESS_TRANSPORT_AUTH_NUM                     ;
    t_new_rec.ASN_LINE_FLAG                            := :new.ASN_LINE_FLAG                                 ;
    t_new_rec.ORIGINAL_ASN_PARENT_LINE_ID              := :new.ORIGINAL_ASN_PARENT_LINE_ID                   ;
    t_new_rec.ORIGINAL_ASN_LINE_FLAG                   := :new.ORIGINAL_ASN_LINE_FLAG                        ;
    t_new_rec.VENDOR_CUM_SHIPPED_QUANTITY              := :new.VENDOR_CUM_SHIPPED_QUANTITY                   ;
    t_new_rec.NOTICE_UNIT_PRICE                        := :new.NOTICE_UNIT_PRICE                             ;
    t_new_rec.TAX_NAME                                 := :new.TAX_NAME                                      ;
    t_new_rec.TAX_AMOUNT                               := :new.TAX_AMOUNT                                    ;
    t_new_rec.INVOICE_STATUS_CODE                      := :new.INVOICE_STATUS_CODE                           ;
    t_new_rec.CUM_COMPARISON_FLAG                      := :new.CUM_COMPARISON_FLAG                           ;
    t_new_rec.CONTAINER_NUM                            := :new.CONTAINER_NUM                                 ;
    t_new_rec.TRUCK_NUM                                := :new.TRUCK_NUM                                     ;
    t_new_rec.BAR_CODE_LABEL                           := :new.BAR_CODE_LABEL                                ;
    t_new_rec.TRANSFER_PERCENTAGE                      := :new.TRANSFER_PERCENTAGE                           ;
    t_new_rec.MRC_SHIPMENT_UNIT_PRICE                  := :new.MRC_SHIPMENT_UNIT_PRICE                       ;
    t_new_rec.MRC_TRANSFER_COST                        := :new.MRC_TRANSFER_COST                             ;
    t_new_rec.MRC_TRANSPORTATION_COST                  := :new.MRC_TRANSPORTATION_COST                       ;
    t_new_rec.MRC_NOTICE_UNIT_PRICE                    := :new.MRC_NOTICE_UNIT_PRICE                         ;
    t_new_rec.SHIP_TO_LOCATION_ID                      := :new.SHIP_TO_LOCATION_ID                           ;
    t_new_rec.COUNTRY_OF_ORIGIN_CODE                   := :new.COUNTRY_OF_ORIGIN_CODE                        ;
    t_new_rec.OE_ORDER_HEADER_ID                       := :new.OE_ORDER_HEADER_ID                            ;
    t_new_rec.OE_ORDER_LINE_ID                         := :new.OE_ORDER_LINE_ID                              ;
    t_new_rec.CUSTOMER_ITEM_NUM                        := :new.CUSTOMER_ITEM_NUM                             ;
    t_new_rec.COST_GROUP_ID                            := :new.COST_GROUP_ID                                 ;
    t_new_rec.SECONDARY_QUANTITY_SHIPPED               := :new.SECONDARY_QUANTITY_SHIPPED                    ;
    t_new_rec.SECONDARY_QUANTITY_RECEIVED              := :new.SECONDARY_QUANTITY_RECEIVED                   ;
    t_new_rec.SECONDARY_UNIT_OF_MEASURE                := :new.SECONDARY_UNIT_OF_MEASURE                     ;
    t_new_rec.QC_GRADE                                 := :new.QC_GRADE                                      ;
    t_new_rec.MMT_TRANSACTION_ID                       := :new.MMT_TRANSACTION_ID                            ;
    t_new_rec.ASN_LPN_ID                               := :new.ASN_LPN_ID                                    ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.AMOUNT_RECEIVED                          := :new.AMOUNT_RECEIVED                               ;
    t_new_rec.JOB_ID                                   := :new.JOB_ID                                        ;
    t_new_rec.TIMECARD_ID                              := :new.TIMECARD_ID                                   ;
    t_new_rec.TIMECARD_OVN                             := :new.TIMECARD_OVN                                  ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.SHIPMENT_LINE_ID                         := :old.SHIPMENT_LINE_ID                              ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.SHIPMENT_HEADER_ID                       := :old.SHIPMENT_HEADER_ID                            ;
    t_old_rec.LINE_NUM                                 := :old.LINE_NUM                                      ;
    t_old_rec.CATEGORY_ID                              := :old.CATEGORY_ID                                   ;
    t_old_rec.QUANTITY_SHIPPED                         := :old.QUANTITY_SHIPPED                              ;
    t_old_rec.QUANTITY_RECEIVED                        := :old.QUANTITY_RECEIVED                             ;
    t_old_rec.UNIT_OF_MEASURE                          := :old.UNIT_OF_MEASURE                               ;
    t_old_rec.ITEM_DESCRIPTION                         := :old.ITEM_DESCRIPTION                              ;
    t_old_rec.ITEM_ID                                  := :old.ITEM_ID                                       ;
    t_old_rec.ITEM_REVISION                            := :old.ITEM_REVISION                                 ;
    t_old_rec.VENDOR_ITEM_NUM                          := :old.VENDOR_ITEM_NUM                               ;
    t_old_rec.VENDOR_LOT_NUM                           := :old.VENDOR_LOT_NUM                                ;
    t_old_rec.UOM_CONVERSION_RATE                      := :old.UOM_CONVERSION_RATE                           ;
    t_old_rec.SHIPMENT_LINE_STATUS_CODE                := :old.SHIPMENT_LINE_STATUS_CODE                     ;
    t_old_rec.SOURCE_DOCUMENT_CODE                     := :old.SOURCE_DOCUMENT_CODE                          ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.PO_RELEASE_ID                            := :old.PO_RELEASE_ID                                 ;
    t_old_rec.PO_LINE_ID                               := :old.PO_LINE_ID                                    ;
    t_old_rec.PO_LINE_LOCATION_ID                      := :old.PO_LINE_LOCATION_ID                           ;
    t_old_rec.PO_DISTRIBUTION_ID                       := :old.PO_DISTRIBUTION_ID                            ;
    t_old_rec.REQUISITION_LINE_ID                      := :old.REQUISITION_LINE_ID                           ;
    t_old_rec.REQ_DISTRIBUTION_ID                      := :old.REQ_DISTRIBUTION_ID                           ;
    t_old_rec.ROUTING_HEADER_ID                        := :old.ROUTING_HEADER_ID                             ;
    t_old_rec.PACKING_SLIP                             := :old.PACKING_SLIP                                  ;
    t_old_rec.FROM_ORGANIZATION_ID                     := :old.FROM_ORGANIZATION_ID                          ;
    t_old_rec.DELIVER_TO_PERSON_ID                     := :old.DELIVER_TO_PERSON_ID                          ;
    t_old_rec.EMPLOYEE_ID                              := :old.EMPLOYEE_ID                                   ;
    t_old_rec.DESTINATION_TYPE_CODE                    := :old.DESTINATION_TYPE_CODE                         ;
    t_old_rec.TO_ORGANIZATION_ID                       := :old.TO_ORGANIZATION_ID                            ;
    t_old_rec.TO_SUBINVENTORY                          := :old.TO_SUBINVENTORY                               ;
    t_old_rec.LOCATOR_ID                               := :old.LOCATOR_ID                                    ;
    t_old_rec.DELIVER_TO_LOCATION_ID                   := :old.DELIVER_TO_LOCATION_ID                        ;
    t_old_rec.CHARGE_ACCOUNT_ID                        := :old.CHARGE_ACCOUNT_ID                             ;
    t_old_rec.TRANSPORTATION_ACCOUNT_ID                := :old.TRANSPORTATION_ACCOUNT_ID                     ;
    t_old_rec.SHIPMENT_UNIT_PRICE                      := :old.SHIPMENT_UNIT_PRICE                           ;
    t_old_rec.TRANSFER_COST                            := :old.TRANSFER_COST                                 ;
    t_old_rec.TRANSPORTATION_COST                      := :old.TRANSPORTATION_COST                           ;
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
    t_old_rec.REASON_ID                                := :old.REASON_ID                                     ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.GOVERNMENT_CONTEXT                       := :old.GOVERNMENT_CONTEXT                            ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.DESTINATION_CONTEXT                      := :old.DESTINATION_CONTEXT                           ;
    t_old_rec.PRIMARY_UNIT_OF_MEASURE                  := :old.PRIMARY_UNIT_OF_MEASURE                       ;
    t_old_rec.EXCESS_TRANSPORT_REASON                  := :old.EXCESS_TRANSPORT_REASON                       ;
    t_old_rec.EXCESS_TRANSPORT_RESPONSIBLE             := :old.EXCESS_TRANSPORT_RESPONSIBLE                  ;
    t_old_rec.EXCESS_TRANSPORT_AUTH_NUM                := :old.EXCESS_TRANSPORT_AUTH_NUM                     ;
    t_old_rec.ASN_LINE_FLAG                            := :old.ASN_LINE_FLAG                                 ;
    t_old_rec.ORIGINAL_ASN_PARENT_LINE_ID              := :old.ORIGINAL_ASN_PARENT_LINE_ID                   ;
    t_old_rec.ORIGINAL_ASN_LINE_FLAG                   := :old.ORIGINAL_ASN_LINE_FLAG                        ;
    t_old_rec.VENDOR_CUM_SHIPPED_QUANTITY              := :old.VENDOR_CUM_SHIPPED_QUANTITY                   ;
    t_old_rec.NOTICE_UNIT_PRICE                        := :old.NOTICE_UNIT_PRICE                             ;
    t_old_rec.TAX_NAME                                 := :old.TAX_NAME                                      ;
    t_old_rec.TAX_AMOUNT                               := :old.TAX_AMOUNT                                    ;
    t_old_rec.INVOICE_STATUS_CODE                      := :old.INVOICE_STATUS_CODE                           ;
    t_old_rec.CUM_COMPARISON_FLAG                      := :old.CUM_COMPARISON_FLAG                           ;
    t_old_rec.CONTAINER_NUM                            := :old.CONTAINER_NUM                                 ;
    t_old_rec.TRUCK_NUM                                := :old.TRUCK_NUM                                     ;
    t_old_rec.BAR_CODE_LABEL                           := :old.BAR_CODE_LABEL                                ;
    t_old_rec.TRANSFER_PERCENTAGE                      := :old.TRANSFER_PERCENTAGE                           ;
    t_old_rec.MRC_SHIPMENT_UNIT_PRICE                  := :old.MRC_SHIPMENT_UNIT_PRICE                       ;
    t_old_rec.MRC_TRANSFER_COST                        := :old.MRC_TRANSFER_COST                             ;
    t_old_rec.MRC_TRANSPORTATION_COST                  := :old.MRC_TRANSPORTATION_COST                       ;
    t_old_rec.MRC_NOTICE_UNIT_PRICE                    := :old.MRC_NOTICE_UNIT_PRICE                         ;
    t_old_rec.SHIP_TO_LOCATION_ID                      := :old.SHIP_TO_LOCATION_ID                           ;
    t_old_rec.COUNTRY_OF_ORIGIN_CODE                   := :old.COUNTRY_OF_ORIGIN_CODE                        ;
    t_old_rec.OE_ORDER_HEADER_ID                       := :old.OE_ORDER_HEADER_ID                            ;
    t_old_rec.OE_ORDER_LINE_ID                         := :old.OE_ORDER_LINE_ID                              ;
    t_old_rec.CUSTOMER_ITEM_NUM                        := :old.CUSTOMER_ITEM_NUM                             ;
    t_old_rec.COST_GROUP_ID                            := :old.COST_GROUP_ID                                 ;
    t_old_rec.SECONDARY_QUANTITY_SHIPPED               := :old.SECONDARY_QUANTITY_SHIPPED                    ;
    t_old_rec.SECONDARY_QUANTITY_RECEIVED              := :old.SECONDARY_QUANTITY_RECEIVED                   ;
    t_old_rec.SECONDARY_UNIT_OF_MEASURE                := :old.SECONDARY_UNIT_OF_MEASURE                     ;
    t_old_rec.QC_GRADE                                 := :old.QC_GRADE                                      ;
    t_old_rec.MMT_TRANSACTION_ID                       := :old.MMT_TRANSACTION_ID                            ;
    t_old_rec.ASN_LPN_ID                               := :old.ASN_LPN_ID                                    ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.AMOUNT_RECEIVED                          := :old.AMOUNT_RECEIVED                               ;
    t_old_rec.JOB_ID                                   := :old.JOB_ID                                        ;
    t_old_rec.TIMECARD_ID                              := :old.TIMECARD_ID                                   ;
    t_old_rec.TIMECARD_OVN                             := :old.TIMECARD_OVN                                  ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_RCV_RSL_ARIUD_T1', p_inventory_orgn_id => :new.TO_ORGANIZATION_ID ) = FALSE THEN
       RETURN;
  END IF;

  /*
  || check for action in trigger and pass the same to the procedure
  */
  IF    INSERTING THEN
        --lv_action := jai_constants.inserting ;  --commented by Bgowrava for Bug#6144268
        lv_action := 'INSERTING'; /*ssumaith - bug#6144268 */
  ELSIF UPDATING THEN
        lv_action := jai_constants.updating ;
  ELSIF DELETING THEN
        lv_action := jai_constants.deleting ;
  END IF ;

  IF UPDATING THEN

    IF ( :NEW.po_header_id IS NOT NULL ) THEN

      JAI_RCV_RSL_TRIGGER_PKG.ARU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_RCV_RSL_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_RCV_RSL_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_RCV_RSL_ARIUD_T1" DISABLE;
