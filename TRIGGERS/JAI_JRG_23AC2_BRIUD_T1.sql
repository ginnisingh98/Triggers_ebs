--------------------------------------------------------
--  DDL for Trigger JAI_JRG_23AC2_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JRG_23AC2_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "JA"."JAI_CMN_RG_23AC_II_TRXS"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_CMN_RG_23AC_II_TRXS%rowtype ;
  t_new_rec             JAI_CMN_RG_23AC_II_TRXS%rowtype ;
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

    t_new_rec.REGISTER_ID                              := :new.REGISTER_ID                                   ;
    t_new_rec.FIN_YEAR                                 := :new.FIN_YEAR                                      ;
    t_new_rec.SLNO                                     := :new.SLNO                                          ;
    t_new_rec.TRANSACTION_SOURCE_NUM                   := :new.TRANSACTION_SOURCE_NUM                        ;
    t_new_rec.INVENTORY_ITEM_ID                        := :new.INVENTORY_ITEM_ID                             ;
    t_new_rec.ORGANIZATION_ID                          := :new.ORGANIZATION_ID                               ;
    t_new_rec.RECEIPT_REF                              := :new.RECEIPT_REF                                   ;
    t_new_rec.RECEIPT_DATE                             := :new.RECEIPT_DATE                                  ;
    t_new_rec.RANGE_NO                                 := :new.RANGE_NO                                      ;
    t_new_rec.DIVISION_NO                              := :new.DIVISION_NO                                   ;
    t_new_rec.CR_BASIC_ED                              := :new.CR_BASIC_ED                                   ;
    t_new_rec.CR_ADDITIONAL_ED                         := :new.CR_ADDITIONAL_ED                              ;
    t_new_rec.CR_OTHER_ED                              := :new.CR_OTHER_ED                                   ;
    t_new_rec.DR_BASIC_ED                              := :new.DR_BASIC_ED                                   ;
    t_new_rec.DR_ADDITIONAL_ED                         := :new.DR_ADDITIONAL_ED                              ;
    t_new_rec.DR_OTHER_ED                              := :new.DR_OTHER_ED                                   ;
    t_new_rec.EXCISE_INVOICE_NO                        := :new.EXCISE_INVOICE_NO                             ;
    t_new_rec.EXCISE_INVOICE_DATE                      := :new.EXCISE_INVOICE_DATE                           ;
    t_new_rec.REGISTER_TYPE                            := :new.REGISTER_TYPE                                 ;
    t_new_rec.REMARKS                                  := :new.REMARKS                                       ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.CUSTOMER_ID                              := :new.CUSTOMER_ID                                   ;
    t_new_rec.CUSTOMER_SITE_ID                         := :new.CUSTOMER_SITE_ID                              ;
    t_new_rec.LOCATION_ID                              := :new.LOCATION_ID                                   ;
    t_new_rec.TRANSACTION_DATE                         := :new.TRANSACTION_DATE                              ;
    t_new_rec.OPENING_BALANCE                          := :new.OPENING_BALANCE                               ;
    t_new_rec.CLOSING_BALANCE                          := :new.CLOSING_BALANCE                               ;
    t_new_rec.CHARGE_ACCOUNT_ID                        := :new.CHARGE_ACCOUNT_ID                             ;
    t_new_rec.REGISTER_ID_PART_I                       := :new.REGISTER_ID_PART_I                            ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.POSTED_FLAG                              := :new.POSTED_FLAG                                   ;
    t_new_rec.MASTER_FLAG                              := :new.MASTER_FLAG                                   ;
    t_new_rec.REFERENCE_NUM                            := :new.REFERENCE_NUM                                 ;
    t_new_rec.PERIOD_BALANCE_ID                        := :new.PERIOD_BALANCE_ID                             ;
    t_new_rec.ROUNDING_ID                              := :new.ROUNDING_ID                                   ;
    t_new_rec.OTHER_TAX_CREDIT                         := :new.OTHER_TAX_CREDIT                              ;
    t_new_rec.OTHER_TAX_DEBIT                          := :new.OTHER_TAX_DEBIT                               ;
    t_new_rec.BOL_ID                                   := :new.BOL_ID                                        ;
    t_new_rec.BOLLINE_NO                               := :new.BOLLINE_NO                                    ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
    /*addtional cvd columns added for bug 7637074*/
    t_new_rec.CR_ADDITIONAL_CVD                        := :new.CR_ADDITIONAL_CVD                             ;
    t_new_rec.DR_ADDITIONAL_CVD                        := :new.DR_ADDITIONAL_CVD                             ;
    t_new_rec.ADDITIONAL_CVD_AMT                       := :new.ADDITIONAL_CVD_AMT                            ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.REGISTER_ID                              := :old.REGISTER_ID                                   ;
    t_old_rec.FIN_YEAR                                 := :old.FIN_YEAR                                      ;
    t_old_rec.SLNO                                     := :old.SLNO                                          ;
    t_old_rec.TRANSACTION_SOURCE_NUM                   := :old.TRANSACTION_SOURCE_NUM                        ;
    t_old_rec.INVENTORY_ITEM_ID                        := :old.INVENTORY_ITEM_ID                             ;
    t_old_rec.ORGANIZATION_ID                          := :old.ORGANIZATION_ID                               ;
    t_old_rec.RECEIPT_REF                              := :old.RECEIPT_REF                                   ;
    t_old_rec.RECEIPT_DATE                             := :old.RECEIPT_DATE                                  ;
    t_old_rec.RANGE_NO                                 := :old.RANGE_NO                                      ;
    t_old_rec.DIVISION_NO                              := :old.DIVISION_NO                                   ;
    t_old_rec.CR_BASIC_ED                              := :old.CR_BASIC_ED                                   ;
    t_old_rec.CR_ADDITIONAL_ED                         := :old.CR_ADDITIONAL_ED                              ;
    t_old_rec.CR_OTHER_ED                              := :old.CR_OTHER_ED                                   ;
    t_old_rec.DR_BASIC_ED                              := :old.DR_BASIC_ED                                   ;
    t_old_rec.DR_ADDITIONAL_ED                         := :old.DR_ADDITIONAL_ED                              ;
    t_old_rec.DR_OTHER_ED                              := :old.DR_OTHER_ED                                   ;
    t_old_rec.EXCISE_INVOICE_NO                        := :old.EXCISE_INVOICE_NO                             ;
    t_old_rec.EXCISE_INVOICE_DATE                      := :old.EXCISE_INVOICE_DATE                           ;
    t_old_rec.REGISTER_TYPE                            := :old.REGISTER_TYPE                                 ;
    t_old_rec.REMARKS                                  := :old.REMARKS                                       ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.CUSTOMER_ID                              := :old.CUSTOMER_ID                                   ;
    t_old_rec.CUSTOMER_SITE_ID                         := :old.CUSTOMER_SITE_ID                              ;
    t_old_rec.LOCATION_ID                              := :old.LOCATION_ID                                   ;
    t_old_rec.TRANSACTION_DATE                         := :old.TRANSACTION_DATE                              ;
    t_old_rec.OPENING_BALANCE                          := :old.OPENING_BALANCE                               ;
    t_old_rec.CLOSING_BALANCE                          := :old.CLOSING_BALANCE                               ;
    t_old_rec.CHARGE_ACCOUNT_ID                        := :old.CHARGE_ACCOUNT_ID                             ;
    t_old_rec.REGISTER_ID_PART_I                       := :old.REGISTER_ID_PART_I                            ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.POSTED_FLAG                              := :old.POSTED_FLAG                                   ;
    t_old_rec.MASTER_FLAG                              := :old.MASTER_FLAG                                   ;
    t_old_rec.REFERENCE_NUM                            := :old.REFERENCE_NUM                                 ;
    t_old_rec.PERIOD_BALANCE_ID                        := :old.PERIOD_BALANCE_ID                             ;
    t_old_rec.ROUNDING_ID                              := :old.ROUNDING_ID                                   ;
    t_old_rec.OTHER_TAX_CREDIT                         := :old.OTHER_TAX_CREDIT                              ;
    t_old_rec.OTHER_TAX_DEBIT                          := :old.OTHER_TAX_DEBIT                               ;
    t_old_rec.BOL_ID                                   := :old.BOL_ID                                        ;
    t_old_rec.BOLLINE_NO                               := :old.BOLLINE_NO                                    ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
    /*addtional cvd columns added for bug 7637074*/
    t_old_rec.CR_ADDITIONAL_CVD                        := :old.CR_ADDITIONAL_CVD                             ;
    t_old_rec.DR_ADDITIONAL_CVD                        := :old.DR_ADDITIONAL_CVD                             ;
    t_old_rec.ADDITIONAL_CVD_AMT                       := :old.ADDITIONAL_CVD_AMT                            ;
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
    :new.RECEIPT_REF                              := t_new_rec.RECEIPT_REF                                   ;
    :new.RECEIPT_DATE                             := t_new_rec.RECEIPT_DATE                                  ;
    :new.RANGE_NO                                 := t_new_rec.RANGE_NO                                      ;
    :new.DIVISION_NO                              := t_new_rec.DIVISION_NO                                   ;
    :new.CR_BASIC_ED                              := t_new_rec.CR_BASIC_ED                                   ;
    :new.CR_ADDITIONAL_ED                         := t_new_rec.CR_ADDITIONAL_ED                              ;
    :new.CR_OTHER_ED                              := t_new_rec.CR_OTHER_ED                                   ;
    :new.DR_BASIC_ED                              := t_new_rec.DR_BASIC_ED                                   ;
    :new.DR_ADDITIONAL_ED                         := t_new_rec.DR_ADDITIONAL_ED                              ;
    :new.DR_OTHER_ED                              := t_new_rec.DR_OTHER_ED                                   ;
    :new.EXCISE_INVOICE_NO                        := t_new_rec.EXCISE_INVOICE_NO                             ;
    :new.EXCISE_INVOICE_DATE                      := t_new_rec.EXCISE_INVOICE_DATE                           ;
    :new.REGISTER_TYPE                            := t_new_rec.REGISTER_TYPE                                 ;
    :new.REMARKS                                  := t_new_rec.REMARKS                                       ;
    :new.VENDOR_ID                                := t_new_rec.VENDOR_ID                                     ;
    :new.VENDOR_SITE_ID                           := t_new_rec.VENDOR_SITE_ID                                ;
    :new.CUSTOMER_ID                              := t_new_rec.CUSTOMER_ID                                   ;
    :new.CUSTOMER_SITE_ID                         := t_new_rec.CUSTOMER_SITE_ID                              ;
    :new.LOCATION_ID                              := t_new_rec.LOCATION_ID                                   ;
    :new.TRANSACTION_DATE                         := t_new_rec.TRANSACTION_DATE                              ;
    :new.OPENING_BALANCE                          := t_new_rec.OPENING_BALANCE                               ;
    :new.CLOSING_BALANCE                          := t_new_rec.CLOSING_BALANCE                               ;
    :new.CHARGE_ACCOUNT_ID                        := t_new_rec.CHARGE_ACCOUNT_ID                             ;
    :new.REGISTER_ID_PART_I                       := t_new_rec.REGISTER_ID_PART_I                            ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.POSTED_FLAG                              := t_new_rec.POSTED_FLAG                                   ;
    :new.MASTER_FLAG                              := t_new_rec.MASTER_FLAG                                   ;
    :new.REFERENCE_NUM                            := t_new_rec.REFERENCE_NUM                                 ;
    :new.PERIOD_BALANCE_ID                        := t_new_rec.PERIOD_BALANCE_ID                             ;
    :new.ROUNDING_ID                              := t_new_rec.ROUNDING_ID                                   ;
    :new.OTHER_TAX_CREDIT                         := t_new_rec.OTHER_TAX_CREDIT                              ;
    :new.OTHER_TAX_DEBIT                          := t_new_rec.OTHER_TAX_DEBIT                               ;
    :new.BOL_ID                                   := t_new_rec.BOL_ID                                        ;
    :new.BOLLINE_NO                               := t_new_rec.BOLLINE_NO                                    ;
    :new.OBJECT_VERSION_NUMBER                    := t_new_rec.OBJECT_VERSION_NUMBER                         ;
    /*additional cvd columns added for bug 7637074*/
    :new.CR_ADDITIONAL_CVD                        := t_new_rec.CR_ADDITIONAL_CVD                             ;
    :new.DR_ADDITIONAL_CVD                        := t_new_rec.DR_ADDITIONAL_CVD                             ;
    :new.ADDITIONAL_CVD_AMT                       := t_new_rec.ADDITIONAL_CVD_AMT                            ;
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

      JAI_JRG_23AC2_TRIGGER_PKG.BRI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JRG_23AC2_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JRG_23AC2_BRIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_JRG_23AC2_BRIUD_T1" DISABLE;
