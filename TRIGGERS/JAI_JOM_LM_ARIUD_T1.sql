--------------------------------------------------------
--  DDL for Trigger JAI_JOM_LM_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JOM_LM_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "JA"."JAI_OM_LC_MATCHINGS"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_OM_LC_MATCHINGS%rowtype ;
  t_new_rec             JAI_OM_LC_MATCHINGS%rowtype ;
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

    t_new_rec.SLNO                                     := :new.SLNO                                          ;
    t_new_rec.CUSTOMER_ID                              := :new.CUSTOMER_ID                                   ;
    t_new_rec.ORDER_HEADER_ID                          := :new.ORDER_HEADER_ID                               ;
    t_new_rec.ORDER_LINE_ID                            := :new.ORDER_LINE_ID                                 ;
    t_new_rec.QTY_RELEASED                             := :new.QTY_RELEASED                                  ;
    t_new_rec.QTY_MATCHED                              := :new.QTY_MATCHED                                   ;
    t_new_rec.LC_TYPE                                  := :new.LC_TYPE                                       ;
    t_new_rec.LC_NUMBER                                := :new.LC_NUMBER                                     ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.RELEASE_FLAG                             := :new.RELEASE_FLAG                                  ;
    t_new_rec.DELIVERY_DETAIL_ID                       := :new.DELIVERY_DETAIL_ID                            ;
    t_new_rec.ATTRIBUTE1                               := :new.ATTRIBUTE1                                    ;
    t_new_rec.ATTRIBUTE2                               := :new.ATTRIBUTE2                                    ;
    t_new_rec.MATCHING_ID                              := :new.MATCHING_ID                                   ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.SLNO                                     := :old.SLNO                                          ;
    t_old_rec.CUSTOMER_ID                              := :old.CUSTOMER_ID                                   ;
    t_old_rec.ORDER_HEADER_ID                          := :old.ORDER_HEADER_ID                               ;
    t_old_rec.ORDER_LINE_ID                            := :old.ORDER_LINE_ID                                 ;
    t_old_rec.QTY_RELEASED                             := :old.QTY_RELEASED                                  ;
    t_old_rec.QTY_MATCHED                              := :old.QTY_MATCHED                                   ;
    t_old_rec.LC_TYPE                                  := :old.LC_TYPE                                       ;
    t_old_rec.LC_NUMBER                                := :old.LC_NUMBER                                     ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.RELEASE_FLAG                             := :old.RELEASE_FLAG                                  ;
    t_old_rec.DELIVERY_DETAIL_ID                       := :old.DELIVERY_DETAIL_ID                            ;
    t_old_rec.ATTRIBUTE1                               := :old.ATTRIBUTE1                                    ;
    t_old_rec.ATTRIBUTE2                               := :old.ATTRIBUTE2                                    ;
    t_old_rec.MATCHING_ID                              := :old.MATCHING_ID                                   ;
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

      JAI_JOM_LM_TRIGGER_PKG.ARI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JOM_LM_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JOM_LM_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_JOM_LM_ARIUD_T1" DISABLE;
