--------------------------------------------------------
--  DDL for Trigger JAI_AP_DVA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AP_DVA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AP"."AP_DUPLICATE_VENDORS_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             AP_DUPLICATE_VENDORS_ALL%rowtype ;
  t_new_rec             AP_DUPLICATE_VENDORS_ALL%rowtype ;
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

    t_new_rec.ENTRY_ID                                 := :new.ENTRY_ID                                      ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.DUPLICATE_VENDOR_ID                      := :new.DUPLICATE_VENDOR_ID                           ;
    t_new_rec.VENDOR_SITE_ID                           := :new.VENDOR_SITE_ID                                ;
    t_new_rec.DUPLICATE_VENDOR_SITE_ID                 := :new.DUPLICATE_VENDOR_SITE_ID                      ;
    t_new_rec.NUMBER_UNPAID_INVOICES                   := :new.NUMBER_UNPAID_INVOICES                        ;
    t_new_rec.NUMBER_PAID_INVOICES                     := :new.NUMBER_PAID_INVOICES                          ;
    t_new_rec.NUMBER_PO_HEADERS_CHANGED                := :new.NUMBER_PO_HEADERS_CHANGED                     ;
    t_new_rec.AMOUNT_UNPAID_INVOICES                   := :new.AMOUNT_UNPAID_INVOICES                        ;
    t_new_rec.AMOUNT_PAID_INVOICES                     := :new.AMOUNT_PAID_INVOICES                          ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.PROCESS_FLAG                             := :new.PROCESS_FLAG                                  ;
    t_new_rec.PROCESS                                  := :new.PROCESS                                       ;
    t_new_rec.KEEP_SITE_FLAG                           := :new.KEEP_SITE_FLAG                                ;
    t_new_rec.PAID_INVOICES_FLAG                       := :new.PAID_INVOICES_FLAG                            ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.ENTRY_ID                                 := :old.ENTRY_ID                                      ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.DUPLICATE_VENDOR_ID                      := :old.DUPLICATE_VENDOR_ID                           ;
    t_old_rec.VENDOR_SITE_ID                           := :old.VENDOR_SITE_ID                                ;
    t_old_rec.DUPLICATE_VENDOR_SITE_ID                 := :old.DUPLICATE_VENDOR_SITE_ID                      ;
    t_old_rec.NUMBER_UNPAID_INVOICES                   := :old.NUMBER_UNPAID_INVOICES                        ;
    t_old_rec.NUMBER_PAID_INVOICES                     := :old.NUMBER_PAID_INVOICES                          ;
    t_old_rec.NUMBER_PO_HEADERS_CHANGED                := :old.NUMBER_PO_HEADERS_CHANGED                     ;
    t_old_rec.AMOUNT_UNPAID_INVOICES                   := :old.AMOUNT_UNPAID_INVOICES                        ;
    t_old_rec.AMOUNT_PAID_INVOICES                     := :old.AMOUNT_PAID_INVOICES                          ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.PROCESS_FLAG                             := :old.PROCESS_FLAG                                  ;
    t_old_rec.PROCESS                                  := :old.PROCESS                                       ;
    t_old_rec.KEEP_SITE_FLAG                           := :old.KEEP_SITE_FLAG                                ;
    t_old_rec.PAID_INVOICES_FLAG                       := :old.PAID_INVOICES_FLAG                            ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AP_DVA_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

      JAI_AP_DVA_TRIGGER_PKG.ARI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AP_DVA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AP_DVA_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_AP_DVA_ARIUD_T1" DISABLE;
