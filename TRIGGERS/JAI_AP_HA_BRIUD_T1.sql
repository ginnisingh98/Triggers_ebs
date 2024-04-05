--------------------------------------------------------
--  DDL for Trigger JAI_AP_HA_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AP_HA_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "AP"."AP_HOLDS_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             AP_HOLDS_ALL%rowtype ;
  t_new_rec             AP_HOLDS_ALL%rowtype ;
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
    t_new_rec.LINE_LOCATION_ID                         := :new.LINE_LOCATION_ID                              ;
    t_new_rec.HOLD_LOOKUP_CODE                         := :new.HOLD_LOOKUP_CODE                              ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.HELD_BY                                  := :new.HELD_BY                                       ;
    t_new_rec.HOLD_DATE                                := :new.HOLD_DATE                                     ;
    t_new_rec.HOLD_REASON                              := :new.HOLD_REASON                                   ;
    t_new_rec.RELEASE_LOOKUP_CODE                      := :new.RELEASE_LOOKUP_CODE                           ;
    t_new_rec.RELEASE_REASON                           := :new.RELEASE_REASON                                ;
    t_new_rec.STATUS_FLAG                              := :new.STATUS_FLAG                                   ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
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
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.RESPONSIBILITY_ID                        := :new.RESPONSIBILITY_ID                             ;
    t_new_rec.RCV_TRANSACTION_ID                       := :new.RCV_TRANSACTION_ID                            ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.INVOICE_ID                               := :old.INVOICE_ID                                    ;
    t_old_rec.LINE_LOCATION_ID                         := :old.LINE_LOCATION_ID                              ;
    t_old_rec.HOLD_LOOKUP_CODE                         := :old.HOLD_LOOKUP_CODE                              ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.HELD_BY                                  := :old.HELD_BY                                       ;
    t_old_rec.HOLD_DATE                                := :old.HOLD_DATE                                     ;
    t_old_rec.HOLD_REASON                              := :old.HOLD_REASON                                   ;
    t_old_rec.RELEASE_LOOKUP_CODE                      := :old.RELEASE_LOOKUP_CODE                           ;
    t_old_rec.RELEASE_REASON                           := :old.RELEASE_REASON                                ;
    t_old_rec.STATUS_FLAG                              := :old.STATUS_FLAG                                   ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
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
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.RESPONSIBILITY_ID                        := :old.RESPONSIBILITY_ID                             ;
    t_old_rec.RCV_TRANSACTION_ID                       := :old.RCV_TRANSACTION_ID                            ;
  END populate_old ;

    /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.INVOICE_ID                               := t_new_rec.INVOICE_ID                                    ;
    :new.LINE_LOCATION_ID                         := t_new_rec.LINE_LOCATION_ID                              ;
    :new.HOLD_LOOKUP_CODE                         := t_new_rec.HOLD_LOOKUP_CODE                              ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.HELD_BY                                  := t_new_rec.HELD_BY                                       ;
    :new.HOLD_DATE                                := t_new_rec.HOLD_DATE                                     ;
    :new.HOLD_REASON                              := t_new_rec.HOLD_REASON                                   ;
    :new.RELEASE_LOOKUP_CODE                      := t_new_rec.RELEASE_LOOKUP_CODE                           ;
    :new.RELEASE_REASON                           := t_new_rec.RELEASE_REASON                                ;
    :new.STATUS_FLAG                              := t_new_rec.STATUS_FLAG                                   ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
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
    :new.ORG_ID                                   := t_new_rec.ORG_ID                                        ;
    :new.RESPONSIBILITY_ID                        := t_new_rec.RESPONSIBILITY_ID                             ;
    :new.RCV_TRANSACTION_ID                       := t_new_rec.RCV_TRANSACTION_ID                            ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AP_HA_BRIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

    IF ( :NEW.hold_lookup_code = 'PO REQUIRED' ) THEN

     JAI_AP_HA_TRIGGER_PKG.BRI_T1 (
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

    JAI_AP_HA_TRIGGER_PKG.BRIUD_T1 (
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

      JAI_AP_HA_TRIGGER_PKG.BRIUD_T1 (
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

      JAI_AP_HA_TRIGGER_PKG.BRIUD_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AP_HA_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AP_HA_BRIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_AP_HA_BRIUD_T1" DISABLE;
