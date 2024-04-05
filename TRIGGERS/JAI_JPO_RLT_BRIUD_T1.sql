--------------------------------------------------------
--  DDL for Trigger JAI_JPO_RLT_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JPO_RLT_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "JA"."JAI_PO_REQ_LINE_TAXES"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_PO_REQ_LINE_TAXES%rowtype ;
  t_new_rec             JAI_PO_REQ_LINE_TAXES%rowtype ;
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

    t_new_rec.REQUISITION_LINE_ID                      := :new.REQUISITION_LINE_ID                           ;
    t_new_rec.TAX_LINE_NO                              := :new.TAX_LINE_NO                                   ;
    t_new_rec.REQUISITION_HEADER_ID                    := :new.REQUISITION_HEADER_ID                         ;
    t_new_rec.PRECEDENCE_1                             := :new.PRECEDENCE_1                                  ;
    t_new_rec.PRECEDENCE_2                             := :new.PRECEDENCE_2                                  ;
    t_new_rec.PRECEDENCE_3                             := :new.PRECEDENCE_3                                  ;
    t_new_rec.PRECEDENCE_4                             := :new.PRECEDENCE_4                                  ;
    t_new_rec.PRECEDENCE_5                             := :new.PRECEDENCE_5                                  ;
    t_new_rec.TAX_ID                                   := :new.TAX_ID                                        ;
    t_new_rec.CURRENCY                                 := :new.CURRENCY                                      ;
    t_new_rec.TAX_RATE                                 := :new.TAX_RATE                                      ;
    t_new_rec.QTY_RATE                                 := :new.QTY_RATE                                      ;
    t_new_rec.UOM                                      := :new.UOM                                           ;
    t_new_rec.TAX_AMOUNT                               := :new.TAX_AMOUNT                                    ;
    t_new_rec.TAX_TYPE                                 := :new.TAX_TYPE                                      ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.MODVAT_FLAG                              := :new.MODVAT_FLAG                                   ;
    t_new_rec.TAX_TARGET_AMOUNT                        := :new.TAX_TARGET_AMOUNT                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.TAX_CATEGORY_ID                          := :new.TAX_CATEGORY_ID                               ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.REQUISITION_LINE_ID                      := :old.REQUISITION_LINE_ID                           ;
    t_old_rec.TAX_LINE_NO                              := :old.TAX_LINE_NO                                   ;
    t_old_rec.REQUISITION_HEADER_ID                    := :old.REQUISITION_HEADER_ID                         ;
    t_old_rec.PRECEDENCE_1                             := :old.PRECEDENCE_1                                  ;
    t_old_rec.PRECEDENCE_2                             := :old.PRECEDENCE_2                                  ;
    t_old_rec.PRECEDENCE_3                             := :old.PRECEDENCE_3                                  ;
    t_old_rec.PRECEDENCE_4                             := :old.PRECEDENCE_4                                  ;
    t_old_rec.PRECEDENCE_5                             := :old.PRECEDENCE_5                                  ;
    t_old_rec.TAX_ID                                   := :old.TAX_ID                                        ;
    t_old_rec.CURRENCY                                 := :old.CURRENCY                                      ;
    t_old_rec.TAX_RATE                                 := :old.TAX_RATE                                      ;
    t_old_rec.QTY_RATE                                 := :old.QTY_RATE                                      ;
    t_old_rec.UOM                                      := :old.UOM                                           ;
    t_old_rec.TAX_AMOUNT                               := :old.TAX_AMOUNT                                    ;
    t_old_rec.TAX_TYPE                                 := :old.TAX_TYPE                                      ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.MODVAT_FLAG                              := :old.MODVAT_FLAG                                   ;
    t_old_rec.TAX_TARGET_AMOUNT                        := :old.TAX_TARGET_AMOUNT                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.TAX_CATEGORY_ID                          := :old.TAX_CATEGORY_ID                               ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
  END populate_old ;

    /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.REQUISITION_LINE_ID                      := t_new_rec.REQUISITION_LINE_ID                           ;
    :new.TAX_LINE_NO                              := t_new_rec.TAX_LINE_NO                                   ;
    :new.REQUISITION_HEADER_ID                    := t_new_rec.REQUISITION_HEADER_ID                         ;
    :new.PRECEDENCE_1                             := t_new_rec.PRECEDENCE_1                                  ;
    :new.PRECEDENCE_2                             := t_new_rec.PRECEDENCE_2                                  ;
    :new.PRECEDENCE_3                             := t_new_rec.PRECEDENCE_3                                  ;
    :new.PRECEDENCE_4                             := t_new_rec.PRECEDENCE_4                                  ;
    :new.PRECEDENCE_5                             := t_new_rec.PRECEDENCE_5                                  ;
    :new.TAX_ID                                   := t_new_rec.TAX_ID                                        ;
    :new.CURRENCY                                 := t_new_rec.CURRENCY                                      ;
    :new.TAX_RATE                                 := t_new_rec.TAX_RATE                                      ;
    :new.QTY_RATE                                 := t_new_rec.QTY_RATE                                      ;
    :new.UOM                                      := t_new_rec.UOM                                           ;
    :new.TAX_AMOUNT                               := t_new_rec.TAX_AMOUNT                                    ;
    :new.TAX_TYPE                                 := t_new_rec.TAX_TYPE                                      ;
    :new.VENDOR_ID                                := t_new_rec.VENDOR_ID                                     ;
    :new.MODVAT_FLAG                              := t_new_rec.MODVAT_FLAG                                   ;
    :new.TAX_TARGET_AMOUNT                        := t_new_rec.TAX_TARGET_AMOUNT                             ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.TAX_CATEGORY_ID                          := t_new_rec.TAX_CATEGORY_ID                               ;
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

  IF UPDATING THEN

    IF ( :OLD.tax_category_id IS NOT NULL AND :OLD.tax_id <> :NEW.tax_id ) THEN

      JAI_JPO_RLT_TRIGGER_PKG.BRU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JPO_RLT_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JPO_RLT_BRIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_JPO_RLT_BRIUD_T1" DISABLE;
