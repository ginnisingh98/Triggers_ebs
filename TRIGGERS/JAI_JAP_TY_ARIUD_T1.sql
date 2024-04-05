--------------------------------------------------------
--  DDL for Trigger JAI_JAP_TY_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JAP_TY_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "JA"."JAI_AP_TDS_YEARS"
FOR EACH ROW
DECLARE
  t_old_rec             JAI_AP_TDS_YEARS%rowtype ;
  t_new_rec             JAI_AP_TDS_YEARS%rowtype ;
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

    t_new_rec.LEGAL_ENTITY_ID                          := :new.LEGAL_ENTITY_ID                               ;
    t_new_rec.FIN_YEAR                                 := :new.FIN_YEAR                                      ;
    t_new_rec.START_DATE                               := :new.START_DATE                                    ;
    t_new_rec.END_DATE                                 := :new.END_DATE                                      ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
    t_new_rec.TAN_NO                                   := :new.TAN_NO                                        ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.LEGAL_ENTITY_ID                          := :old.LEGAL_ENTITY_ID                               ;
    t_old_rec.FIN_YEAR                                 := :old.FIN_YEAR                                      ;
    t_old_rec.START_DATE                               := :old.START_DATE                                    ;
    t_old_rec.END_DATE                                 := :old.END_DATE                                      ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
    t_old_rec.TAN_NO                                   := :old.TAN_NO                                        ;
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
  || No need for INR check here.
  */

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

      JAI_JAP_TY_TRIGGER_PKG.ARI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_JAP_TY_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_JAP_TY_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_JAP_TY_ARIUD_T1" DISABLE;
