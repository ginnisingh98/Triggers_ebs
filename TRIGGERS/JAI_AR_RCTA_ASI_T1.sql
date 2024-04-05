--------------------------------------------------------
--  DDL for Trigger JAI_AR_RCTA_ASI_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AR_RCTA_ASI_T1" 
AFTER INSERT ON "AR"."RA_CUSTOMER_TRX_ALL"
DECLARE

  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

BEGIN

  JAI_AR_RCTA_TRIGGER_PKG.ASI_T1 (
                        pr_old            =>  NULL              ,
                        pr_new            =>  NULL              ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );

  IF lv_return_code <> jai_constants.successful   then
          RAISE le_error;
  END IF;

EXCEPTION

  WHEN le_error THEN
     -- BUG 6156051
     fnd_message.set_name ('JA','JAI_GENERIC_MSG');
     fnd_message.set_token ('MSG_TEXT', lv_return_message);
     -- End 6156051
     app_exception.raise_exception (
                                     EXCEPTION_TYPE  => 'APP'  ,
                                     EXCEPTION_CODE  => -20110 ,
                                     EXCEPTION_TEXT  => lv_return_message
                                   );

  WHEN OTHERS THEN

     -- BUG 6156051
     fnd_message.set_name ('JA','JAI_GENERIC_MSG');
     fnd_message.set_token ('MSG_TEXT', 'Encountered the error in trigger JAI_AR_RCTA_ASI_T1' || substr(sqlerrm,1,1900));
     -- End 6156051
      app_exception.raise_exception (
                                      EXCEPTION_TYPE  => 'APP',
                                      EXCEPTION_CODE  => -20110 ,
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AR_RCTA_ASI_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AR_RCTA_ASI_T1 ;

/
ALTER TRIGGER "APPS"."JAI_AR_RCTA_ASI_T1" DISABLE;
