--------------------------------------------------------
--  DDL for Trigger JAI_PA_PDIA_AFTER_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PA_PDIA_AFTER_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PA"."PA_DRAFT_INVOICES_ALL"
FOR EACH ROW
DECLARE
/* $Header: jai_pa_pdia_t.sql 120.1.12010000.2 2009/08/07 10:22:47 mbremkum ship $ */

/*----------------------------------------------------------------------------------------
Change History
S.No.   DATE         Description
------------------------------------------------------------------------------------------

1      24/04/1005    cbabu for bug#6012570 (5876390) Version: 120.0
                      Projects Billing Enh.
                      forward ported from R11i to R12

2      07/Aug/2009   Bug 8741673 - Trigger was not disabled post creation.
                     This leads to issues for Non IL Customers when the draft Invoice is
                     released

---------------------------------------------------------------------------------------- */

  lv_process_flag     VARCHAR2(30);
  lv_process_message  VARCHAR2(2000);
  lv_object           VARCHAR2(100);
  lv_action           VARCHAR2(30);

  r_new               pa_draft_invoices_all%rowtype;
  r_old               pa_draft_invoices_all%rowtype;

  ln_conc_request_id  number := to_number(fnd_profile.value ('CONC_REQUEST_ID'));

  ln_reg_id           number;

  /*-----------------------------------------DEBUG WRAPPER PROCEDURE -----------------------------*/

  procedure debug (pn_reg_id  number, pv_msg varchar2)
  is
    -- Internal debug switch setting this variable to FALSE will forcefully disable the debugging
    debugOn boolean := true;
  begin

    if not debugOn then
      return;
    end if;

    jai_cmn_debug_contexts_pkg.print (pn_reg_id, pv_msg);

  end debug;

  /*------------------------------------------------------------------------------------------------------------*/

  procedure initialize_new as
  begin
    r_new.PROJECT_ID                      := :new.PROJECT_ID                     ;
    r_new.DRAFT_INVOICE_NUM               := :new.DRAFT_INVOICE_NUM              ;
    r_new.LAST_UPDATE_DATE                := :new.LAST_UPDATE_DATE               ;
    r_new.LAST_UPDATED_BY                 := :new.LAST_UPDATED_BY                ;
    r_new.CREATION_DATE                   := :new.CREATION_DATE                  ;
    r_new.CREATED_BY                      := :new.CREATED_BY                     ;
    r_new.TRANSFER_STATUS_CODE            := :new.TRANSFER_STATUS_CODE           ;
    r_new.GENERATION_ERROR_FLAG           := :new.GENERATION_ERROR_FLAG          ;
    r_new.AGREEMENT_ID                    := :new.AGREEMENT_ID                   ;
    r_new.PA_DATE                         := :new.PA_DATE                        ;
    r_new.REQUEST_ID                      := :new.REQUEST_ID                     ;
    r_new.PROGRAM_APPLICATION_ID          := :new.PROGRAM_APPLICATION_ID         ;
    r_new.PROGRAM_ID                      := :new.PROGRAM_ID                     ;
    r_new.PROGRAM_UPDATE_DATE             := :new.PROGRAM_UPDATE_DATE            ;
    r_new.CUSTOMER_BILL_SPLIT             := :new.CUSTOMER_BILL_SPLIT            ;
    r_new.BILL_THROUGH_DATE               := :new.BILL_THROUGH_DATE              ;
    r_new.INVOICE_COMMENT                 := :new.INVOICE_COMMENT                ;
    r_new.APPROVED_DATE                   := :new.APPROVED_DATE                  ;
    r_new.APPROVED_BY_PERSON_ID           := :new.APPROVED_BY_PERSON_ID          ;
    r_new.RELEASED_DATE                   := :new.RELEASED_DATE                  ;
    r_new.RELEASED_BY_PERSON_ID           := :new.RELEASED_BY_PERSON_ID          ;
    r_new.INVOICE_DATE                    := :new.INVOICE_DATE                   ;
    r_new.RA_INVOICE_NUMBER               := :new.RA_INVOICE_NUMBER              ;
    r_new.TRANSFERRED_DATE                := :new.TRANSFERRED_DATE               ;
    r_new.TRANSFER_REJECTION_REASON       := :new.TRANSFER_REJECTION_REASON      ;
    r_new.UNEARNED_REVENUE_CR             := :new.UNEARNED_REVENUE_CR            ;
    r_new.UNBILLED_RECEIVABLE_DR          := :new.UNBILLED_RECEIVABLE_DR         ;
    r_new.GL_DATE                         := :new.GL_DATE                        ;
    r_new.SYSTEM_REFERENCE                := :new.SYSTEM_REFERENCE               ;
    r_new.DRAFT_INVOICE_NUM_CREDITED      := :new.DRAFT_INVOICE_NUM_CREDITED     ;
    r_new.CANCELED_FLAG                   := :new.CANCELED_FLAG                  ;
    r_new.CANCEL_CREDIT_MEMO_FLAG         := :new.CANCEL_CREDIT_MEMO_FLAG        ;
    r_new.WRITE_OFF_FLAG                  := :new.WRITE_OFF_FLAG                 ;
    r_new.CONVERTED_FLAG                  := :new.CONVERTED_FLAG                 ;
    r_new.EXTRACTED_DATE                  := :new.EXTRACTED_DATE                 ;
    r_new.LAST_UPDATE_LOGIN               := :new.LAST_UPDATE_LOGIN              ;
    r_new.ATTRIBUTE_CATEGORY              := :new.ATTRIBUTE_CATEGORY             ;
    r_new.ATTRIBUTE1                      := :new.ATTRIBUTE1                     ;
    r_new.ATTRIBUTE2                      := :new.ATTRIBUTE2                     ;
    r_new.ATTRIBUTE3                      := :new.ATTRIBUTE3                     ;
    r_new.ATTRIBUTE4                      := :new.ATTRIBUTE4                     ;
    r_new.ATTRIBUTE5                      := :new.ATTRIBUTE5                     ;
    r_new.ATTRIBUTE6                      := :new.ATTRIBUTE6                     ;
    r_new.ATTRIBUTE7                      := :new.ATTRIBUTE7                     ;
    r_new.ATTRIBUTE8                      := :new.ATTRIBUTE8                     ;
    r_new.ATTRIBUTE9                      := :new.ATTRIBUTE9                     ;
    r_new.ATTRIBUTE10                     := :new.ATTRIBUTE10                    ;
    r_new.RETENTION_PERCENTAGE            := :new.RETENTION_PERCENTAGE           ;
    r_new.INVOICE_SET_ID                  := :new.INVOICE_SET_ID                 ;
    r_new.ORG_ID                          := :new.ORG_ID                         ;
    r_new.INV_CURRENCY_CODE               := :new.INV_CURRENCY_CODE              ;
    r_new.INV_RATE_TYPE                   := :new.INV_RATE_TYPE                  ;
    r_new.INV_RATE_DATE                   := :new.INV_RATE_DATE                  ;
    r_new.INV_EXCHANGE_RATE               := :new.INV_EXCHANGE_RATE              ;
    r_new.BILL_TO_ADDRESS_ID              := :new.BILL_TO_ADDRESS_ID             ;
    r_new.SHIP_TO_ADDRESS_ID              := :new.SHIP_TO_ADDRESS_ID             ;
    r_new.PRC_GENERATED_FLAG              := :new.PRC_GENERATED_FLAG             ;
    r_new.RECEIVABLE_CODE_COMBINATION_ID  := :new.RECEIVABLE_CODE_COMBINATION_ID ;
    r_new.ROUNDING_CODE_COMBINATION_ID    := :new.ROUNDING_CODE_COMBINATION_ID   ;
    r_new.UNBILLED_CODE_COMBINATION_ID    := :new.UNBILLED_CODE_COMBINATION_ID   ;
    r_new.UNEARNED_CODE_COMBINATION_ID    := :new.UNEARNED_CODE_COMBINATION_ID   ;
    r_new.WOFF_CODE_COMBINATION_ID        := :new.WOFF_CODE_COMBINATION_ID       ;
    r_new.ACCTD_CURR_CODE                 := :new.ACCTD_CURR_CODE                ;
    r_new.ACCTD_RATE_TYPE                 := :new.ACCTD_RATE_TYPE                ;
    r_new.ACCTD_RATE_DATE                 := :new.ACCTD_RATE_DATE                ;
    r_new.ACCTD_EXCHG_RATE                := :new.ACCTD_EXCHG_RATE               ;
    r_new.LANGUAGE                        := :new.LANGUAGE                       ;
    r_new.CC_INVOICE_GROUP_CODE           := :new.CC_INVOICE_GROUP_CODE          ;
    r_new.CC_PROJECT_ID                   := :new.CC_PROJECT_ID                  ;
    r_new.IB_AP_TRANSFER_STATUS_CODE      := :new.IB_AP_TRANSFER_STATUS_CODE     ;
    r_new.IB_AP_TRANSFER_ERROR_CODE       := :new.IB_AP_TRANSFER_ERROR_CODE      ;
    r_new.INVPROC_CURRENCY_CODE           := :new.INVPROC_CURRENCY_CODE          ;
    r_new.PROJFUNC_INVTRANS_RATE_TYPE     := :new.PROJFUNC_INVTRANS_RATE_TYPE    ;
    r_new.PROJFUNC_INVTRANS_RATE_DATE     := :new.PROJFUNC_INVTRANS_RATE_DATE    ;
    r_new.PROJFUNC_INVTRANS_EX_RATE       := :new.PROJFUNC_INVTRANS_EX_RATE      ;
    r_new.PA_PERIOD_NAME                  := :new.PA_PERIOD_NAME                 ;
    r_new.GL_PERIOD_NAME                  := :new.GL_PERIOD_NAME                 ;
    r_new.UBR_SUMMARY_ID                  := :new.UBR_SUMMARY_ID                 ;
    r_new.UER_SUMMARY_ID                  := :new.UER_SUMMARY_ID                 ;
    r_new.UBR_UER_PROCESS_FLAG            := :new.UBR_UER_PROCESS_FLAG           ;
    r_new.PJI_SUMMARIZED_FLAG             := :new.PJI_SUMMARIZED_FLAG            ;
    r_new.RETENTION_INVOICE_FLAG          := :new.RETENTION_INVOICE_FLAG         ;
    r_new.RETN_CODE_COMBINATION_ID        := :new.RETN_CODE_COMBINATION_ID       ;
    r_new.PURGE_FLAG                      := :new.PURGE_FLAG                     ;
    r_new.CUSTOMER_ID                     := :new.CUSTOMER_ID                    ;
    r_new.BILL_TO_CUSTOMER_ID             := :new.BILL_TO_CUSTOMER_ID            ;
    r_new.SHIP_TO_CUSTOMER_ID             := :new.SHIP_TO_CUSTOMER_ID            ;
    r_new.BILL_TO_CONTACT_ID              := :new.BILL_TO_CONTACT_ID             ;
    r_new.SHIP_TO_CONTACT_ID              := :new.SHIP_TO_CONTACT_ID             ;
    r_new.CREDIT_MEMO_REASON_CODE         := :new.CREDIT_MEMO_REASON_CODE        ;

  end initialize_new;
 procedure initialize_old as
  begin
    r_old.PROJECT_ID                      := :old.PROJECT_ID                     ;
    r_old.DRAFT_INVOICE_NUM               := :old.DRAFT_INVOICE_NUM              ;
    r_old.LAST_UPDATE_DATE                := :old.LAST_UPDATE_DATE               ;
    r_old.LAST_UPDATED_BY                 := :old.LAST_UPDATED_BY                ;
    r_old.CREATION_DATE                   := :old.CREATION_DATE                  ;
    r_old.CREATED_BY                      := :old.CREATED_BY                     ;
    r_old.TRANSFER_STATUS_CODE            := :old.TRANSFER_STATUS_CODE           ;
    r_old.GENERATION_ERROR_FLAG           := :old.GENERATION_ERROR_FLAG          ;
    r_old.AGREEMENT_ID                    := :old.AGREEMENT_ID                   ;
    r_old.PA_DATE                         := :old.PA_DATE                        ;
    r_old.REQUEST_ID                      := :old.REQUEST_ID                     ;
    r_old.PROGRAM_APPLICATION_ID          := :old.PROGRAM_APPLICATION_ID         ;
    r_old.PROGRAM_ID                      := :old.PROGRAM_ID                     ;
    r_old.PROGRAM_UPDATE_DATE             := :old.PROGRAM_UPDATE_DATE            ;
    r_old.CUSTOMER_BILL_SPLIT             := :old.CUSTOMER_BILL_SPLIT            ;
    r_old.BILL_THROUGH_DATE               := :old.BILL_THROUGH_DATE              ;
    r_old.INVOICE_COMMENT                 := :old.INVOICE_COMMENT                ;
    r_old.APPROVED_DATE                   := :old.APPROVED_DATE                  ;
    r_old.APPROVED_BY_PERSON_ID           := :old.APPROVED_BY_PERSON_ID          ;
    r_old.RELEASED_DATE                   := :old.RELEASED_DATE                  ;
    r_old.RELEASED_BY_PERSON_ID           := :old.RELEASED_BY_PERSON_ID          ;
    r_old.INVOICE_DATE                    := :old.INVOICE_DATE                   ;
    r_old.RA_INVOICE_NUMBER               := :old.RA_INVOICE_NUMBER              ;
    r_old.TRANSFERRED_DATE                := :old.TRANSFERRED_DATE               ;
    r_old.TRANSFER_REJECTION_REASON       := :old.TRANSFER_REJECTION_REASON      ;
    r_old.UNEARNED_REVENUE_CR             := :old.UNEARNED_REVENUE_CR            ;
    r_old.UNBILLED_RECEIVABLE_DR          := :old.UNBILLED_RECEIVABLE_DR         ;
    r_old.GL_DATE                         := :old.GL_DATE                        ;
    r_old.SYSTEM_REFERENCE                := :old.SYSTEM_REFERENCE               ;
    r_old.DRAFT_INVOICE_NUM_CREDITED      := :old.DRAFT_INVOICE_NUM_CREDITED     ;
    r_old.CANCELED_FLAG                   := :old.CANCELED_FLAG                  ;
    r_old.CANCEL_CREDIT_MEMO_FLAG         := :old.CANCEL_CREDIT_MEMO_FLAG        ;
    r_old.WRITE_OFF_FLAG                  := :old.WRITE_OFF_FLAG                 ;
    r_old.CONVERTED_FLAG                  := :old.CONVERTED_FLAG                 ;
    r_old.EXTRACTED_DATE                  := :old.EXTRACTED_DATE                 ;
    r_old.LAST_UPDATE_LOGIN               := :old.LAST_UPDATE_LOGIN              ;
    r_old.ATTRIBUTE_CATEGORY              := :old.ATTRIBUTE_CATEGORY             ;
    r_old.ATTRIBUTE1                      := :old.ATTRIBUTE1                     ;
    r_old.ATTRIBUTE2                      := :old.ATTRIBUTE2                     ;
    r_old.ATTRIBUTE3                      := :old.ATTRIBUTE3                     ;
    r_old.ATTRIBUTE4                      := :old.ATTRIBUTE4                     ;
    r_old.ATTRIBUTE5                      := :old.ATTRIBUTE5                     ;
    r_old.ATTRIBUTE6                      := :old.ATTRIBUTE6                     ;
    r_old.ATTRIBUTE7                      := :old.ATTRIBUTE7                     ;
    r_old.ATTRIBUTE8                      := :old.ATTRIBUTE8                     ;
    r_old.ATTRIBUTE9                      := :old.ATTRIBUTE9                     ;
    r_old.ATTRIBUTE10                     := :old.ATTRIBUTE10                    ;
    r_old.RETENTION_PERCENTAGE            := :old.RETENTION_PERCENTAGE           ;
    r_old.INVOICE_SET_ID                  := :old.INVOICE_SET_ID                 ;
    r_old.ORG_ID                          := :old.ORG_ID                         ;
    r_old.INV_CURRENCY_CODE               := :old.INV_CURRENCY_CODE              ;
    r_old.INV_RATE_TYPE                   := :old.INV_RATE_TYPE                  ;
    r_old.INV_RATE_DATE                   := :old.INV_RATE_DATE                  ;
    r_old.INV_EXCHANGE_RATE               := :old.INV_EXCHANGE_RATE              ;
    r_old.BILL_TO_ADDRESS_ID              := :old.BILL_TO_ADDRESS_ID             ;
    r_old.SHIP_TO_ADDRESS_ID              := :old.SHIP_TO_ADDRESS_ID             ;
    r_old.PRC_GENERATED_FLAG              := :old.PRC_GENERATED_FLAG             ;
    r_old.RECEIVABLE_CODE_COMBINATION_ID  := :old.RECEIVABLE_CODE_COMBINATION_ID ;
    r_old.ROUNDING_CODE_COMBINATION_ID    := :old.ROUNDING_CODE_COMBINATION_ID   ;
    r_old.UNBILLED_CODE_COMBINATION_ID    := :old.UNBILLED_CODE_COMBINATION_ID   ;
    r_old.UNEARNED_CODE_COMBINATION_ID    := :old.UNEARNED_CODE_COMBINATION_ID   ;
    r_old.WOFF_CODE_COMBINATION_ID        := :old.WOFF_CODE_COMBINATION_ID       ;
    r_old.ACCTD_CURR_CODE                 := :old.ACCTD_CURR_CODE                ;
    r_old.ACCTD_RATE_TYPE                 := :old.ACCTD_RATE_TYPE                ;
    r_old.ACCTD_RATE_DATE                 := :old.ACCTD_RATE_DATE                ;
    r_old.ACCTD_EXCHG_RATE                := :old.ACCTD_EXCHG_RATE               ;
    r_old.LANGUAGE                        := :old.LANGUAGE                       ;
    r_old.CC_INVOICE_GROUP_CODE           := :old.CC_INVOICE_GROUP_CODE          ;
    r_old.CC_PROJECT_ID                   := :old.CC_PROJECT_ID                  ;
    r_old.IB_AP_TRANSFER_STATUS_CODE      := :old.IB_AP_TRANSFER_STATUS_CODE     ;
    r_old.IB_AP_TRANSFER_ERROR_CODE       := :old.IB_AP_TRANSFER_ERROR_CODE      ;
    r_old.INVPROC_CURRENCY_CODE           := :old.INVPROC_CURRENCY_CODE          ;
    r_old.PROJFUNC_INVTRANS_RATE_TYPE     := :old.PROJFUNC_INVTRANS_RATE_TYPE    ;
    r_old.PROJFUNC_INVTRANS_RATE_DATE     := :old.PROJFUNC_INVTRANS_RATE_DATE    ;
    r_old.PROJFUNC_INVTRANS_EX_RATE       := :old.PROJFUNC_INVTRANS_EX_RATE      ;
    r_old.PA_PERIOD_NAME                  := :old.PA_PERIOD_NAME                 ;
    r_old.GL_PERIOD_NAME                  := :old.GL_PERIOD_NAME                 ;
    r_old.UBR_SUMMARY_ID                  := :old.UBR_SUMMARY_ID                 ;
    r_old.UER_SUMMARY_ID                  := :old.UER_SUMMARY_ID                 ;
    r_old.UBR_UER_PROCESS_FLAG            := :old.UBR_UER_PROCESS_FLAG           ;
    r_old.PJI_SUMMARIZED_FLAG             := :old.PJI_SUMMARIZED_FLAG            ;
    r_old.RETENTION_INVOICE_FLAG          := :old.RETENTION_INVOICE_FLAG         ;
    r_old.RETN_CODE_COMBINATION_ID        := :old.RETN_CODE_COMBINATION_ID       ;
    r_old.PURGE_FLAG                      := :old.PURGE_FLAG                     ;
    r_old.CUSTOMER_ID                     := :old.CUSTOMER_ID                    ;
    r_old.BILL_TO_CUSTOMER_ID             := :old.BILL_TO_CUSTOMER_ID            ;
    r_old.SHIP_TO_CUSTOMER_ID             := :old.SHIP_TO_CUSTOMER_ID            ;
    r_old.BILL_TO_CONTACT_ID              := :old.BILL_TO_CONTACT_ID             ;
    r_old.SHIP_TO_CONTACT_ID              := :old.SHIP_TO_CONTACT_ID             ;
    r_old.CREDIT_MEMO_REASON_CODE         := :old.CREDIT_MEMO_REASON_CODE        ;

  end initialize_old;

  /*------------------------------------------------------------------------------------------------------------*/

  function request_exists_for_event (pv_event varchar2 ) return boolean
  is
    ln_req_exists number;
    lv_ret_val boolean;

    cursor c_chk_default_req_exists
    is
      select 1
      from   jai_trx_repo_extract_gt gt
      where  gt.transaction_reference_id = ln_conc_request_id
      and    transaction_source = pv_event;

    cursor c_chk_recalc_req_exists
    is
      select 1
      from   jai_trx_gt gt
      where  gt.jai_info_n1   = r_new.draft_invoice_num
      and    gt.jai_info_n2   = r_new.project_id
      and    gt.jai_info_v1   = pv_event;


  begin
      debug (ln_reg_id, 'OPEN/FETCH curosr c_chk_req_exists');

      lv_ret_val := false;

      if pv_event = jai_constants.DEFAULT_TAXES then

        open  c_chk_default_req_exists;
        fetch c_chk_default_req_exists into ln_req_exists;
        lv_ret_val  := c_chk_default_req_exists%found ;
        close c_chk_default_req_exists;

      elsif pv_event = jai_constants.RECALCULATE_TAXES
      then

        open  c_chk_recalc_req_exists;
        fetch c_chk_recalc_req_exists into ln_req_exists;
        lv_ret_val  := c_chk_recalc_req_exists%found ;
        close c_chk_recalc_req_exists;

      end if;

      debug (ln_reg_id, 'CLOSED curosr c_chk_req_exists');

      if lv_ret_val then
        debug (ln_reg_id,'request found');
      else
        debug (ln_reg_id,'request not found');
      end if;

      return lv_ret_val;

  end request_exists_for_event;

  /*------------------------------------------------------------------------------------------------------------*/

  --
  --  This procedure will submit concurrent rquest JAINPATX for recalculating the taxes in case of
  --  currency or exchange reate change in the project draft invoice due to Recalculate functionality
  --  The procedure will check if a request already exists for this session if not it will submit otherwise
  --  it will simply return
  --
  procedure submit_request (pv_event  varchar2 )
  is
    ln_request_id         number;
    lv_result boolean;

    ln_parent_request_id  pa_draft_invoices_all.request_id%type;
    ln_project_id         pa_draft_invoices_all.request_id%type;
    ln_draft_invoice_num  pa_draft_invoices_all.request_id%type;
  begin
    debug (ln_reg_id, 'Checking if requiest already submitted for event='||pv_event);
    if (request_exists_for_event (pv_event)) = false then
      --
      -- Request does not exists
      --
      if pv_event = jai_constants.default_taxes then

        ln_parent_request_id := ln_conc_request_id;

      elsif pv_event = jai_constants.recalculate_taxes then

        ln_project_id         := r_new.project_id;
        ln_draft_invoice_num  := r_new.draft_invoice_num;

      end if;
      /*debug (ln_reg_id, 'Submmiting Request with parameters:'||chr(10)
                                     ||'ln_parent_request_id='||ln_parent_request_id  ||  chr(10)
                                     ||'ln_project_id='||ln_project_id                ||  chr(10)
                                     ||'ln_draft_invoice_num='||ln_draft_invoice_num  ||  chr(10)
                                     ||'pv_event='||pv_event
                        );*/
      lv_result     := fnd_request.set_mode(true);
      ln_request_id := fnd_request.submit_request
                            (
                              'JA'
                            , 'JAINPATX'
                            , ''
                            , ''
                            , FALSE
                            , ln_parent_request_id                  -- p_request_id
                            , ln_project_id                         -- p_project_id
                            , ln_draft_invoice_num                  -- p_draft_invoice_num
                            , pv_event                              -- p_event
                            , CHR(0)
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , ''
                            , '', '', '', '', '', '', '', '', '', '',
                              '', '', '', '', '', '', '', '', '', '',
                              '', '', '', '', '', '', '', '', '', '',
                              '', '', '', '', '', '', '', '', '', '',
                              '', '', '', '', '', '', '', '', '', '',
                              '', '', '', '', '', '', '', '', '', '',
                              '', '', '', '', '', '', '', '', '', '',
                              '', '', '', '', '', '', '', ''
                          );
      debug (ln_reg_id, 'ln_request_id='||ln_request_id);
      if ln_request_id > 0 then

        if pv_event = jai_constants.DEFAULT_TAXES then
          --
          -- Event is default taxes hence the trigger is invoked by a project's draft invoice generation concurrent
          -- By inserting a row in to global temporary table (which preserve row ever after COMMIT) to later check
          -- if the request is already submitted in the current session (concurrent session)
          --
          insert into jai_trx_repo_extract_gt
            ( transaction_source          -- event
            , transaction_reference_id    -- request_id
            , document_id                 -- ln_parent_request_id for event = DEFAULT_TAXES
            )
          values
            (
              pv_event
            , ln_request_id
            , ln_parent_request_id
            );
        elsif pv_event = jai_constants.RECALCULATE_TAXES then
          --
          -- Recalulate event is triggered from the front-end UI and here using a global temporary table
          -- (which *DO NOT* preseve rows on COMMIT) so after each commit a new request will be submited
          --
          insert into jai_trx_gt
            ( jai_info_v1             -- event
            , jai_info_n1             -- request_id
            , jai_info_n2             -- prjoect_id
            , jai_info_n3             -- draft_invoice_num
            )
          values
            ( pv_event
            , ln_project_id
            , ln_draft_invoice_num
            , ln_request_id
            );
        end if; --> pv_event
      else
        fnd_message.set_name ('JA','JAI_GENERIC_MSG');
        fnd_message.set_token('MSG_TEXT', 'Failed to submit the request JAINPADI for event='||pv_event
                                                      ||',project_id='||ln_project_id
                                                      ||',draft_invoice_num='||ln_draft_invoice_num
                                                      ||',parent_req_id='||ln_parent_request_id
                             );
        app_exception.raise_exception ;
      end if;
    end if;

    debug (ln_reg_id, 'Submit_Request completed');

  end submit_request;

/*----------------------------------------------------------------------------------------------------------------------------
CHANGE HISTORY for FILENAME: jai_pdia_ariud.sql
S.No  dd/mm/yyyy   Author and Details
------------------------------------------------------------------------------------------------------------------------------
1     12/02/2007   Vijay Shankar for Bug# 6012570 (5876390), Version:115.1
                    This trigger created for Projects Billing Implementation.
                    Initially the code is added
                      - to handle Defaultation of taxes during INSERTING
                      - VAT and Excise taxes processing during Release event of Draft Invoice
                      - Delete the data from IL tables to sync. with base draft invoice

------------------------------------------------------------------------------------------------------------------------------*/

BEGIN

  lv_object := 'jai_cmn_utils_pkg.check_jai_exists';
  lv_action := 'CHECK_JAI_EXISTS';

  jai_cmn_debug_contexts_pkg.register ('JAI_PA_PDIA_AFTER_T1',ln_reg_id);

  debug (ln_reg_id, 'Check if India - processing is required?');

  /* Check to see if the transaction in context is related to India or not. If not, then return */
  if  jai_cmn_utils_pkg.check_jai_exists (
          p_calling_object   => 'JAI_PDIA_ARIUD_T1',
          p_org_id           => nvl(:new.org_id, :old.org_id)
      ) = false
  then
    return;
  end if;

  debug (ln_reg_id, 'India - Processing is required');


  IF INSERTING THEN
    lv_action := 'INSERTING';
     initialize_new;
  ELSIF UPDATING THEN
     lv_action := 'UPDATING';
     initialize_new;
     initialize_old;
  ELSIF DELETING THEN
    lv_action := 'DELETING';
    initialize_old;
  END IF ;

  debug (ln_reg_id, 'Trigger action='||lv_action);

  --
  --  INSERTING SECTION
  --

  if inserting   then

     submit_request
        ( pv_event              =>  jai_constants.default_taxes
        );

  end if ;

  --
  -- UPDATING SECTION
  --

 if UPDATING then
    debug (ln_reg_id, 'ln_conc_request_id='||ln_conc_request_id);
    if (   r_new.inv_currency_code <> r_old.inv_currency_code
       or  r_new.inv_exchange_rate <> r_old.inv_exchange_rate
       )
    and nvl(ln_conc_request_id,-1) = -1 -- Update is not happening through a concurrent request
    then

      debug (ln_reg_id, 'Currency/Exchange change:r_new.inv_exchange_rate='||r_new.inv_exchange_rate
                                                             ||',r_old.inv_exchange_rate='||r_old.inv_exchange_rate
                                                             ||',r_new.inv_currency_code='||r_new.inv_currency_code
                                                             ||',r_old.inv_currency_code='||r_old.inv_currency_code
                        );
      submit_request
        ( pv_event              =>  jai_constants.recalculate_taxes
        );

    end if;

  end if;

  /* if the following condition is successful, it means the invoice is successfully released.
    So, we can go ahead and Process CENVAT/EXCISE and VAT taxes
  */
  if UPDATING
    and :old.released_date is null and :new.released_date is not null
  then

    if jai_pa_billing_pkg.gv_debug then
      jai_cmn_utils_pkg.print_log ( jai_pa_billing_pkg.file, '1 trigger before jai_pa_pdia_after_t1:');
    end if;

    jai_pa_billing_pkg.process_draft_invoice_release(
      pr_draft_invoice          => r_new,
      pv_called_from            => 'JAI_PA_PDIA_AFTER_T1',
      pv_process_flag           => lv_process_flag,
      pv_process_message        => lv_process_message
    );

    if jai_pa_billing_pkg.gv_debug then
      jai_cmn_utils_pkg.print_log ( jai_pa_billing_pkg.file, '2 trigger before jai_pa_pdia_after_t1:'
        ||', lv_process_flag:'||lv_process_flag
        ||', lv_process_message:'||lv_process_message
        );
    end if;

    if lv_process_flag in (jai_constants.unexpected_error, jai_constants.expected_error, 'E') then
      goto end_of_trigger;
    end if;

    /* TESTING purpose
    fnd_message.set_name( 'JA', 'JAI_GENERIC_MSG');
    fnd_message.set_token('MSG_TEXT', 'Ding Error');
    app_exception.raise_exception;
    */
  end if;

  --
  --  DELETING SECTION
  --

  if DELETING then

    JAI_PA_TAX_PKG.sync_deletion(
      pn_project_id           => :old.project_id,
      pn_draft_invoice_num    => :old.draft_invoice_num,
      pv_process_flag         => lv_process_flag,
      pv_process_message      => lv_process_message
    ) ;

    if lv_process_flag in (jai_constants.unexpected_error, jai_constants.expected_error, 'E') then
      goto end_of_trigger;
    end if;

  end if;

  --
  -- End of Trigger logic
  --
  <<end_of_trigger>>
  jai_cmn_debug_contexts_pkg.deregister (ln_reg_id);
  if lv_process_flag in (jai_constants.unexpected_error, jai_constants.expected_error, 'E') then
    fnd_message.set_name( 'JA', 'JAI_GENERIC_MSG');
    fnd_message.set_token('MSG_TEXT', lv_process_message);
    app_exception.raise_exception;
  end if;

END jai_pa_pdia_after_t1;

/
ALTER TRIGGER "APPS"."JAI_PA_PDIA_AFTER_T1" DISABLE;
