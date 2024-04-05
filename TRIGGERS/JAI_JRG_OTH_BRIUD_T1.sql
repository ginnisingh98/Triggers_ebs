--------------------------------------------------------
--  DDL for Trigger JAI_JRG_OTH_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JRG_OTH_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "JA"."JAI_CMN_RG_OTHERS"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_CMN_RG_OTHERS%rowtype ;
  t_new_rec             JAI_CMN_RG_OTHERS%rowtype ;
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

    t_new_rec.RG_OTHER_ID                              := :new.RG_OTHER_ID                                   ;
    t_new_rec.SOURCE_TYPE                              := :new.SOURCE_TYPE                                   ;
    t_new_rec.SOURCE_REGISTER                          := :new.SOURCE_REGISTER                               ;
    t_new_rec.SOURCE_REGISTER_ID                       := :new.SOURCE_REGISTER_ID                            ;
    t_new_rec.TAX_TYPE                                 := :new.TAX_TYPE                                      ;
    t_new_rec.CREDIT                                   := :new.CREDIT                                        ;
    t_new_rec.DEBIT                                    := :new.DEBIT                                         ;
    t_new_rec.OPENING_BALANCE                          := :new.OPENING_BALANCE                               ;
    t_new_rec.CLOSING_BALANCE                          := :new.CLOSING_BALANCE                               ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.RG_OTHER_ID                              := :old.RG_OTHER_ID                                   ;
    t_old_rec.SOURCE_TYPE                              := :old.SOURCE_TYPE                                   ;
    t_old_rec.SOURCE_REGISTER                          := :old.SOURCE_REGISTER                               ;
    t_old_rec.SOURCE_REGISTER_ID                       := :old.SOURCE_REGISTER_ID                            ;
    t_old_rec.TAX_TYPE                                 := :old.TAX_TYPE                                      ;
    t_old_rec.CREDIT                                   := :old.CREDIT                                        ;
    t_old_rec.DEBIT                                    := :old.DEBIT                                         ;
    t_old_rec.OPENING_BALANCE                          := :old.OPENING_BALANCE                               ;
    t_old_rec.CLOSING_BALANCE                          := :old.CLOSING_BALANCE                               ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
  END populate_old ;

  /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.RG_OTHER_ID                              := t_new_rec.RG_OTHER_ID                                   ;
    :new.SOURCE_TYPE                              := t_new_rec.SOURCE_TYPE                                   ;
    :new.SOURCE_REGISTER                          := t_new_rec.SOURCE_REGISTER                               ;
    :new.SOURCE_REGISTER_ID                       := t_new_rec.SOURCE_REGISTER_ID                            ;
    :new.TAX_TYPE                                 := t_new_rec.TAX_TYPE                                      ;
    :new.CREDIT                                   := t_new_rec.CREDIT                                        ;
    :new.DEBIT                                    := t_new_rec.DEBIT                                         ;
    :new.OPENING_BALANCE                          := t_new_rec.OPENING_BALANCE                               ;
    :new.CLOSING_BALANCE                          := t_new_rec.CLOSING_BALANCE                               ;
    :new.CREATED_BY                               := t_new_rec.CREATED_BY                                    ;
    :new.CREATION_DATE                            := t_new_rec.CREATION_DATE                                 ;
    :new.LAST_UPDATED_BY                          := t_new_rec.LAST_UPDATED_BY                               ;
    :new.LAST_UPDATE_DATE                         := t_new_rec.LAST_UPDATE_DATE                              ;
    :new.LAST_UPDATE_LOGIN                        := t_new_rec.LAST_UPDATE_LOGIN                             ;
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

      JAI_JRG_OTH_TRIGGER_PKG.BRI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JRG_OTH_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JRG_OTH_BRIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_JRG_OTH_BRIUD_T1" DISABLE;
