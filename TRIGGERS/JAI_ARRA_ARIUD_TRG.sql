--------------------------------------------------------
--  DDL for Trigger JAI_ARRA_ARIUD_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_ARRA_ARIUD_TRG" 
AFTER INSERT ON "AR"."AR_RECEIVABLE_APPLICATIONS_ALL"
FOR EACH ROW
DECLARE

  /* variables used in debug package */
  lv_object_name      jai_cmn_debug_contexts.LOG_CONTEXT%TYPE DEFAULT 'TRIGGER.ARAA.AFTER.JAI_ARRA_ARIUD_TRG';
  lv_member_name      jai_cmn_debug_contexts.LOG_CONTEXT%TYPE;
  lv_context          jai_cmn_debug_contexts.LOG_CONTEXT%TYPE;
  ln_reg_id           NUMBER;
  /* Trigger variables */
  t_new_rec                 AR_RECEIVABLE_APPLICATIONS_ALL%ROWTYPE  ;
  t_old_rec                 AR_RECEIVABLE_APPLICATIONS_ALL%ROWTYPE  ;
  lv_action             VARCHAR2(20)                            ;
  lv_object             VARCHAR2(61)                            ;
  lv_process_message    VARCHAR2(4000)                          ;
  lv_process_flag       VARCHAR2(2)                             ;
  le_error              EXCEPTION                               ;

  PROCEDURE init_new
  IS
  BEGIN
  /* $Header: jai_arra_ariud_t.sql 120.0.12000000.1 2007/07/24 06:55:40 rallamse noship $ */

  /***************************************************************************************************
  -- #
	-- # Change History -


	1.  01/02/2007   CSahoo for bug#5631784. File Version 120.0
									 Forward Porting of 11i BUG#4742259 (TAX COLLECTION AT SOURCE IN RECEIVABLES)

	*******************************************************************************************************/

    t_new_rec.receivable_application_id         :=             :new.receivable_application_id      ;
    t_new_rec.cash_receipt_id                   :=             :new.cash_receipt_id                ;
    t_new_rec.amount_applied                    :=             :new.amount_applied                 ;
    t_new_rec.application_type                  :=             :new.application_type               ;
    t_new_rec.status                            :=             :new.status                         ;
    t_new_rec.display                           :=             :new.display                        ;

    t_new_rec.customer_trx_id                   :=             :new.customer_trx_id                ;
    t_new_rec.applied_customer_trx_id           :=             :new.applied_customer_trx_id        ;

    t_new_rec.payment_schedule_id               :=             :new.payment_schedule_id            ;
    t_new_rec.applied_payment_schedule_id       :=             :new.applied_payment_schedule_id    ;

    t_new_rec.gl_date                           :=             :new.gl_date                        ;
    t_new_rec.org_id                            :=             :new.org_id                         ;
    t_new_rec.set_of_books_id                   :=             :new.set_of_books_id                ;
    t_new_rec.apply_date                        :=             :new.apply_date                     ;
    t_new_rec.applied_customer_trx_line_id      :=             :new.applied_customer_trx_line_id   ;
    t_new_rec.line_applied                      :=             :new.line_applied                   ;
    t_new_rec.tax_applied                       :=             :new.tax_applied                    ;
    t_new_rec.freight_applied                   :=             :new.freight_applied                ;
    t_new_rec.receivables_trx_id                :=             :new.receivables_trx_id             ;
    t_new_rec.gl_posted_date                    :=             :new.gl_posted_date                 ;
    t_new_rec.postable                          :=             :new.postable                       ;
    t_new_rec.posting_control_id                :=             :new.posting_control_id             ;
    t_new_rec.acctd_amount_applied_from         :=             :new.acctd_amount_applied_from      ;
    t_new_rec.acctd_amount_applied_to           :=             :new.acctd_amount_applied_to        ;

    t_new_rec.code_combination_id               :=             :new.code_combination_id            ;
    t_new_rec.last_updated_by                   :=             :new.last_updated_by                ;
    t_new_rec.last_update_date                  :=             :new.last_update_date               ;
    t_new_rec.created_by                        :=             :new.created_by                     ;
    t_new_rec.creation_date                     :=             :new.creation_date                  ;
    t_new_rec.last_update_login                 :=             :new.last_update_login              ;

END init_new;

  PROCEDURE init_old
  IS
  BEGIN
    t_old_rec.receivable_application_id         :=             :old.receivable_application_id      ;
    t_old_rec.cash_receipt_id                   :=             :old.cash_receipt_id                ;
    t_old_rec.amount_applied                    :=             :old.amount_applied                 ;
    t_old_rec.application_type                  :=             :old.application_type               ;
    t_old_rec.status                            :=             :old.status                         ;
    t_old_rec.display                           :=             :old.display                        ;

    t_old_rec.customer_trx_id                   :=             :old.customer_trx_id                ;
    t_old_rec.applied_customer_trx_id           :=             :old.applied_customer_trx_id        ;

    t_old_rec.payment_schedule_id               :=             :old.payment_schedule_id            ;
    t_old_rec.applied_payment_schedule_id       :=             :old.applied_payment_schedule_id    ;

    t_old_rec.gl_date                           :=             :old.gl_date                        ;
    t_old_rec.org_id                            :=             :old.org_id                         ;
    t_old_rec.set_of_books_id                   :=             :old.set_of_books_id                ;
    t_old_rec.apply_date                        :=             :old.apply_date                     ;
    t_old_rec.applied_customer_trx_line_id      :=             :old.applied_customer_trx_line_id   ;
    t_old_rec.line_applied                      :=             :old.line_applied                   ;
    t_old_rec.tax_applied                       :=             :old.tax_applied                    ;
    t_old_rec.freight_applied                   :=             :old.freight_applied                ;
    t_old_rec.receivables_trx_id                :=             :old.receivables_trx_id             ;
    t_old_rec.gl_posted_date                    :=             :old.gl_posted_date                 ;
    t_old_rec.postable                          :=             :old.postable                       ;
    t_old_rec.posting_control_id                :=             :old.posting_control_id             ;
    t_old_rec.acctd_amount_applied_from         :=             :old.acctd_amount_applied_from      ;
    t_old_rec.acctd_amount_applied_to           :=             :old.acctd_amount_applied_to        ;

    t_old_rec.code_combination_id               :=             :old.code_combination_id            ;
    t_old_rec.last_updated_by                   :=             :old.last_updated_by                ;
    t_old_rec.last_update_date                  :=             :old.last_update_date               ;
    t_old_rec.created_by                        :=             :old.created_by                     ;
    t_old_rec.creation_date                     :=             :old.creation_date                  ;
    t_old_rec.last_update_login                 :=             :old.last_update_login              ;

  END init_old;

 PROCEDURE set_debug_context
 IS
 BEGIN
   lv_context  := rtrim(lv_object_name || '.'||lv_member_name,'.');
 END set_debug_context;

BEGIN


  lv_object :=  'jai_cmn_utils_pkg.check_jai_exists';
  lv_action :=  'CHECK_JAI_EXISTS';

  IF  jai_cmn_utils_pkg.check_jai_exists (p_calling_object   => 'JAI_ARRA_TRG_PKG',
                                   p_org_id           =>  :new.org_id,
                                   p_set_of_books_id  =>  :new.set_of_books_id )
      = false
  THEN
  /* India Localization functionality is not required */
    return;
  END IF;

  set_debug_context;
  /*jai_cmn_debug_contexts_pkg.register ( pv_context => lv_context ,
                                        pn_reg_id  => ln_reg_id
                                      );

  jai_cmn_debug_contexts_pkg.print (  pn_reg_id   =>  ln_reg_id ,
                                      pv_log_msg  =>  ' Trigger jai_arra_ariud fired .' ||CHR(10)
                                                    ||', receivable_application_id -> '  ||:new.receivable_application_id   ||CHR(10)
                                                    ||', application_type          -> '  ||:new.application_type            ||CHR(10)
                                                    ||', status                    -> '  ||:new.status                      ||CHR(10)
                                                    ||', display                   -> '  ||:new.display                     ||CHR(10)
                                                    ||', amount_applied            -> '  ||:new.amount_applied
                                   );*/



  lv_object := 'jai_arra_ariud_trg' ;
  lv_action := 'INIT_NEW';

  if updating or inserting then
    init_new;
  end if;

  lv_action := 'INIT_OLD';
  if updating or deleting then
    init_old;
  end if;

  /******************************************** INSERTING SECTION ***********************************************/

  IF INSERTING THEN


    IF t_new_rec.application_type      NOT IN ('CASH','CM')       OR
       nvl(t_new_rec.amount_applied,0) = 0                        OR
       t_new_rec.status                NOT IN ('APP','ACTIVITY')
    THEN
      /*
      ||Process only CASH and Credit Memo Applications having non zero applications
      */
      /*jai_cmn_debug_contexts_pkg.print (  pn_reg_id   =>  ln_reg_id ,
                                          pv_log_msg  =>  ' Skip TCS processing as application_type or status or amount applied are not applicable for TCS processing,'
                                       );*/
      return;
    END IF;

    lv_action := 'INSERTING';
    lv_object := 'jai_arra_trg_pkg.process_app' ;

    /*jai_cmn_debug_contexts_pkg.print (  pn_reg_id   =>  ln_reg_id ,
                               pv_log_msg  =>  ' Before call to jai_arra_trg_pkg.process_app   '
                              );*/
    jai_arra_trg_pkg.process_app   (  r_new               =>  t_new_rec         ,
                                      r_old               =>  t_old_rec         ,
                                      p_process_flag      =>  lv_process_flag   ,
                                      p_process_message   =>  lv_process_message
                                   ) ;

    /*jai_cmn_debug_contexts_pkg.print (  pn_reg_id   =>  ln_reg_id ,
                               pv_log_msg  =>  ' return from jai_arra_trg_pkg.process_app   lv_process_flag -> '||lv_process_flag
                              );*/
    IF lv_process_flag = jai_constants.expected_error    OR                      ---------A2
       lv_process_flag = jai_constants.unexpected_error
    THEN
      /*
      || As Returned status is an error hence:-
      || Set out variables p_process_flag and p_process_message accordingly
      */
      --call to debug package
    /*  jai_cmn_debug_contexts_pkg.print (  pn_reg_id   =>  ln_reg_id ,
                                 pv_log_msg  =>  ' Error : - lv_process_flag -> '||lv_process_flag||' - '||lv_process_message
                              );*/

      raise le_error;
    END IF;                                                                      ---------A2


  END IF; /* if inserting */

  /******************************************** UPDATING SECTION ***********************************************/

  IF UPDATING THEN

    lv_action := 'UPDATING';

  END IF;  /* if updating */


  /******************************************** DELETING SECTION ***********************************************/
  IF DELETING THEN
    lv_action := 'DELETING';
    --                                --
    -- Delete triggers code goes here --
    --                                --

  END IF;

 /* jai_cmn_debug_contexts_pkg.print (  pn_reg_id   =>  ln_reg_id ,
                             pv_log_msg  =>  '**************** TRIGGER JAI_ARRA_ARIUD_TRG COMPLETED SUCCESSFULLY ****************'
                          );

  jai_cmn_debug_contexts_pkg.deregister (pn_reg_id => ln_reg_id);*/
EXCEPTION
  WHEN le_error THEN

    IF lv_process_flag   = jai_constants.unexpected_error THEN
      lv_process_message := substr (lv_process_message || ' Object=' || lv_object || ' Action=' || lv_action, 1,1999) ;
    END IF;


    fnd_message.set_name (application => 'JA',
                          name        => 'JAI_ERR_DESC'
                           );

    fnd_message.set_token ( token => 'JAI_ERROR_DESCRIPTION',
                            value => lv_process_message
                           );


    app_exception.raise_exception;

  WHEN others THEN
    fnd_message.set_name (  application => 'JA',
                            name        => 'JAI_ERR_DESC'
                         );

    fnd_message.set_token ( token => 'JAI_ERROR_DESCRIPTION',
                            value => 'Exception Occured in ' || ' Object=' || lv_object
                                                             || ' for Action=' || lv_action
                          );

    app_exception.raise_exception;


END jai_arra_ariud_trg;


/
ALTER TRIGGER "APPS"."JAI_ARRA_ARIUD_TRG" ENABLE;
