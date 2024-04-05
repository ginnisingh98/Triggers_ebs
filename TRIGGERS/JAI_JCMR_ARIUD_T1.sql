--------------------------------------------------------
--  DDL for Trigger JAI_JCMR_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JCMR_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "JA"."JAI_CMN_MATCH_RECEIPTS"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_CMN_MATCH_RECEIPTS%rowtype ;
  t_new_rec             JAI_CMN_MATCH_RECEIPTS%rowtype ;
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

    t_new_rec.RECEIPT_ID                               := :new.RECEIPT_ID                                    ;
    t_new_rec.REF_LINE_ID                              := :new.REF_LINE_ID                                   ;
    t_new_rec.SUBINVENTORY                             := :new.SUBINVENTORY                                  ;
    t_new_rec.QUANTITY_APPLIED                         := :new.QUANTITY_APPLIED                              ;
    t_new_rec.ISSUE_UOM                                := :new.ISSUE_UOM                                     ;
    t_new_rec.ORDER_INVOICE                            := :new.ORDER_INVOICE                                 ;
    t_new_rec.SHIP_STATUS                              := :new.SHIP_STATUS                                   ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.RECEIPT_QUANTITY_APPLIED                 := :new.RECEIPT_QUANTITY_APPLIED                      ;
    t_new_rec.RECEIPT_QUANTITY_UOM                     := :new.RECEIPT_QUANTITY_UOM                          ;
    t_new_rec.REF_LINE_NO                              := :new.REF_LINE_NO                                   ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.RECEIPT_ID                               := :old.RECEIPT_ID                                    ;
    t_old_rec.REF_LINE_ID                              := :old.REF_LINE_ID                                   ;
    t_old_rec.SUBINVENTORY                             := :old.SUBINVENTORY                                  ;
    t_old_rec.QUANTITY_APPLIED                         := :old.QUANTITY_APPLIED                              ;
    t_old_rec.ISSUE_UOM                                := :old.ISSUE_UOM                                     ;
    t_old_rec.ORDER_INVOICE                            := :old.ORDER_INVOICE                                 ;
    t_old_rec.SHIP_STATUS                              := :old.SHIP_STATUS                                   ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.RECEIPT_QUANTITY_APPLIED                 := :old.RECEIPT_QUANTITY_APPLIED                      ;
    t_old_rec.RECEIPT_QUANTITY_UOM                     := :old.RECEIPT_QUANTITY_UOM                          ;
    t_old_rec.REF_LINE_NO                              := :old.REF_LINE_NO                                   ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
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

    IF ( (NVL(:NEW.ship_status,'OPEN') <> 'CLOSED') AND :NEW.ORDER_INVOICE  ='I' ) THEN

      JAI_JMCR_TRIGGER_PKG.ARIU_T1 (
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

    IF ( (NVL(:NEW.ship_status,'OPEN') <> 'CLOSED') AND :NEW.ORDER_INVOICE IN( 'O','X') ) THEN --added 'X' bny vkaranam for bug #6030615

      JAI_JMCR_TRIGGER_PKG.ARIU_T2 (
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

    IF ( (NVL(:NEW.ship_status,'OPEN') <> 'CLOSED') AND :NEW.ORDER_INVOICE = 'I'  ) THEN

      JAI_JMCR_TRIGGER_PKG.ARIU_T1 (
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

    IF ( (NVL(:NEW.ship_status,'OPEN') <> 'CLOSED') AND :NEW.ORDER_INVOICE IN ('O' ,'X')) THEN --added 'X' bny vkaranam for bug #6030615

      JAI_JMCR_TRIGGER_PKG.ARIU_T2 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JCMR_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JCMR_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_JCMR_ARIUD_T1" DISABLE;
