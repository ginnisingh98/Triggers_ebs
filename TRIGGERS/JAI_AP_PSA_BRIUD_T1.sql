--------------------------------------------------------
--  DDL for Trigger JAI_AP_PSA_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AP_PSA_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "AP"."AP_PAYMENT_SCHEDULES_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             AP_PAYMENT_SCHEDULES_ALL%rowtype ;
  t_new_rec             AP_PAYMENT_SCHEDULES_ALL%rowtype ;
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

    t_new_rec.INVOICE_ID                               := :new.INVOICE_ID                                    ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.PAYMENT_CROSS_RATE                       := :new.PAYMENT_CROSS_RATE                            ;
    t_new_rec.PAYMENT_NUM                              := :new.PAYMENT_NUM                                   ;
    t_new_rec.AMOUNT_REMAINING                         := :new.AMOUNT_REMAINING                              ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.DISCOUNT_DATE                            := :new.DISCOUNT_DATE                                 ;
    t_new_rec.DUE_DATE                                 := :new.DUE_DATE                                      ;
    t_new_rec.FUTURE_PAY_DUE_DATE                      := :new.FUTURE_PAY_DUE_DATE                           ;
    t_new_rec.GROSS_AMOUNT                             := :new.GROSS_AMOUNT                                  ;
    t_new_rec.HOLD_FLAG                                := :new.HOLD_FLAG                                     ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.PAYMENT_METHOD_LOOKUP_CODE               := :new.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_new_rec.PAYMENT_PRIORITY                         := :new.PAYMENT_PRIORITY                              ;
    t_new_rec.PAYMENT_STATUS_FLAG                      := :new.PAYMENT_STATUS_FLAG                           ;
    t_new_rec.SECOND_DISCOUNT_DATE                     := :new.SECOND_DISCOUNT_DATE                          ;
    t_new_rec.THIRD_DISCOUNT_DATE                      := :new.THIRD_DISCOUNT_DATE                           ;
    t_new_rec.BATCH_ID                                 := :new.BATCH_ID                                      ;
    t_new_rec.DISCOUNT_AMOUNT_AVAILABLE                := :new.DISCOUNT_AMOUNT_AVAILABLE                     ;
    t_new_rec.SECOND_DISC_AMT_AVAILABLE                := :new.SECOND_DISC_AMT_AVAILABLE                     ;
    t_new_rec.THIRD_DISC_AMT_AVAILABLE                 := :new.THIRD_DISC_AMT_AVAILABLE                      ;
    t_new_rec.ATTRIBUTE1                               := :new.ATTRIBUTE1                                    ;
    t_new_rec.ATTRIBUTE10                              := :new.ATTRIBUTE10                                   ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.ATTRIBUTE2                               := :new.ATTRIBUTE2                                    ;
    t_new_rec.ATTRIBUTE3                               := :new.ATTRIBUTE3                                    ;
    t_new_rec.ATTRIBUTE4                               := :new.ATTRIBUTE4                                    ;
    t_new_rec.ATTRIBUTE5                               := :new.ATTRIBUTE5                                    ;
    t_new_rec.ATTRIBUTE6                               := :new.ATTRIBUTE6                                    ;
    t_new_rec.ATTRIBUTE7                               := :new.ATTRIBUTE7                                    ;
    t_new_rec.ATTRIBUTE8                               := :new.ATTRIBUTE8                                    ;
    t_new_rec.ATTRIBUTE9                               := :new.ATTRIBUTE9                                    ;
    t_new_rec.ATTRIBUTE_CATEGORY                       := :new.ATTRIBUTE_CATEGORY                            ;
    t_new_rec.DISCOUNT_AMOUNT_REMAINING                := :new.DISCOUNT_AMOUNT_REMAINING                     ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :new.GLOBAL_ATTRIBUTE_CATEGORY                     ;
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
    t_new_rec.EXTERNAL_BANK_ACCOUNT_ID                 := :new.EXTERNAL_BANK_ACCOUNT_ID                      ;
    t_new_rec.INV_CURR_GROSS_AMOUNT                    := :new.INV_CURR_GROSS_AMOUNT                         ;
    t_new_rec.CHECKRUN_ID                              := :new.CHECKRUN_ID                                   ;
    t_new_rec.DBI_EVENTS_COMPLETE_FLAG                 := :new.DBI_EVENTS_COMPLETE_FLAG                      ;
    t_new_rec.IBY_HOLD_REASON                          := :new.IBY_HOLD_REASON                               ;
    t_new_rec.PAYMENT_METHOD_CODE                      := :new.PAYMENT_METHOD_CODE                           ;
    t_new_rec.REMITTANCE_MESSAGE1                      := :new.REMITTANCE_MESSAGE1                           ;
    t_new_rec.REMITTANCE_MESSAGE2                      := :new.REMITTANCE_MESSAGE2                           ;
    t_new_rec.REMITTANCE_MESSAGE3                      := :new.REMITTANCE_MESSAGE3                           ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.INVOICE_ID                               := :old.INVOICE_ID                                    ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.PAYMENT_CROSS_RATE                       := :old.PAYMENT_CROSS_RATE                            ;
    t_old_rec.PAYMENT_NUM                              := :old.PAYMENT_NUM                                   ;
    t_old_rec.AMOUNT_REMAINING                         := :old.AMOUNT_REMAINING                              ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.DISCOUNT_DATE                            := :old.DISCOUNT_DATE                                 ;
    t_old_rec.DUE_DATE                                 := :old.DUE_DATE                                      ;
    t_old_rec.FUTURE_PAY_DUE_DATE                      := :old.FUTURE_PAY_DUE_DATE                           ;
    t_old_rec.GROSS_AMOUNT                             := :old.GROSS_AMOUNT                                  ;
    t_old_rec.HOLD_FLAG                                := :old.HOLD_FLAG                                     ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.PAYMENT_METHOD_LOOKUP_CODE               := :old.PAYMENT_METHOD_LOOKUP_CODE                    ;
    t_old_rec.PAYMENT_PRIORITY                         := :old.PAYMENT_PRIORITY                              ;
    t_old_rec.PAYMENT_STATUS_FLAG                      := :old.PAYMENT_STATUS_FLAG                           ;
    t_old_rec.SECOND_DISCOUNT_DATE                     := :old.SECOND_DISCOUNT_DATE                          ;
    t_old_rec.THIRD_DISCOUNT_DATE                      := :old.THIRD_DISCOUNT_DATE                           ;
    t_old_rec.BATCH_ID                                 := :old.BATCH_ID                                      ;
    t_old_rec.DISCOUNT_AMOUNT_AVAILABLE                := :old.DISCOUNT_AMOUNT_AVAILABLE                     ;
    t_old_rec.SECOND_DISC_AMT_AVAILABLE                := :old.SECOND_DISC_AMT_AVAILABLE                     ;
    t_old_rec.THIRD_DISC_AMT_AVAILABLE                 := :old.THIRD_DISC_AMT_AVAILABLE                      ;
    t_old_rec.ATTRIBUTE1                               := :old.ATTRIBUTE1                                    ;
    t_old_rec.ATTRIBUTE10                              := :old.ATTRIBUTE10                                   ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.ATTRIBUTE2                               := :old.ATTRIBUTE2                                    ;
    t_old_rec.ATTRIBUTE3                               := :old.ATTRIBUTE3                                    ;
    t_old_rec.ATTRIBUTE4                               := :old.ATTRIBUTE4                                    ;
    t_old_rec.ATTRIBUTE5                               := :old.ATTRIBUTE5                                    ;
    t_old_rec.ATTRIBUTE6                               := :old.ATTRIBUTE6                                    ;
    t_old_rec.ATTRIBUTE7                               := :old.ATTRIBUTE7                                    ;
    t_old_rec.ATTRIBUTE8                               := :old.ATTRIBUTE8                                    ;
    t_old_rec.ATTRIBUTE9                               := :old.ATTRIBUTE9                                    ;
    t_old_rec.ATTRIBUTE_CATEGORY                       := :old.ATTRIBUTE_CATEGORY                            ;
    t_old_rec.DISCOUNT_AMOUNT_REMAINING                := :old.DISCOUNT_AMOUNT_REMAINING                     ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :old.GLOBAL_ATTRIBUTE_CATEGORY                     ;
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
    t_old_rec.EXTERNAL_BANK_ACCOUNT_ID                 := :old.EXTERNAL_BANK_ACCOUNT_ID                      ;
    t_old_rec.INV_CURR_GROSS_AMOUNT                    := :old.INV_CURR_GROSS_AMOUNT                         ;
    t_old_rec.CHECKRUN_ID                              := :old.CHECKRUN_ID                                   ;
    t_old_rec.DBI_EVENTS_COMPLETE_FLAG                 := :old.DBI_EVENTS_COMPLETE_FLAG                      ;
    t_old_rec.IBY_HOLD_REASON                          := :old.IBY_HOLD_REASON                               ;
    t_old_rec.PAYMENT_METHOD_CODE                      := :old.PAYMENT_METHOD_CODE                           ;
    t_old_rec.REMITTANCE_MESSAGE1                      := :old.REMITTANCE_MESSAGE1                           ;
    t_old_rec.REMITTANCE_MESSAGE2                      := :old.REMITTANCE_MESSAGE2                           ;
    t_old_rec.REMITTANCE_MESSAGE3                      := :old.REMITTANCE_MESSAGE3                           ;
  END populate_old ;

   /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.INVOICE_ID                               := t_new_rec.INVOICE_ID                                    ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.PAYMENT_CROSS_RATE                       := t_new_rec.PAYMENT_CROSS_RATE                            ;
    :new.PAYMENT_NUM                              := t_new_rec.PAYMENT_NUM                                   ;
    :new.AMOUNT_REMAINING                         := t_new_rec.AMOUNT_REMAINING                              ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.DISCOUNT_DATE                            := t_new_rec.DISCOUNT_DATE                                 ;
    :new.DUE_DATE                                 := t_new_rec.DUE_DATE                                      ;
    :new.FUTURE_PAY_DUE_DATE                      := t_new_rec.FUTURE_PAY_DUE_DATE                           ;
    :new.GROSS_AMOUNT                             := t_new_rec.GROSS_AMOUNT                                  ;
    :new.HOLD_FLAG                                := t_new_rec.HOLD_FLAG                                     ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.PAYMENT_METHOD_LOOKUP_CODE               := t_new_rec.PAYMENT_METHOD_LOOKUP_CODE                    ;
    :new.PAYMENT_PRIORITY                         := t_new_rec.PAYMENT_PRIORITY                              ;
    :new.PAYMENT_STATUS_FLAG                      := t_new_rec.PAYMENT_STATUS_FLAG                           ;
    :new.SECOND_DISCOUNT_DATE                     := t_new_rec.SECOND_DISCOUNT_DATE                          ;
    :new.THIRD_DISCOUNT_DATE                      := t_new_rec.THIRD_DISCOUNT_DATE                           ;
    :new.BATCH_ID                                 := t_new_rec.BATCH_ID                                      ;
    :new.DISCOUNT_AMOUNT_AVAILABLE                := t_new_rec.DISCOUNT_AMOUNT_AVAILABLE                     ;
    :new.SECOND_DISC_AMT_AVAILABLE                := t_new_rec.SECOND_DISC_AMT_AVAILABLE                     ;
    :new.THIRD_DISC_AMT_AVAILABLE                 := t_new_rec.THIRD_DISC_AMT_AVAILABLE                      ;
    :new.ATTRIBUTE1                               := t_new_rec.ATTRIBUTE1                                    ;
    :new.ATTRIBUTE10                              := t_new_rec.ATTRIBUTE10                                   ;
    :new.ATTRIBUTE11                              := t_new_rec.ATTRIBUTE11                                   ;
    :new.ATTRIBUTE12                              := t_new_rec.ATTRIBUTE12                                   ;
    :new.ATTRIBUTE13                              := t_new_rec.ATTRIBUTE13                                   ;
    :new.ATTRIBUTE14                              := t_new_rec.ATTRIBUTE14                                   ;
    :new.ATTRIBUTE15                              := t_new_rec.ATTRIBUTE15                                   ;
    :new.ATTRIBUTE2                               := t_new_rec.ATTRIBUTE2                                    ;
    :new.ATTRIBUTE3                               := t_new_rec.ATTRIBUTE3                                    ;
    :new.ATTRIBUTE4                               := t_new_rec.ATTRIBUTE4                                    ;
    :new.ATTRIBUTE5                               := t_new_rec.ATTRIBUTE5                                    ;
    :new.ATTRIBUTE6                               := t_new_rec.ATTRIBUTE6                                    ;
    :new.ATTRIBUTE7                               := t_new_rec.ATTRIBUTE7                                    ;
    :new.ATTRIBUTE8                               := t_new_rec.ATTRIBUTE8                                    ;
    :new.ATTRIBUTE9                               := t_new_rec.ATTRIBUTE9                                    ;
    :new.ATTRIBUTE_CATEGORY                       := t_new_rec.ATTRIBUTE_CATEGORY                            ;
    :new.DISCOUNT_AMOUNT_REMAINING                := t_new_rec.DISCOUNT_AMOUNT_REMAINING                     ;
    :new.ORG_ID                                   := t_new_rec.ORG_ID                                        ;
    :new.GLOBAL_ATTRIBUTE_CATEGORY                := t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    :new.GLOBAL_ATTRIBUTE1                        := t_new_rec.GLOBAL_ATTRIBUTE1                             ;
    :new.GLOBAL_ATTRIBUTE2                        := t_new_rec.GLOBAL_ATTRIBUTE2                             ;
    :new.GLOBAL_ATTRIBUTE3                        := t_new_rec.GLOBAL_ATTRIBUTE3                             ;
    :new.GLOBAL_ATTRIBUTE4                        := t_new_rec.GLOBAL_ATTRIBUTE4                             ;
    :new.GLOBAL_ATTRIBUTE5                        := t_new_rec.GLOBAL_ATTRIBUTE5                             ;
    :new.GLOBAL_ATTRIBUTE6                        := t_new_rec.GLOBAL_ATTRIBUTE6                             ;
    :new.GLOBAL_ATTRIBUTE7                        := t_new_rec.GLOBAL_ATTRIBUTE7                             ;
    :new.GLOBAL_ATTRIBUTE8                        := t_new_rec.GLOBAL_ATTRIBUTE8                             ;
    :new.GLOBAL_ATTRIBUTE9                        := t_new_rec.GLOBAL_ATTRIBUTE9                             ;
    :new.GLOBAL_ATTRIBUTE10                       := t_new_rec.GLOBAL_ATTRIBUTE10                            ;
    :new.GLOBAL_ATTRIBUTE11                       := t_new_rec.GLOBAL_ATTRIBUTE11                            ;
    :new.GLOBAL_ATTRIBUTE12                       := t_new_rec.GLOBAL_ATTRIBUTE12                            ;
    :new.GLOBAL_ATTRIBUTE13                       := t_new_rec.GLOBAL_ATTRIBUTE13                            ;
    :new.GLOBAL_ATTRIBUTE14                       := t_new_rec.GLOBAL_ATTRIBUTE14                            ;
    :new.GLOBAL_ATTRIBUTE15                       := t_new_rec.GLOBAL_ATTRIBUTE15                            ;
    :new.GLOBAL_ATTRIBUTE16                       := t_new_rec.GLOBAL_ATTRIBUTE16                            ;
    :new.GLOBAL_ATTRIBUTE17                       := t_new_rec.GLOBAL_ATTRIBUTE17                            ;
    :new.GLOBAL_ATTRIBUTE18                       := t_new_rec.GLOBAL_ATTRIBUTE18                            ;
    :new.GLOBAL_ATTRIBUTE19                       := t_new_rec.GLOBAL_ATTRIBUTE19                            ;
    :new.GLOBAL_ATTRIBUTE20                       := t_new_rec.GLOBAL_ATTRIBUTE20                            ;
    :new.EXTERNAL_BANK_ACCOUNT_ID                 := t_new_rec.EXTERNAL_BANK_ACCOUNT_ID                      ;
    :new.INV_CURR_GROSS_AMOUNT                    := t_new_rec.INV_CURR_GROSS_AMOUNT                         ;
    :new.CHECKRUN_ID                              := t_new_rec.CHECKRUN_ID                                   ;
    :new.DBI_EVENTS_COMPLETE_FLAG                 := t_new_rec.DBI_EVENTS_COMPLETE_FLAG                      ;
    :new.IBY_HOLD_REASON                          := t_new_rec.IBY_HOLD_REASON                               ;
    :new.PAYMENT_METHOD_CODE                      := t_new_rec.PAYMENT_METHOD_CODE                           ;
    :new.REMITTANCE_MESSAGE1                      := t_new_rec.REMITTANCE_MESSAGE1                           ;
    :new.REMITTANCE_MESSAGE2                      := t_new_rec.REMITTANCE_MESSAGE2                           ;
    :new.REMITTANCE_MESSAGE3                      := t_new_rec.REMITTANCE_MESSAGE3                           ;

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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AP_PSA_BRIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

      JAI_AP_PSA_TRIGGER_PKG.BRIUD_T1 (
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

      JAI_AP_PSA_TRIGGER_PKG.BRIUD_T1 (
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

  IF DELETING THEN

      JAI_AP_PSA_TRIGGER_PKG.BRIUD_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AP_PSA_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AP_PSA_BRIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_AP_PSA_BRIUD_T1" DISABLE;
