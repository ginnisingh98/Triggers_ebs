--------------------------------------------------------
--  DDL for Trigger JAI_JAR_T_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JAR_T_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "JA"."JAI_AR_TRXS"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_AR_TRXS%rowtype ;
  t_new_rec             JAI_AR_TRXS%rowtype ;
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

    t_new_rec.CUSTOMER_TRX_ID                          := :new.CUSTOMER_TRX_ID                               ;
    t_new_rec.ORGANIZATION_ID                          := :new.ORGANIZATION_ID                               ;
    t_new_rec.LOCATION_ID                              := :new.LOCATION_ID                                   ;
    t_new_rec.UPDATE_RG_FLAG                           := :new.UPDATE_RG_FLAG                                ;
    t_new_rec.ONCE_COMPLETED_FLAG                      := :new.ONCE_COMPLETED_FLAG                           ;
    t_new_rec.TOTAL_AMOUNT                             := :new.TOTAL_AMOUNT                                  ;
    t_new_rec.LINE_AMOUNT                              := :new.LINE_AMOUNT                                   ;
    t_new_rec.TAX_AMOUNT                               := :new.TAX_AMOUNT                                    ;
    t_new_rec.TRX_NUMBER                               := :new.TRX_NUMBER                                    ;
    t_new_rec.BATCH_SOURCE_ID                          := :new.BATCH_SOURCE_ID                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.PRIMARY_SALESREP_ID                      := :new.PRIMARY_SALESREP_ID                           ;
    t_new_rec.INVOICE_CURRENCY_CODE                    := :new.INVOICE_CURRENCY_CODE                         ;
    t_new_rec.EXCHANGE_RATE_TYPE                       := :new.EXCHANGE_RATE_TYPE                            ;
    t_new_rec.EXCHANGE_DATE                            := :new.EXCHANGE_DATE                                 ;
    t_new_rec.EXCHANGE_RATE                            := :new.EXCHANGE_RATE                                 ;
    t_new_rec.CREATED_FROM                             := :new.CREATED_FROM                                  ;
    t_new_rec.UPDATE_RG23D_FLAG                        := :new.UPDATE_RG23D_FLAG                             ;
    t_new_rec.TAX_INVOICE_NO                           := :new.TAX_INVOICE_NO                                ;
    t_new_rec.VAT_INVOICE_NO                           := :new.VAT_INVOICE_NO                                ;
    t_new_rec.VAT_INVOICE_DATE                         := :new.VAT_INVOICE_DATE                              ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
    t_new_rec.LEGAL_ENTITY_ID                          := :new.LEGAL_ENTITY_ID                               ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.CUSTOMER_TRX_ID                          := :old.CUSTOMER_TRX_ID                               ;
    t_old_rec.ORGANIZATION_ID                          := :old.ORGANIZATION_ID                               ;
    t_old_rec.LOCATION_ID                              := :old.LOCATION_ID                                   ;
    t_old_rec.UPDATE_RG_FLAG                           := :old.UPDATE_RG_FLAG                                ;
    t_old_rec.ONCE_COMPLETED_FLAG                      := :old.ONCE_COMPLETED_FLAG                           ;
    t_old_rec.TOTAL_AMOUNT                             := :old.TOTAL_AMOUNT                                  ;
    t_old_rec.LINE_AMOUNT                              := :old.LINE_AMOUNT                                   ;
    t_old_rec.TAX_AMOUNT                               := :old.TAX_AMOUNT                                    ;
    t_old_rec.TRX_NUMBER                               := :old.TRX_NUMBER                                    ;
    t_old_rec.BATCH_SOURCE_ID                          := :old.BATCH_SOURCE_ID                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.PRIMARY_SALESREP_ID                      := :old.PRIMARY_SALESREP_ID                           ;
    t_old_rec.INVOICE_CURRENCY_CODE                    := :old.INVOICE_CURRENCY_CODE                         ;
    t_old_rec.EXCHANGE_RATE_TYPE                       := :old.EXCHANGE_RATE_TYPE                            ;
    t_old_rec.EXCHANGE_DATE                            := :old.EXCHANGE_DATE                                 ;
    t_old_rec.EXCHANGE_RATE                            := :old.EXCHANGE_RATE                                 ;
    t_old_rec.CREATED_FROM                             := :old.CREATED_FROM                                  ;
    t_old_rec.UPDATE_RG23D_FLAG                        := :old.UPDATE_RG23D_FLAG                             ;
    t_old_rec.TAX_INVOICE_NO                           := :old.TAX_INVOICE_NO                                ;
    t_old_rec.VAT_INVOICE_NO                           := :old.VAT_INVOICE_NO                                ;
    t_old_rec.VAT_INVOICE_DATE                         := :old.VAT_INVOICE_DATE                              ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
    t_old_rec.LEGAL_ENTITY_ID                          := :old.LEGAL_ENTITY_ID                               ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_JAR_T_ARIUD_T1', p_set_of_books_id => :new.set_of_books_id ) = FALSE THEN
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

    IF ( :NEW.ONCE_COMPLETED_FLAG = 'Y' ) THEN

      JAI_JAR_TRXS_TRIGGER_PKG.ARU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JAR_T_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JAR_T_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_JAR_T_ARIUD_T1" DISABLE;
