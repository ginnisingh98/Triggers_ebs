--------------------------------------------------------
--  DDL for Trigger JAI_JRG_23AC1_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JRG_23AC1_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "JA"."JAI_CMN_RG_23AC_I_TRXS"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_CMN_RG_23AC_I_TRXS%rowtype ;
  t_new_rec             JAI_CMN_RG_23AC_I_TRXS%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  /***************change history*******************
  1. 21-oct-2008 bug#6012654,file version 120.1.12000000.2
                 forwardported the changes done in 115 bug 5956458
**************************************************/

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.REGISTER_ID                              := :new.REGISTER_ID                                   ;
    t_new_rec.FIN_YEAR                                 := :new.FIN_YEAR                                      ;
    t_new_rec.SLNO                                     := :new.SLNO                                          ;
    t_new_rec.TRANSACTION_SOURCE_NUM                   := :new.TRANSACTION_SOURCE_NUM                        ;
    t_new_rec.INVENTORY_ITEM_ID                        := :new.INVENTORY_ITEM_ID                             ;
    t_new_rec.ORGANIZATION_ID                          := :new.ORGANIZATION_ID                               ;
    t_new_rec.QUANTITY_RECEIVED                        := :new.QUANTITY_RECEIVED                             ;
    t_new_rec.RECEIPT_REF                              := :new.RECEIPT_REF                                   ;
    t_new_rec.TRANSACTION_TYPE                         := :new.TRANSACTION_TYPE                              ;
    t_new_rec.RECEIPT_DATE                             := :new.RECEIPT_DATE                                  ;
    t_new_rec.RANGE_NO                                 := :new.RANGE_NO                                      ;
    t_new_rec.DIVISION_NO                              := :new.DIVISION_NO                                   ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.PO_HEADER_DATE                           := :new.PO_HEADER_DATE                                ;
    t_new_rec.PO_LINE_ID                               := :new.PO_LINE_ID                                    ;
    t_new_rec.PO_LINE_LOCATION_ID                      := :new.PO_LINE_LOCATION_ID                           ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.CUSTOMER_ID                              := :new.CUSTOMER_ID                                   ;
    t_new_rec.CUSTOMER_SITE_ID                         := :new.CUSTOMER_SITE_ID                              ;
    t_new_rec.GOODS_ISSUE_ID_REF                       := :new.GOODS_ISSUE_ID_REF                            ;
    t_new_rec.GOODS_ISSUE_DATE                         := :new.GOODS_ISSUE_DATE                              ;
    t_new_rec.GOODS_ISSUE_QUANTITY                     := :new.GOODS_ISSUE_QUANTITY                          ;
    t_new_rec.SALES_INVOICE_NO                         := :new.SALES_INVOICE_NO                              ;
    t_new_rec.SALES_INVOICE_DATE                       := :new.SALES_INVOICE_DATE                            ;
    t_new_rec.SALES_INVOICE_QUANTITY                   := :new.SALES_INVOICE_QUANTITY                        ;
    t_new_rec.EXCISE_INVOICE_NO                        := :new.EXCISE_INVOICE_NO                             ;
    t_new_rec.EXCISE_INVOICE_DATE                      := :new.EXCISE_INVOICE_DATE                           ;
    t_new_rec.OTH_RECEIPT_QUANTITY                     := :new.OTH_RECEIPT_QUANTITY                          ;
    t_new_rec.OTH_RECEIPT_ID_REF                       := :new.OTH_RECEIPT_ID_REF                            ;
    t_new_rec.OTH_RECEIPT_DATE                         := :new.OTH_RECEIPT_DATE                              ;
    t_new_rec.REGISTER_TYPE                            := :new.REGISTER_TYPE                                 ;
    t_new_rec.IDENTIFICATION_NO                        := :new.IDENTIFICATION_NO                             ;
    t_new_rec.IDENTIFICATION_MARK                      := :new.IDENTIFICATION_MARK                           ;
    t_new_rec.BRAND_NAME                               := :new.BRAND_NAME                                    ;
    t_new_rec.DATE_OF_VERIFICATION                     := :new.DATE_OF_VERIFICATION                          ;
    t_new_rec.DATE_OF_INSTALLATION                     := :new.DATE_OF_INSTALLATION                          ;
    t_new_rec.DATE_OF_COMMISSION                       := :new.DATE_OF_COMMISSION                            ;
    t_new_rec.REGISTER_ID_PART_II                      := :new.REGISTER_ID_PART_II                           ;
    t_new_rec.PLACE_OF_INSTALL                         := :new.PLACE_OF_INSTALL                              ;
    t_new_rec.REMARKS                                  := :new.REMARKS                                       ;
    t_new_rec.LOCATION_ID                              := :new.LOCATION_ID                                   ;
    t_new_rec.PRIMARY_UOM_CODE                         := :new.PRIMARY_UOM_CODE                              ;
    t_new_rec.TRANSACTION_UOM_CODE                     := :new.TRANSACTION_UOM_CODE                          ;
    t_new_rec.TRANSACTION_DATE                         := :new.TRANSACTION_DATE                              ;
    t_new_rec.BASIC_ED                                 := :new.BASIC_ED                                      ;
    t_new_rec.ADDITIONAL_ED                            := :new.ADDITIONAL_ED                                 ;
    t_new_rec.OTHER_ED                                 := :new.OTHER_ED                                      ;
    t_new_rec.OPENING_BALANCE_QTY                      := :new.OPENING_BALANCE_QTY                           ;
    t_new_rec.CLOSING_BALANCE_QTY                      := :new.CLOSING_BALANCE_QTY                           ;
    t_new_rec.CHARGE_ACCOUNT_ID                        := :new.CHARGE_ACCOUNT_ID                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.POSTED_FLAG                              := :new.POSTED_FLAG                                   ;
    t_new_rec.MASTER_FLAG                              := :new.MASTER_FLAG                                   ;
    t_new_rec.BOL_ID                                   := :new.BOL_ID                                        ;
    t_new_rec.BOLLINE_NO                               := :new.BOLLINE_NO                                    ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.REGISTER_ID                              := :old.REGISTER_ID                                   ;
    t_old_rec.FIN_YEAR                                 := :old.FIN_YEAR                                      ;
    t_old_rec.SLNO                                     := :old.SLNO                                          ;
    t_old_rec.TRANSACTION_SOURCE_NUM                   := :old.TRANSACTION_SOURCE_NUM                        ;
    t_old_rec.INVENTORY_ITEM_ID                        := :old.INVENTORY_ITEM_ID                             ;
    t_old_rec.ORGANIZATION_ID                          := :old.ORGANIZATION_ID                               ;
    t_old_rec.QUANTITY_RECEIVED                        := :old.QUANTITY_RECEIVED                             ;
    t_old_rec.RECEIPT_REF                              := :old.RECEIPT_REF                                   ;
    t_old_rec.TRANSACTION_TYPE                         := :old.TRANSACTION_TYPE                              ;
    t_old_rec.RECEIPT_DATE                             := :old.RECEIPT_DATE                                  ;
    t_old_rec.RANGE_NO                                 := :old.RANGE_NO                                      ;
    t_old_rec.DIVISION_NO                              := :old.DIVISION_NO                                   ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.PO_HEADER_DATE                           := :old.PO_HEADER_DATE                                ;
    t_old_rec.PO_LINE_ID                               := :old.PO_LINE_ID                                    ;
    t_old_rec.PO_LINE_LOCATION_ID                      := :old.PO_LINE_LOCATION_ID                           ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.CUSTOMER_ID                              := :old.CUSTOMER_ID                                   ;
    t_old_rec.CUSTOMER_SITE_ID                         := :old.CUSTOMER_SITE_ID                              ;
    t_old_rec.GOODS_ISSUE_ID_REF                       := :old.GOODS_ISSUE_ID_REF                            ;
    t_old_rec.GOODS_ISSUE_DATE                         := :old.GOODS_ISSUE_DATE                              ;
    t_old_rec.GOODS_ISSUE_QUANTITY                     := :old.GOODS_ISSUE_QUANTITY                          ;
    t_old_rec.SALES_INVOICE_NO                         := :old.SALES_INVOICE_NO                              ;
    t_old_rec.SALES_INVOICE_DATE                       := :old.SALES_INVOICE_DATE                            ;
    t_old_rec.SALES_INVOICE_QUANTITY                   := :old.SALES_INVOICE_QUANTITY                        ;
    t_old_rec.EXCISE_INVOICE_NO                        := :old.EXCISE_INVOICE_NO                             ;
    t_old_rec.EXCISE_INVOICE_DATE                      := :old.EXCISE_INVOICE_DATE                           ;
    t_old_rec.OTH_RECEIPT_QUANTITY                     := :old.OTH_RECEIPT_QUANTITY                          ;
    t_old_rec.OTH_RECEIPT_ID_REF                       := :old.OTH_RECEIPT_ID_REF                            ;
    t_old_rec.OTH_RECEIPT_DATE                         := :old.OTH_RECEIPT_DATE                              ;
    t_old_rec.REGISTER_TYPE                            := :old.REGISTER_TYPE                                 ;
    t_old_rec.IDENTIFICATION_NO                        := :old.IDENTIFICATION_NO                             ;
    t_old_rec.IDENTIFICATION_MARK                      := :old.IDENTIFICATION_MARK                           ;
    t_old_rec.BRAND_NAME                               := :old.BRAND_NAME                                    ;
    t_old_rec.DATE_OF_VERIFICATION                     := :old.DATE_OF_VERIFICATION                          ;
    t_old_rec.DATE_OF_INSTALLATION                     := :old.DATE_OF_INSTALLATION                          ;
    t_old_rec.DATE_OF_COMMISSION                       := :old.DATE_OF_COMMISSION                            ;
    t_old_rec.REGISTER_ID_PART_II                      := :old.REGISTER_ID_PART_II                           ;
    t_old_rec.PLACE_OF_INSTALL                         := :old.PLACE_OF_INSTALL                              ;
    t_old_rec.REMARKS                                  := :old.REMARKS                                       ;
    t_old_rec.LOCATION_ID                              := :old.LOCATION_ID                                   ;
    t_old_rec.PRIMARY_UOM_CODE                         := :old.PRIMARY_UOM_CODE                              ;
    t_old_rec.TRANSACTION_UOM_CODE                     := :old.TRANSACTION_UOM_CODE                          ;
    t_old_rec.TRANSACTION_DATE                         := :old.TRANSACTION_DATE                              ;
    t_old_rec.BASIC_ED                                 := :old.BASIC_ED                                      ;
    t_old_rec.ADDITIONAL_ED                            := :old.ADDITIONAL_ED                                 ;
    t_old_rec.OTHER_ED                                 := :old.OTHER_ED                                      ;
    t_old_rec.OPENING_BALANCE_QTY                      := :old.OPENING_BALANCE_QTY                           ;
    t_old_rec.CLOSING_BALANCE_QTY                      := :old.CLOSING_BALANCE_QTY                           ;
    t_old_rec.CHARGE_ACCOUNT_ID                        := :old.CHARGE_ACCOUNT_ID                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.POSTED_FLAG                              := :old.POSTED_FLAG                                   ;
    t_old_rec.MASTER_FLAG                              := :old.MASTER_FLAG                                   ;
    t_old_rec.BOL_ID                                   := :old.BOL_ID                                        ;
    t_old_rec.BOLLINE_NO                               := :old.BOLLINE_NO                                    ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
  END populate_old ;

    /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.REGISTER_ID                              := t_new_rec.REGISTER_ID                                   ;
    :new.FIN_YEAR                                 := t_new_rec.FIN_YEAR                                      ;
    :new.SLNO                                     := t_new_rec.SLNO                                          ;
    :new.TRANSACTION_SOURCE_NUM                   := t_new_rec.TRANSACTION_SOURCE_NUM                        ;
    :new.INVENTORY_ITEM_ID                        := t_new_rec.INVENTORY_ITEM_ID                             ;
    :new.ORGANIZATION_ID                          := t_new_rec.ORGANIZATION_ID                               ;
    :new.QUANTITY_RECEIVED                        := t_new_rec.QUANTITY_RECEIVED                             ;
    :new.RECEIPT_REF                              := t_new_rec.RECEIPT_REF                                   ;
    :new.TRANSACTION_TYPE                         := t_new_rec.TRANSACTION_TYPE                              ;
    :new.RECEIPT_DATE                             := t_new_rec.RECEIPT_DATE                                  ;
    :new.RANGE_NO                                 := t_new_rec.RANGE_NO                                      ;
    :new.DIVISION_NO                              := t_new_rec.DIVISION_NO                                   ;
    :new.PO_HEADER_ID                             := t_new_rec.PO_HEADER_ID                                  ;
    :new.PO_HEADER_DATE                           := t_new_rec.PO_HEADER_DATE                                ;
    :new.PO_LINE_ID                               := t_new_rec.PO_LINE_ID                                    ;
    :new.PO_LINE_LOCATION_ID                      := t_new_rec.PO_LINE_LOCATION_ID                           ;
    :new.VENDOR_ID                                := t_new_rec.VENDOR_ID                                     ;
    :new.VENDOR_SITE_ID                           := t_new_rec.VENDOR_SITE_ID                                ;
    :new.CUSTOMER_ID                              := t_new_rec.CUSTOMER_ID                                   ;
    :new.CUSTOMER_SITE_ID                         := t_new_rec.CUSTOMER_SITE_ID                              ;
    :new.GOODS_ISSUE_ID_REF                       := t_new_rec.GOODS_ISSUE_ID_REF                            ;
    :new.GOODS_ISSUE_DATE                         := t_new_rec.GOODS_ISSUE_DATE                              ;
    :new.GOODS_ISSUE_QUANTITY                     := t_new_rec.GOODS_ISSUE_QUANTITY                          ;
    :new.SALES_INVOICE_NO                         := t_new_rec.SALES_INVOICE_NO                              ;
    :new.SALES_INVOICE_DATE                       := t_new_rec.SALES_INVOICE_DATE                            ;
    :new.SALES_INVOICE_QUANTITY                   := t_new_rec.SALES_INVOICE_QUANTITY                        ;
    :new.EXCISE_INVOICE_NO                        := t_new_rec.EXCISE_INVOICE_NO                             ;
    :new.EXCISE_INVOICE_DATE                      := t_new_rec.EXCISE_INVOICE_DATE                           ;
    :new.OTH_RECEIPT_QUANTITY                     := t_new_rec.OTH_RECEIPT_QUANTITY                          ;
    :new.OTH_RECEIPT_ID_REF                       := t_new_rec.OTH_RECEIPT_ID_REF                            ;
    :new.OTH_RECEIPT_DATE                         := t_new_rec.OTH_RECEIPT_DATE                              ;
    :new.REGISTER_TYPE                            := t_new_rec.REGISTER_TYPE                                 ;
    :new.IDENTIFICATION_NO                        := t_new_rec.IDENTIFICATION_NO                             ;
    :new.IDENTIFICATION_MARK                      := t_new_rec.IDENTIFICATION_MARK                           ;
    :new.BRAND_NAME                               := t_new_rec.BRAND_NAME                                    ;
    :new.DATE_OF_VERIFICATION                     := t_new_rec.DATE_OF_VERIFICATION                          ;
    :new.DATE_OF_INSTALLATION                     := t_new_rec.DATE_OF_INSTALLATION                          ;
    :new.DATE_OF_COMMISSION                       := t_new_rec.DATE_OF_COMMISSION                            ;
    :new.REGISTER_ID_PART_II                      := t_new_rec.REGISTER_ID_PART_II                           ;
    :new.PLACE_OF_INSTALL                         := t_new_rec.PLACE_OF_INSTALL                              ;
    :new.REMARKS                                  := t_new_rec.REMARKS                                       ;
    :new.LOCATION_ID                              := t_new_rec.LOCATION_ID                                   ;
    :new.PRIMARY_UOM_CODE                         := t_new_rec.PRIMARY_UOM_CODE                              ;
    :new.TRANSACTION_UOM_CODE                     := t_new_rec.TRANSACTION_UOM_CODE                          ;
    :new.TRANSACTION_DATE                         := t_new_rec.TRANSACTION_DATE                              ;
    :new.BASIC_ED                                 := t_new_rec.BASIC_ED                                      ;
    :new.ADDITIONAL_ED                            := t_new_rec.ADDITIONAL_ED                                 ;
    :new.OTHER_ED                                 := t_new_rec.OTHER_ED                                      ;
    :new.OPENING_BALANCE_QTY                      := t_new_rec.OPENING_BALANCE_QTY                           ;
    :new.CLOSING_BALANCE_QTY                      := t_new_rec.CLOSING_BALANCE_QTY                           ;
    :new.CHARGE_ACCOUNT_ID                        := t_new_rec.CHARGE_ACCOUNT_ID                             ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.POSTED_FLAG                              := t_new_rec.POSTED_FLAG                                   ;
    :new.MASTER_FLAG                              := t_new_rec.MASTER_FLAG                                   ;
    :new.BOL_ID                                   := t_new_rec.BOL_ID                                        ;
    :new.BOLLINE_NO                               := t_new_rec.BOLLINE_NO                                    ;
    :new.OBJECT_VERSION_NUMBER                    := t_new_rec.OBJECT_VERSION_NUMBER                         ;
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
    /*bug 9122545 - remove the changes done for 6012654. Validations
      in the trigger violate the coding standards. Same validations are
      present in the trigger package.*/
    IF ( :NEW.transaction_source_num = 18  ) THEN

      JAI_JRG_23AC1_TRIGGER_PKG.BRI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JRG_23AC1_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JRG_23AC1_BRIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_JRG_23AC1_BRIUD_T1" DISABLE;
