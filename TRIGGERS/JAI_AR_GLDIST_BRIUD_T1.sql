--------------------------------------------------------
--  DDL for Trigger JAI_AR_GLDIST_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AR_GLDIST_BRIUD_T1" 
BEFORE INSERT OR UPDATE OR DELETE ON "AR"."RA_CUST_TRX_LINE_GL_DIST_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             RA_CUST_TRX_LINE_GL_DIST_ALL%rowtype ;
  t_new_rec             RA_CUST_TRX_LINE_GL_DIST_ALL%rowtype ;
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

    t_new_rec.CUST_TRX_LINE_GL_DIST_ID              :=      :new.CUST_TRX_LINE_GL_DIST_ID ;
    t_new_rec.CUSTOMER_TRX_LINE_ID                  :=      :new.CUSTOMER_TRX_LINE_ID     ;
    t_new_rec.AMOUNT                                :=      :new.AMOUNT                   ;
    t_new_rec.POSTING_CONTROL_ID                    :=      :new.POSTING_CONTROL_ID       ;
    t_new_rec.ACCOUNT_CLASS                         :=      :new.ACCOUNT_CLASS            ;
    t_new_rec.ACCTD_AMOUNT                          :=      :new.ACCTD_AMOUNT             ;
    t_new_rec.GL_DATE                               :=      :new.GL_DATE                  ;
    t_new_rec.GL_POSTED_DATE                        :=      :new.GL_POSTED_DATE           ;
    t_new_rec.LATEST_REC_FLAG                       :=      :new.LATEST_REC_FLAG          ;
    t_new_rec.ORG_ID                                :=      :new.ORG_ID                   ;
    t_new_rec.CUSTOMER_TRX_ID                       :=      :new.CUSTOMER_TRX_ID          ;
    t_new_rec.ACCOUNT_SET_FLAG                      :=      :new.ACCOUNT_SET_FLAG         ;
    t_new_rec.CODE_COMBINATION_ID                   :=      :new.CODE_COMBINATION_ID      ;
    t_new_rec.SET_OF_BOOKS_ID                       :=      :new.SET_OF_BOOKS_ID          ;
    t_new_rec.LAST_UPDATE_DATE                      :=      :new.LAST_UPDATE_DATE         ;
    t_new_rec.LAST_UPDATED_BY                       :=      :new.LAST_UPDATED_BY          ;
    t_new_rec.CREATION_DATE                         :=      :new.CREATION_DATE            ;
    t_new_rec.CREATED_BY                            :=      :new.CREATED_BY               ;
    t_new_rec.LAST_UPDATE_LOGIN                     :=      :new.LAST_UPDATE_LOGIN        ;
    t_new_rec.ORIGINAL_GL_DATE                      :=      :new.ORIGINAL_GL_DATE         ;

  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN

    t_old_rec.CUST_TRX_LINE_GL_DIST_ID              :=      :old.CUST_TRX_LINE_GL_DIST_ID ;
    t_old_rec.CUSTOMER_TRX_LINE_ID                  :=      :old.CUSTOMER_TRX_LINE_ID     ;
    t_old_rec.AMOUNT                                :=      :old.AMOUNT                   ;
    t_old_rec.POSTING_CONTROL_ID                    :=      :old.POSTING_CONTROL_ID       ;
    t_old_rec.ACCOUNT_CLASS                         :=      :old.ACCOUNT_CLASS            ;
    t_old_rec.ACCTD_AMOUNT                          :=      :old.ACCTD_AMOUNT             ;
    t_old_rec.GL_DATE                               :=      :old.GL_DATE                  ;
    t_old_rec.GL_POSTED_DATE                        :=      :old.GL_POSTED_DATE           ;
    t_old_rec.LATEST_REC_FLAG                       :=      :old.LATEST_REC_FLAG          ;
    t_old_rec.ORG_ID                                :=      :old.ORG_ID                   ;
    t_old_rec.CUSTOMER_TRX_ID                       :=      :old.CUSTOMER_TRX_ID          ;
    t_old_rec.ACCOUNT_SET_FLAG                      :=      :old.ACCOUNT_SET_FLAG         ;
    t_old_rec.CODE_COMBINATION_ID                   :=      :old.CODE_COMBINATION_ID      ;
    t_old_rec.SET_OF_BOOKS_ID                       :=      :old.SET_OF_BOOKS_ID          ;
    t_old_rec.LAST_UPDATE_DATE                      :=      :old.LAST_UPDATE_DATE         ;
    t_old_rec.LAST_UPDATED_BY                       :=      :old.LAST_UPDATED_BY          ;
    t_old_rec.CREATION_DATE                         :=      :old.CREATION_DATE            ;
    t_old_rec.CREATED_BY                            :=      :old.CREATED_BY               ;
    t_old_rec.LAST_UPDATE_LOGIN                     :=      :old.LAST_UPDATE_LOGIN        ;
    t_old_rec.ORIGINAL_GL_DATE                      :=      :old.ORIGINAL_GL_DATE         ;

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
  IF jai_cmn_utils_pkg.check_jai_exists( P_CALLING_OBJECT => 'JAI_AR_GLDIST_BRIUD_T1'
                                       , P_SET_OF_BOOKS_ID => :new.SET_OF_BOOKS_ID
                                       )
  = FALSE
  THEN
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

    IF   :new.account_class = 'REC'
    and  :new.latest_rec_flag = 'Y'
    and  :new.posting_control_id <> :old.posting_control_id
    and  :new.posting_control_id <> -3
    THEN

      JAI_AR_GLDIST_TRIGGER_PKG.BRI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AR_GLDIST_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AR_GLDIST_BRIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_AR_GLDIST_BRIUD_T1" DISABLE;
