--------------------------------------------------------
--  DDL for Trigger JAI_AR_RCTA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AR_RCTA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AR"."RA_CUSTOMER_TRX_ALL"
FOR EACH ROW
DECLARE
  /*------------------------------------------------------------------------------------------
   FILENAME: jai_ar_rcta_t.sql

   CHANGE HISTORY:
   S.No      Date         Author and Details
   1      07/11/200b      CSahoo For Bug#7450481, File Version 120.7.12010000.2
                          Issue: AUTOINVOICE IMPORT PROGRAM ENDING IN ERROR FOR BILL ONLY ORDERS
                          Fix: Added the code to call the procedure JAI_AR_RCTA_TRIGGER_PKG.ARD_T1
                               when the base table gets deleted.

2. 24/04/2009	 JMEENA for bug#8451356
			Issue: Procedure jai_ar_match_tax_pkg.acct_inclu_taxes inserts duplicate accounting entries for inclusive taxes in the gl_interface table
				 becase this trigger fires two time so the procedure also executes two time hence insert duplicate records.
			Fix: Added condition before calling procedure

3. 16/09/2009	JMEENA for bug#8864023
		       Added a condition before calling jai_ar_match_tax_pkg.acct_inclu_taxes to ensure that this procedure
		       is be called only if organization_id in not equal to -1.
		       Organization_id will be -1 If the invoice is created directly through AR transaction form and does not have any IL taxes in
		       that case this procedure should not be called.

4. 25/01/2010 Bo Li for bug#9303168
            Added a script to submit a concurrent program for updating the reference field of RA_CUSTOMER_TRX_ALL
            to display the VAT/Excise Number in AR transaction workbench


5. 29/04/2010 Bo Li for bug#9666476
            Added a script to handle the non-shippale RMA flow by invoking the procedure JAI_AR_RCTA_TRIGGER_PKG.ARU_T8
            as updating.

6. 05-May-2010 Bo Li for Bug#9490173
               Add the logic to control the trigger for invoking the request which updates the reference filed
               of the RA_CUSTOMER_TRX_ALL for many times.
  --------------------------------------------------------------------------------------------*/
  t_old_rec             RA_CUSTOMER_TRX_ALL%rowtype ;
  t_new_rec             RA_CUSTOMER_TRX_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;
  lv_inclu_tax_flag     VARCHAR2(3)   ;  -- Added by Jia Li for tax inclusive computation on 2007/12/01

  -- Added by Jia Li for tax inclusive computation on 2007/12/01
  -----------------------------------------------------------------
  CURSOR inclu_flag_cur IS
    SELECT
      NVL(ja.inclusive_tax_flag, 'N')  inclusive_tax_flag
    FROM
      jai_ap_tds_years ja
    WHERE ja.legal_entity_id = t_new_rec.org_id
      AND sysdate between ja.start_date and ja.end_date;
  ----------------------------------------------------------------
--Added below cursor for the bug#8864023 by JMEENA
CURSOR organization_id_check(p_customer_trx_id number) IS
   SELECT
	NVL(organization_id,-1) organization_id
   FROM jai_ar_trxs
   WHERE customer_trx_id = p_customer_trx_id;

v_organization_id NUMBER;

   --Added by Bo Li for VAT/Excise Number shown in AR transaction workbench on 19-Jan-2010 and In Bug 9303168,Begin
  -----------------------------------------------------------------------------------------------
  ln_request_id          NUMBER;
  cv_process_program     CONSTANT VARCHAR2(240):= 'JAIEVNITW';
  lb_return_mode         BOOLEAN;
  lv_excise_inv_no       JAI_AR_TRX_LINES.excise_invoice_no%Type;
  lv_vat_inv_no          JAI_AR_TRXS.VAT_INVOICE_NO%TYPE;

  CURSOR get_excise_inv_no_cur(pn_customer_trx_id NUMBER) IS
  SELECT l.excise_invoice_no
  FROM   JAI_AR_TRX_LINES L
  WHERE  l.customer_trx_id = pn_customer_trx_id;

  CURSOR get_vat_inv_no_cur(pn_customer_trx_id NUMBER) IS
  SELECT h.vat_invoice_no
  FROM   JAI_AR_TRXS h
  WHERE  h.customer_trx_id = pn_customer_trx_id;
  -----------------------------------------------------------------------------------------------
    --Added by Bo Li for VAT/Excise Number shown in AR transaction workbench on 19-Jan-2010 and In Bug 9303168,End

      --Added by Bo Li for Bug9490173 on 05-May-2010 ,Begin
  -----------------------------------------------------------------------------------------------
    ln_max_req_id  		NUMBER;
		lv_rphase 				VARCHAR2(80);
		lv_rstatus 				VARCHAR2(80);
		lv_dphase 				VARCHAR2(30);
		lv_dstatus 				VARCHAR2(30);
		lv_message 				VARCHAR2(240);
		lb_call_status 		BOOLEAN;

    CURSOR get_max_request_id_cur(pn_customer_transaction_id NUMBER)
    IS
    Select nvl(Max(Request_ID),-1)
    From Fnd_Concurrent_Programs FCP,
         Fnd_Application         FA ,
         Fnd_Concurrent_Requests FCR
   Where FCR.Program_Application_ID = FA.Application_ID
     AND FCR.Concurrent_Program_ID  = FCP.Concurrent_Program_ID
     AND FA.Application_ID          = FCP.Application_ID
     AND Concurrent_Program_Name    = cv_process_program
     AND FA.Application_Short_Name  = 'JA'
     AND FCR.argument1             = pn_customer_transaction_id;
  -----------------------------------------------------------------------------------------------
     --Added by Bo Li for Bug9490173 on 05-May-2010,End
  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.CUSTOMER_TRX_ID                          := :new.CUSTOMER_TRX_ID                               ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.TRX_NUMBER                               := :new.TRX_NUMBER                                    ;
    t_new_rec.CUST_TRX_TYPE_ID                         := :new.CUST_TRX_TYPE_ID                              ;
    t_new_rec.TRX_DATE                                 := :new.TRX_DATE                                      ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.BILL_TO_CONTACT_ID                       := :new.BILL_TO_CONTACT_ID                            ;
    t_new_rec.BATCH_ID                                 := :new.BATCH_ID                                      ;
    t_new_rec.BATCH_SOURCE_ID                          := :new.BATCH_SOURCE_ID                               ;
    t_new_rec.REASON_CODE                              := :new.REASON_CODE                                   ;
    t_new_rec.SOLD_TO_CUSTOMER_ID                      := :new.SOLD_TO_CUSTOMER_ID                           ;
    t_new_rec.SOLD_TO_CONTACT_ID                       := :new.SOLD_TO_CONTACT_ID                            ;
    t_new_rec.SOLD_TO_SITE_USE_ID                      := :new.SOLD_TO_SITE_USE_ID                           ;
    t_new_rec.BILL_TO_CUSTOMER_ID                      := :new.BILL_TO_CUSTOMER_ID                           ;
    t_new_rec.BILL_TO_SITE_USE_ID                      := :new.BILL_TO_SITE_USE_ID                           ;
    t_new_rec.SHIP_TO_CUSTOMER_ID                      := :new.SHIP_TO_CUSTOMER_ID                           ;
    t_new_rec.SHIP_TO_CONTACT_ID                       := :new.SHIP_TO_CONTACT_ID                            ;
    t_new_rec.SHIP_TO_SITE_USE_ID                      := :new.SHIP_TO_SITE_USE_ID                           ;
    t_new_rec.SHIPMENT_ID                              := :new.SHIPMENT_ID                                   ;
    t_new_rec.REMIT_TO_ADDRESS_ID                      := :new.REMIT_TO_ADDRESS_ID                           ;
    t_new_rec.TERM_ID                                  := :new.TERM_ID                                       ;
    t_new_rec.TERM_DUE_DATE                            := :new.TERM_DUE_DATE                                 ;
    t_new_rec.PREVIOUS_CUSTOMER_TRX_ID                 := :new.PREVIOUS_CUSTOMER_TRX_ID                      ;
    t_new_rec.PRIMARY_SALESREP_ID                      := :new.PRIMARY_SALESREP_ID                           ;
    t_new_rec.PRINTING_ORIGINAL_DATE                   := :new.PRINTING_ORIGINAL_DATE                        ;
    t_new_rec.PRINTING_LAST_PRINTED                    := :new.PRINTING_LAST_PRINTED                         ;
    t_new_rec.PRINTING_OPTION                          := :new.PRINTING_OPTION                               ;
    t_new_rec.PRINTING_COUNT                           := :new.PRINTING_COUNT                                ;
    t_new_rec.PRINTING_PENDING                         := :new.PRINTING_PENDING                              ;
    t_new_rec.PURCHASE_ORDER                           := :new.PURCHASE_ORDER                                ;
    t_new_rec.PURCHASE_ORDER_REVISION                  := :new.PURCHASE_ORDER_REVISION                       ;
    t_new_rec.PURCHASE_ORDER_DATE                      := :new.PURCHASE_ORDER_DATE                           ;
    t_new_rec.CUSTOMER_REFERENCE                       := :new.CUSTOMER_REFERENCE                            ;
    t_new_rec.CUSTOMER_REFERENCE_DATE                  := :new.CUSTOMER_REFERENCE_DATE                       ;
    t_new_rec.COMMENTS                                 := :new.COMMENTS                                      ;
    t_new_rec.INTERNAL_NOTES                           := :new.INTERNAL_NOTES                                ;
    t_new_rec.EXCHANGE_RATE_TYPE                       := :new.EXCHANGE_RATE_TYPE                            ;
    t_new_rec.EXCHANGE_DATE                            := :new.EXCHANGE_DATE                                 ;
    t_new_rec.EXCHANGE_RATE                            := :new.EXCHANGE_RATE                                 ;
    t_new_rec.TERRITORY_ID                             := :new.TERRITORY_ID                                  ;
    t_new_rec.INVOICE_CURRENCY_CODE                    := :new.INVOICE_CURRENCY_CODE                         ;
    t_new_rec.INITIAL_CUSTOMER_TRX_ID                  := :new.INITIAL_CUSTOMER_TRX_ID                       ;
    t_new_rec.AGREEMENT_ID                             := :new.AGREEMENT_ID                                  ;
    t_new_rec.END_DATE_COMMITMENT                      := :new.END_DATE_COMMITMENT                           ;
    t_new_rec.START_DATE_COMMITMENT                    := :new.START_DATE_COMMITMENT                         ;
    t_new_rec.LAST_PRINTED_SEQUENCE_NUM                := :new.LAST_PRINTED_SEQUENCE_NUM                     ;
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
    t_new_rec.ORIG_SYSTEM_BATCH_NAME                   := :new.ORIG_SYSTEM_BATCH_NAME                        ;
    t_new_rec.POST_REQUEST_ID                          := :new.POST_REQUEST_ID                               ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.FINANCE_CHARGES                          := :new.FINANCE_CHARGES                               ;
    t_new_rec.COMPLETE_FLAG                            := :new.COMPLETE_FLAG                                 ;
    t_new_rec.POSTING_CONTROL_ID                       := :new.POSTING_CONTROL_ID                            ;
    t_new_rec.BILL_TO_ADDRESS_ID                       := :new.BILL_TO_ADDRESS_ID                            ;
    t_new_rec.RA_POST_LOOP_NUMBER                      := :new.RA_POST_LOOP_NUMBER                           ;
    t_new_rec.SHIP_TO_ADDRESS_ID                       := :new.SHIP_TO_ADDRESS_ID                            ;
    t_new_rec.CREDIT_METHOD_FOR_RULES                  := :new.CREDIT_METHOD_FOR_RULES                       ;
    t_new_rec.CREDIT_METHOD_FOR_INSTALLMENTS           := :new.CREDIT_METHOD_FOR_INSTALLMENTS                ;
    t_new_rec.RECEIPT_METHOD_ID                        := :new.RECEIPT_METHOD_ID                             ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.RELATED_CUSTOMER_TRX_ID                  := :new.RELATED_CUSTOMER_TRX_ID                       ;
    t_new_rec.INVOICING_RULE_ID                        := :new.INVOICING_RULE_ID                             ;
    t_new_rec.SHIP_VIA                                 := :new.SHIP_VIA                                      ;
    t_new_rec.SHIP_DATE_ACTUAL                         := :new.SHIP_DATE_ACTUAL                              ;
    t_new_rec.WAYBILL_NUMBER                           := :new.WAYBILL_NUMBER                                ;
    t_new_rec.FOB_POINT                                := :new.FOB_POINT                                     ;
    t_new_rec.CUSTOMER_BANK_ACCOUNT_ID                 := :new.CUSTOMER_BANK_ACCOUNT_ID                      ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE1              := :new.INTERFACE_HEADER_ATTRIBUTE1                   ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE2              := :new.INTERFACE_HEADER_ATTRIBUTE2                   ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE3              := :new.INTERFACE_HEADER_ATTRIBUTE3                   ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE4              := :new.INTERFACE_HEADER_ATTRIBUTE4                   ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE5              := :new.INTERFACE_HEADER_ATTRIBUTE5                   ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE6              := :new.INTERFACE_HEADER_ATTRIBUTE6                   ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE7              := :new.INTERFACE_HEADER_ATTRIBUTE7                   ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE8              := :new.INTERFACE_HEADER_ATTRIBUTE8                   ;
    t_new_rec.INTERFACE_HEADER_CONTEXT                 := :new.INTERFACE_HEADER_CONTEXT                      ;
    t_new_rec.DEFAULT_USSGL_TRX_CODE_CONTEXT           := :new.DEFAULT_USSGL_TRX_CODE_CONTEXT                ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE10             := :new.INTERFACE_HEADER_ATTRIBUTE10                  ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE11             := :new.INTERFACE_HEADER_ATTRIBUTE11                  ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE12             := :new.INTERFACE_HEADER_ATTRIBUTE12                  ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE13             := :new.INTERFACE_HEADER_ATTRIBUTE13                  ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE14             := :new.INTERFACE_HEADER_ATTRIBUTE14                  ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE15             := :new.INTERFACE_HEADER_ATTRIBUTE15                  ;
    t_new_rec.INTERFACE_HEADER_ATTRIBUTE9              := :new.INTERFACE_HEADER_ATTRIBUTE9                   ;
    t_new_rec.DEFAULT_USSGL_TRANSACTION_CODE           := :new.DEFAULT_USSGL_TRANSACTION_CODE                ;
    t_new_rec.RECURRED_FROM_TRX_NUMBER                 := :new.RECURRED_FROM_TRX_NUMBER                      ;
    t_new_rec.STATUS_TRX                               := :new.STATUS_TRX                                    ;
    t_new_rec.DOC_SEQUENCE_ID                          := :new.DOC_SEQUENCE_ID                               ;
    t_new_rec.DOC_SEQUENCE_VALUE                       := :new.DOC_SEQUENCE_VALUE                            ;
    t_new_rec.PAYING_CUSTOMER_ID                       := :new.PAYING_CUSTOMER_ID                            ;
    t_new_rec.PAYING_SITE_USE_ID                       := :new.PAYING_SITE_USE_ID                            ;
    t_new_rec.RELATED_BATCH_SOURCE_ID                  := :new.RELATED_BATCH_SOURCE_ID                       ;
    t_new_rec.DEFAULT_TAX_EXEMPT_FLAG                  := :new.DEFAULT_TAX_EXEMPT_FLAG                       ;
    t_new_rec.CREATED_FROM                             := :new.CREATED_FROM                                  ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.WH_UPDATE_DATE                           := :new.WH_UPDATE_DATE                                ;
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
    t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :new.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_new_rec.EDI_PROCESSED_FLAG                       := :new.EDI_PROCESSED_FLAG                            ;
    t_new_rec.EDI_PROCESSED_STATUS                     := :new.EDI_PROCESSED_STATUS                          ;
    t_new_rec.GLOBAL_ATTRIBUTE21                       := :new.GLOBAL_ATTRIBUTE21                            ;
    t_new_rec.GLOBAL_ATTRIBUTE22                       := :new.GLOBAL_ATTRIBUTE22                            ;
    t_new_rec.GLOBAL_ATTRIBUTE23                       := :new.GLOBAL_ATTRIBUTE23                            ;
    t_new_rec.GLOBAL_ATTRIBUTE24                       := :new.GLOBAL_ATTRIBUTE24                            ;
    t_new_rec.GLOBAL_ATTRIBUTE25                       := :new.GLOBAL_ATTRIBUTE25                            ;
    t_new_rec.GLOBAL_ATTRIBUTE26                       := :new.GLOBAL_ATTRIBUTE26                            ;
    t_new_rec.GLOBAL_ATTRIBUTE27                       := :new.GLOBAL_ATTRIBUTE27                            ;
    t_new_rec.GLOBAL_ATTRIBUTE28                       := :new.GLOBAL_ATTRIBUTE28                            ;
    t_new_rec.GLOBAL_ATTRIBUTE29                       := :new.GLOBAL_ATTRIBUTE29                            ;
    t_new_rec.GLOBAL_ATTRIBUTE30                       := :new.GLOBAL_ATTRIBUTE30                            ;
    t_new_rec.MRC_EXCHANGE_RATE_TYPE                   := :new.MRC_EXCHANGE_RATE_TYPE                        ;
    t_new_rec.MRC_EXCHANGE_DATE                        := :new.MRC_EXCHANGE_DATE                             ;
    t_new_rec.MRC_EXCHANGE_RATE                        := :new.MRC_EXCHANGE_RATE                             ;
    t_new_rec.PAYMENT_SERVER_ORDER_NUM                 := :new.PAYMENT_SERVER_ORDER_NUM                      ;
    t_new_rec.APPROVAL_CODE                            := :new.APPROVAL_CODE                                 ;
    t_new_rec.ADDRESS_VERIFICATION_CODE                := :new.ADDRESS_VERIFICATION_CODE                     ;
    t_new_rec.OLD_TRX_NUMBER                           := :new.OLD_TRX_NUMBER                                ;
    t_new_rec.BR_AMOUNT                                := :new.BR_AMOUNT                                     ;
    t_new_rec.BR_UNPAID_FLAG                           := :new.BR_UNPAID_FLAG                                ;
    t_new_rec.BR_ON_HOLD_FLAG                          := :new.BR_ON_HOLD_FLAG                               ;
    t_new_rec.DRAWEE_ID                                := :new.DRAWEE_ID                                     ;
    t_new_rec.DRAWEE_CONTACT_ID                        := :new.DRAWEE_CONTACT_ID                             ;
    t_new_rec.DRAWEE_SITE_USE_ID                       := :new.DRAWEE_SITE_USE_ID                            ;
    t_new_rec.REMITTANCE_BANK_ACCOUNT_ID               := :new.REMITTANCE_BANK_ACCOUNT_ID                    ;
    t_new_rec.OVERRIDE_REMIT_ACCOUNT_FLAG              := :new.OVERRIDE_REMIT_ACCOUNT_FLAG                   ;
    t_new_rec.DRAWEE_BANK_ACCOUNT_ID                   := :new.DRAWEE_BANK_ACCOUNT_ID                        ;
    t_new_rec.SPECIAL_INSTRUCTIONS                     := :new.SPECIAL_INSTRUCTIONS                          ;
    t_new_rec.REMITTANCE_BATCH_ID                      := :new.REMITTANCE_BATCH_ID                           ;
    t_new_rec.PREPAYMENT_FLAG                          := :new.PREPAYMENT_FLAG                               ;
    t_new_rec.CT_REFERENCE                             := :new.CT_REFERENCE                                  ;
    t_new_rec.CONTRACT_ID                              := :new.CONTRACT_ID                                   ;
    t_new_rec.BILL_TEMPLATE_ID                         := :new.BILL_TEMPLATE_ID                              ;
    t_new_rec.REVERSED_CASH_RECEIPT_ID                 := :new.REVERSED_CASH_RECEIPT_ID                      ;
    t_new_rec.CC_ERROR_CODE                            := :new.CC_ERROR_CODE                                 ;
    t_new_rec.CC_ERROR_TEXT                            := :new.CC_ERROR_TEXT                                 ;
    t_new_rec.CC_ERROR_FLAG                            := :new.CC_ERROR_FLAG                                 ;
    t_new_rec.UPGRADE_METHOD                           := :new.UPGRADE_METHOD                                ;
    t_new_rec.LEGAL_ENTITY_ID                          := :new.LEGAL_ENTITY_ID                               ;
    t_new_rec.REMIT_BANK_ACCT_USE_ID                   := :new.REMIT_BANK_ACCT_USE_ID                        ;
    t_new_rec.PAYMENT_TRXN_EXTENSION_ID                := :new.PAYMENT_TRXN_EXTENSION_ID                     ;
    t_new_rec.AX_ACCOUNTED_FLAG                        := :new.AX_ACCOUNTED_FLAG                             ;
    t_new_rec.APPLICATION_ID                           := :new.APPLICATION_ID                                ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.CUSTOMER_TRX_ID                          := :old.CUSTOMER_TRX_ID                               ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.TRX_NUMBER                               := :old.TRX_NUMBER                                    ;
    t_old_rec.CUST_TRX_TYPE_ID                         := :old.CUST_TRX_TYPE_ID                              ;
    t_old_rec.TRX_DATE                                 := :old.TRX_DATE                                      ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.BILL_TO_CONTACT_ID                       := :old.BILL_TO_CONTACT_ID                            ;
    t_old_rec.BATCH_ID                                 := :old.BATCH_ID                                      ;
    t_old_rec.BATCH_SOURCE_ID                          := :old.BATCH_SOURCE_ID                               ;
    t_old_rec.REASON_CODE                              := :old.REASON_CODE                                   ;
    t_old_rec.SOLD_TO_CUSTOMER_ID                      := :old.SOLD_TO_CUSTOMER_ID                           ;
    t_old_rec.SOLD_TO_CONTACT_ID                       := :old.SOLD_TO_CONTACT_ID                            ;
    t_old_rec.SOLD_TO_SITE_USE_ID                      := :old.SOLD_TO_SITE_USE_ID                           ;
    t_old_rec.BILL_TO_CUSTOMER_ID                      := :old.BILL_TO_CUSTOMER_ID                           ;
    t_old_rec.BILL_TO_SITE_USE_ID                      := :old.BILL_TO_SITE_USE_ID                           ;
    t_old_rec.SHIP_TO_CUSTOMER_ID                      := :old.SHIP_TO_CUSTOMER_ID                           ;
    t_old_rec.SHIP_TO_CONTACT_ID                       := :old.SHIP_TO_CONTACT_ID                            ;
    t_old_rec.SHIP_TO_SITE_USE_ID                      := :old.SHIP_TO_SITE_USE_ID                           ;
    t_old_rec.SHIPMENT_ID                              := :old.SHIPMENT_ID                                   ;
    t_old_rec.REMIT_TO_ADDRESS_ID                      := :old.REMIT_TO_ADDRESS_ID                           ;
    t_old_rec.TERM_ID                                  := :old.TERM_ID                                       ;
    t_old_rec.TERM_DUE_DATE                            := :old.TERM_DUE_DATE                                 ;
    t_old_rec.PREVIOUS_CUSTOMER_TRX_ID                 := :old.PREVIOUS_CUSTOMER_TRX_ID                      ;
    t_old_rec.PRIMARY_SALESREP_ID                      := :old.PRIMARY_SALESREP_ID                           ;
    t_old_rec.PRINTING_ORIGINAL_DATE                   := :old.PRINTING_ORIGINAL_DATE                        ;
    t_old_rec.PRINTING_LAST_PRINTED                    := :old.PRINTING_LAST_PRINTED                         ;
    t_old_rec.PRINTING_OPTION                          := :old.PRINTING_OPTION                               ;
    t_old_rec.PRINTING_COUNT                           := :old.PRINTING_COUNT                                ;
    t_old_rec.PRINTING_PENDING                         := :old.PRINTING_PENDING                              ;
    t_old_rec.PURCHASE_ORDER                           := :old.PURCHASE_ORDER                                ;
    t_old_rec.PURCHASE_ORDER_REVISION                  := :old.PURCHASE_ORDER_REVISION                       ;
    t_old_rec.PURCHASE_ORDER_DATE                      := :old.PURCHASE_ORDER_DATE                           ;
    t_old_rec.CUSTOMER_REFERENCE                       := :old.CUSTOMER_REFERENCE                            ;
    t_old_rec.CUSTOMER_REFERENCE_DATE                  := :old.CUSTOMER_REFERENCE_DATE                       ;
    t_old_rec.COMMENTS                                 := :old.COMMENTS                                      ;
    t_old_rec.INTERNAL_NOTES                           := :old.INTERNAL_NOTES                                ;
    t_old_rec.EXCHANGE_RATE_TYPE                       := :old.EXCHANGE_RATE_TYPE                            ;
    t_old_rec.EXCHANGE_DATE                            := :old.EXCHANGE_DATE                                 ;
    t_old_rec.EXCHANGE_RATE                            := :old.EXCHANGE_RATE                                 ;
    t_old_rec.TERRITORY_ID                             := :old.TERRITORY_ID                                  ;
    t_old_rec.INVOICE_CURRENCY_CODE                    := :old.INVOICE_CURRENCY_CODE                         ;
    t_old_rec.INITIAL_CUSTOMER_TRX_ID                  := :old.INITIAL_CUSTOMER_TRX_ID                       ;
    t_old_rec.AGREEMENT_ID                             := :old.AGREEMENT_ID                                  ;
    t_old_rec.END_DATE_COMMITMENT                      := :old.END_DATE_COMMITMENT                           ;
    t_old_rec.START_DATE_COMMITMENT                    := :old.START_DATE_COMMITMENT                         ;
    t_old_rec.LAST_PRINTED_SEQUENCE_NUM                := :old.LAST_PRINTED_SEQUENCE_NUM                     ;
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
    t_old_rec.ORIG_SYSTEM_BATCH_NAME                   := :old.ORIG_SYSTEM_BATCH_NAME                        ;
    t_old_rec.POST_REQUEST_ID                          := :old.POST_REQUEST_ID                               ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.FINANCE_CHARGES                          := :old.FINANCE_CHARGES                               ;
    t_old_rec.COMPLETE_FLAG                            := :old.COMPLETE_FLAG                                 ;
    t_old_rec.POSTING_CONTROL_ID                       := :old.POSTING_CONTROL_ID                            ;
    t_old_rec.BILL_TO_ADDRESS_ID                       := :old.BILL_TO_ADDRESS_ID                            ;
    t_old_rec.RA_POST_LOOP_NUMBER                      := :old.RA_POST_LOOP_NUMBER                           ;
    t_old_rec.SHIP_TO_ADDRESS_ID                       := :old.SHIP_TO_ADDRESS_ID                            ;
    t_old_rec.CREDIT_METHOD_FOR_RULES                  := :old.CREDIT_METHOD_FOR_RULES                       ;
    t_old_rec.CREDIT_METHOD_FOR_INSTALLMENTS           := :old.CREDIT_METHOD_FOR_INSTALLMENTS                ;
    t_old_rec.RECEIPT_METHOD_ID                        := :old.RECEIPT_METHOD_ID                             ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.RELATED_CUSTOMER_TRX_ID                  := :old.RELATED_CUSTOMER_TRX_ID                       ;
    t_old_rec.INVOICING_RULE_ID                        := :old.INVOICING_RULE_ID                             ;
    t_old_rec.SHIP_VIA                                 := :old.SHIP_VIA                                      ;
    t_old_rec.SHIP_DATE_ACTUAL                         := :old.SHIP_DATE_ACTUAL                              ;
    t_old_rec.WAYBILL_NUMBER                           := :old.WAYBILL_NUMBER                                ;
    t_old_rec.FOB_POINT                                := :old.FOB_POINT                                     ;
    t_old_rec.CUSTOMER_BANK_ACCOUNT_ID                 := :old.CUSTOMER_BANK_ACCOUNT_ID                      ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE1              := :old.INTERFACE_HEADER_ATTRIBUTE1                   ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE2              := :old.INTERFACE_HEADER_ATTRIBUTE2                   ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE3              := :old.INTERFACE_HEADER_ATTRIBUTE3                   ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE4              := :old.INTERFACE_HEADER_ATTRIBUTE4                   ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE5              := :old.INTERFACE_HEADER_ATTRIBUTE5                   ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE6              := :old.INTERFACE_HEADER_ATTRIBUTE6                   ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE7              := :old.INTERFACE_HEADER_ATTRIBUTE7                   ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE8              := :old.INTERFACE_HEADER_ATTRIBUTE8                   ;
    t_old_rec.INTERFACE_HEADER_CONTEXT                 := :old.INTERFACE_HEADER_CONTEXT                      ;
    t_old_rec.DEFAULT_USSGL_TRX_CODE_CONTEXT           := :old.DEFAULT_USSGL_TRX_CODE_CONTEXT                ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE10             := :old.INTERFACE_HEADER_ATTRIBUTE10                  ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE11             := :old.INTERFACE_HEADER_ATTRIBUTE11                  ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE12             := :old.INTERFACE_HEADER_ATTRIBUTE12                  ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE13             := :old.INTERFACE_HEADER_ATTRIBUTE13                  ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE14             := :old.INTERFACE_HEADER_ATTRIBUTE14                  ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE15             := :old.INTERFACE_HEADER_ATTRIBUTE15                  ;
    t_old_rec.INTERFACE_HEADER_ATTRIBUTE9              := :old.INTERFACE_HEADER_ATTRIBUTE9                   ;
    t_old_rec.DEFAULT_USSGL_TRANSACTION_CODE           := :old.DEFAULT_USSGL_TRANSACTION_CODE                ;
    t_old_rec.RECURRED_FROM_TRX_NUMBER                 := :old.RECURRED_FROM_TRX_NUMBER                      ;
    t_old_rec.STATUS_TRX                               := :old.STATUS_TRX                                    ;
    t_old_rec.DOC_SEQUENCE_ID                          := :old.DOC_SEQUENCE_ID                               ;
    t_old_rec.DOC_SEQUENCE_VALUE                       := :old.DOC_SEQUENCE_VALUE                            ;
    t_old_rec.PAYING_CUSTOMER_ID                       := :old.PAYING_CUSTOMER_ID                            ;
    t_old_rec.PAYING_SITE_USE_ID                       := :old.PAYING_SITE_USE_ID                            ;
    t_old_rec.RELATED_BATCH_SOURCE_ID                  := :old.RELATED_BATCH_SOURCE_ID                       ;
    t_old_rec.DEFAULT_TAX_EXEMPT_FLAG                  := :old.DEFAULT_TAX_EXEMPT_FLAG                       ;
    t_old_rec.CREATED_FROM                             := :old.CREATED_FROM                                  ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.WH_UPDATE_DATE                           := :old.WH_UPDATE_DATE                                ;
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
    t_old_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :old.GLOBAL_ATTRIBUTE_CATEGORY                     ;
    t_old_rec.EDI_PROCESSED_FLAG                       := :old.EDI_PROCESSED_FLAG                            ;
    t_old_rec.EDI_PROCESSED_STATUS                     := :old.EDI_PROCESSED_STATUS                          ;
    t_old_rec.GLOBAL_ATTRIBUTE21                       := :old.GLOBAL_ATTRIBUTE21                            ;
    t_old_rec.GLOBAL_ATTRIBUTE22                       := :old.GLOBAL_ATTRIBUTE22                            ;
    t_old_rec.GLOBAL_ATTRIBUTE23                       := :old.GLOBAL_ATTRIBUTE23                            ;
    t_old_rec.GLOBAL_ATTRIBUTE24                       := :old.GLOBAL_ATTRIBUTE24                            ;
    t_old_rec.GLOBAL_ATTRIBUTE25                       := :old.GLOBAL_ATTRIBUTE25                            ;
    t_old_rec.GLOBAL_ATTRIBUTE26                       := :old.GLOBAL_ATTRIBUTE26                            ;
    t_old_rec.GLOBAL_ATTRIBUTE27                       := :old.GLOBAL_ATTRIBUTE27                            ;
    t_old_rec.GLOBAL_ATTRIBUTE28                       := :old.GLOBAL_ATTRIBUTE28                            ;
    t_old_rec.GLOBAL_ATTRIBUTE29                       := :old.GLOBAL_ATTRIBUTE29                            ;
    t_old_rec.GLOBAL_ATTRIBUTE30                       := :old.GLOBAL_ATTRIBUTE30                            ;
    t_old_rec.MRC_EXCHANGE_RATE_TYPE                   := :old.MRC_EXCHANGE_RATE_TYPE                        ;
    t_old_rec.MRC_EXCHANGE_DATE                        := :old.MRC_EXCHANGE_DATE                             ;
    t_old_rec.MRC_EXCHANGE_RATE                        := :old.MRC_EXCHANGE_RATE                             ;
    t_old_rec.PAYMENT_SERVER_ORDER_NUM                 := :old.PAYMENT_SERVER_ORDER_NUM                      ;
    t_old_rec.APPROVAL_CODE                            := :old.APPROVAL_CODE                                 ;
    t_old_rec.ADDRESS_VERIFICATION_CODE                := :old.ADDRESS_VERIFICATION_CODE                     ;
    t_old_rec.OLD_TRX_NUMBER                           := :old.OLD_TRX_NUMBER                                ;
    t_old_rec.BR_AMOUNT                                := :old.BR_AMOUNT                                     ;
    t_old_rec.BR_UNPAID_FLAG                           := :old.BR_UNPAID_FLAG                                ;
    t_old_rec.BR_ON_HOLD_FLAG                          := :old.BR_ON_HOLD_FLAG                               ;
    t_old_rec.DRAWEE_ID                                := :old.DRAWEE_ID                                     ;
    t_old_rec.DRAWEE_CONTACT_ID                        := :old.DRAWEE_CONTACT_ID                             ;
    t_old_rec.DRAWEE_SITE_USE_ID                       := :old.DRAWEE_SITE_USE_ID                            ;
    t_old_rec.REMITTANCE_BANK_ACCOUNT_ID               := :old.REMITTANCE_BANK_ACCOUNT_ID                    ;
    t_old_rec.OVERRIDE_REMIT_ACCOUNT_FLAG              := :old.OVERRIDE_REMIT_ACCOUNT_FLAG                   ;
    t_old_rec.DRAWEE_BANK_ACCOUNT_ID                   := :old.DRAWEE_BANK_ACCOUNT_ID                        ;
    t_old_rec.SPECIAL_INSTRUCTIONS                     := :old.SPECIAL_INSTRUCTIONS                          ;
    t_old_rec.REMITTANCE_BATCH_ID                      := :old.REMITTANCE_BATCH_ID                           ;
    t_old_rec.PREPAYMENT_FLAG                          := :old.PREPAYMENT_FLAG                               ;
    t_old_rec.CT_REFERENCE                             := :old.CT_REFERENCE                                  ;
    t_old_rec.CONTRACT_ID                              := :old.CONTRACT_ID                                   ;
    t_old_rec.BILL_TEMPLATE_ID                         := :old.BILL_TEMPLATE_ID                              ;
    t_old_rec.REVERSED_CASH_RECEIPT_ID                 := :old.REVERSED_CASH_RECEIPT_ID                      ;
    t_old_rec.CC_ERROR_CODE                            := :old.CC_ERROR_CODE                                 ;
    t_old_rec.CC_ERROR_TEXT                            := :old.CC_ERROR_TEXT                                 ;
    t_old_rec.CC_ERROR_FLAG                            := :old.CC_ERROR_FLAG                                 ;
    t_old_rec.UPGRADE_METHOD                           := :old.UPGRADE_METHOD                                ;
    t_old_rec.LEGAL_ENTITY_ID                          := :old.LEGAL_ENTITY_ID                               ;
    t_old_rec.REMIT_BANK_ACCT_USE_ID                   := :old.REMIT_BANK_ACCT_USE_ID                        ;
    t_old_rec.PAYMENT_TRXN_EXTENSION_ID                := :old.PAYMENT_TRXN_EXTENSION_ID                     ;
    t_old_rec.AX_ACCOUNTED_FLAG                        := :old.AX_ACCOUNTED_FLAG                             ;
    t_old_rec.APPLICATION_ID                           := :old.APPLICATION_ID                                ;
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
  --added the following IF block for bug#7450481
  IF Inserting OR updating THEN
    IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AR_RCTA_ARIUD_T1', p_set_of_books_id => :new.set_of_books_id ) = FALSE THEN
         RETURN;
    END IF;
  ELSIF deleting THEN
    IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AR_RCTA_ARIUD_T1', p_set_of_books_id => :old.set_of_books_id ) = FALSE THEN
         RETURN;
    END IF;
  END IF;
  --bug#7450481 , end

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

    IF ( :NEW.CREATED_FROM <> 'RAXTRX' ) THEN

      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log', :NEW.CREATED_FROM || '<> ''RAXTRX''');

      JAI_AR_RCTA_TRIGGER_PKG.ARI_T1 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );
      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log', lv_return_code ||', ' || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;

    END IF ;

  END IF ;

  IF UPDATING THEN

    IF ( :NEW.complete_flag = 'Y' ) THEN

      JAI_AR_RCTA_TRIGGER_PKG.ARU_T1 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );

      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log', 'ARU_T1: '||lv_return_code ||', ' || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;

    END IF ;

    IF ((:NEW.TRX_NUMBER <> :OLD.TRX_NUMBER) OR (:NEW.CUSTOMER_TRX_ID <> :OLD.CUSTOMER_TRX_ID)) THEN

      JAI_AR_RCTA_TRIGGER_PKG.ARU_T2 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );
      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log', 'ARU_T2:'||lv_return_code ||', ' || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;

    END IF ;

    IF ( :NEW.COMPLETE_FLAG = 'Y' AND NVL(:NEW.CREATED_FROM,'###') IN ('ARXTWMAI','ARXTWCMI') ) THEN

      JAI_AR_RCTA_TRIGGER_PKG.ARU_T3 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );
       jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log','ARU_T3:'||  lv_return_code ||', ' || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      -- Added by Jia Li for tax inclusive computation on 2007/12/01, Begin
      ----------------------------------------------------------------------
      ELSE
      IF ( :NEW.COMPLETE_FLAG = 'Y' AND :OLD.COMPLETE_FLAG = 'N' AND NVL(:NEW.CREATED_FROM,'###') IN ('ARXTWMAI','ARXTWCMI') ) THEN --Added by JMEENA for bug#8451356
      /*Below code is added to check if the invoice is standard AR invoice or created through IL transaction form.
      in case of standard AR Invoice without IL, accounting for inclusive taxes should not happen.
      Added by JMEENA for bug#8864023
      */
	OPEN organization_id_check(:new.CUSTOMER_TRX_ID);
	FETCH organization_id_check INTO v_organization_id;
	CLOSE organization_id_check;

	IF v_organization_id <> -1 THEN --Added for bug#8864023
		-- Check if inclusive taxes needs to be accounted separately
		OPEN inclu_flag_cur;
		FETCH inclu_flag_cur INTO lv_inclu_tax_flag;
		CLOSE inclu_flag_cur;

        IF lv_inclu_tax_flag = 'Y'
        THEN
          jai_ar_match_tax_pkg.acct_inclu_taxes( pn_customer_trx_id  => t_new_rec.customer_trx_id
                                               , pn_org_id           => t_new_rec.org_id
                                               , pn_cust_trx_type_id => t_new_rec.cust_trx_type_id
                                               , xv_process_flag     => lv_return_code
                                               , xv_process_message  => lv_return_message);

          IF lv_return_code <> jai_constants.successful
          THEN
            RAISE le_error;
          END IF;  -- lv_return_code <> jai_constants.successful

        END IF;  --lv_inclu_tax_flag = 'Y'
	END IF; -- v_organization_id <> -1
	END IF; --End of 8451356
      -----------------------------------------------------------------------
      -- Added by Jia Li for tax inclusive computation on 2007/12/01, End
      END IF;

    END IF ;

    IF ( :NEW.COMPLETE_FLAG = 'Y' ) THEN

      JAI_AR_RCTA_TRIGGER_PKG.ARU_T4 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );
      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log', 'ARU_T4:'||lv_return_code ||', ' || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;

      --Added by Bo Li for VAT/Excise Number shown in AR transaction workbench on 19-Jan-2010 and In Bug 9303168,Begin
      -----------------------------------------------------------------------------------------------
         -- set the mode of concurrent so that it can be used in trigger
        lb_return_mode:= fnd_request.set_mode(TRUE);

        -- get the excise invoice number
        OPEN  get_excise_inv_no_cur(:NEW.CUSTOMER_TRX_ID);
        FETCH get_excise_inv_no_cur
        INTO  lv_excise_inv_no;
        CLOSE get_excise_inv_no_cur;

        -- get the vat invoice number
        OPEN  get_vat_inv_no_cur(:NEW.CUSTOMER_TRX_ID);
        FETCH get_vat_inv_no_cur
        INTO  lv_vat_inv_no;
        CLOSE get_vat_inv_no_cur;

       IF (lb_return_mode AND :NEW.CREATED_FROM = 'ARXTWMAI'
         AND ((lv_excise_inv_no IS NOT NULL AND instr(nvl(:NEW.CT_REFERENCE,'$$'),lv_excise_inv_no)=0)
              OR (lv_vat_inv_no IS NOT NULL AND instr(nvl(:NEW.CT_REFERENCE,'$$'),lv_vat_inv_no)=0)))
       THEN

          --Added by Bo Li for Bug9490173 on 05-May-2010 ,Begin
          -------------------------------------------------------------------------
             OPEN  get_max_request_id_cur(:NEW.CUSTOMER_TRX_ID);
  					 FETCH get_max_request_id_cur
  					  INTO ln_max_req_id;
             CLOSE get_max_request_id_cur;

            IF ( ln_max_req_id <> -1)
            THEN
            lb_call_status :=FND_CONCURRENT.GET_REQUEST_STATUS(request_id     =>ln_max_req_id,
                                                               appl_shortname =>'JA',
                                                               program        =>cv_process_program,
                                                               phase          =>lv_rphase,
                                                               status         =>lv_rstatus,
                                                               dev_phase      =>lv_dphase,
                                                               dev_status     =>lv_dstatus,
                                                               message        =>lv_message);



            IF lv_dphase = 'COMPLETE'
            THEN
             -- The concurrent program will call the jai_ar_trx.update_reference procedure
             -- to update the reference field.
            ln_request_id := fnd_request.submit_request( application => 'JA'
                                                     , program     => cv_process_program
                                                     , description => ''
                                                     , start_time  => ''
                                                     , sub_request => FALSE
                                                     , argument1   => :new.customer_trx_id
                                                     );
              IF ln_request_id < 0
              THEN
                RAISE le_error;
              END IF;--ln_request_id < 0
            END IF;
          ELSE
            -- The concurrent program will call the jai_ar_trx.update_reference procedure
            -- to update the reference field.
            ln_request_id := fnd_request.submit_request( application => 'JA'
                                                       , program     => cv_process_program
                                                       , description => ''
                                                       , start_time  => ''
                                                       , sub_request => FALSE
                                                       , argument1   => :new.customer_trx_id
                                                       );
            IF ln_request_id < 0
            THEN
              RAISE le_error;
            END IF;--ln_request_id < 0
          END IF;
       -------------------------------------------------------------------------
       --Added by Bo Li for Bug9490173 on 05-May-2010 ,End
       END IF; --lb_return_mode
      -----------------------------------------------------------------------------------------------
      --Added by Bo Li for VAT/Excise Number shown in AR transaction workbench on 19-Jan-2010 and In Bug 9303168,End

    END IF ;

    IF ( NVL(:NEW.COMPLETE_FLAG,'$') ='N' AND :NEW.TRX_DATE <> :OLD.TRX_DATE ) THEN

      JAI_AR_RCTA_TRIGGER_PKG.ARU_T5 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );

      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log', 'ARU_T5:'||lv_return_code ||', ' || lv_return_message);

      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;

    END IF ;

    IF ( (NVL(:NEW.Ship_To_Customer_ID,0) <> NVL(:OLD.Ship_To_Customer_ID,0)) OR (NVL(:NEW.Ship_To_Site_Use_ID,0) <>  NVL(:OLD.Ship_To_Site_Use_ID,0)) OR :NEW.invoice_currency_code <> :OLD.invoice_currency_code ) THEN

      JAI_AR_RCTA_TRIGGER_PKG.ARU_T6 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );
      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log','ARU_T6:'|| lv_return_code ||', ' || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
              RAISE le_error;
      END IF;

    END IF ;

-- Added by sacsethi for bug 5631784 on 01-02-2007
-- Start 5631784
    IF    ( NVL(:OLD.COMPLETE_FLAG,'N') = 'N' AND NVL(:NEW.COMPLETE_FLAG,'$') ='Y' ) -- COMPLETION
       OR ( NVL(:OLD.COMPLETE_FLAG,'N') = 'Y' AND NVL(:NEW.COMPLETE_FLAG,'$') ='N' ) -- INCOMPLETION
    THEN
      JAI_AR_RCTA_TRIGGER_PKG.ARU_T7 (
          pr_old            =>  t_old_rec         ,
          pr_new            =>  t_new_rec         ,
          pv_action         =>  lv_action         ,
          pv_return_code    =>  lv_return_code    ,
          pv_return_message =>  lv_return_message
                    );
      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log','ARU_T7:'|| lv_return_code ||', ' || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
              RAISE le_error;
      END IF;
    END IF ;
-- End 5631784
  END IF ;

  --Added by Bo Li for the VAT non-shippable for Bug9666476 on 2010-4-28 Begin
    -------------------------------------------------------------------------
    IF ( :NEW.complete_flag = 'Y' ) THEN

      JAI_AR_RCTA_TRIGGER_PKG.ARU_T8 (
                        pr_old            =>  t_old_rec         ,
                        pr_new            =>  t_new_rec         ,
                        pv_action         =>  lv_action         ,
                        pv_return_code    =>  lv_return_code    ,
                        pv_return_message =>  lv_return_message
                      );

      jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log', 'ARU_T8: '
                                   ||lv_return_code ||', '
                                   || lv_return_message);
      IF lv_return_code <> jai_constants.successful   then
             RAISE le_error;
      END IF;
    END IF ;
    -------------------------------------------------------------------------
    --Added by Bo Li for the VAT non-shippable for Bug9666476 on 2010-4-28 End

  --added the following IF block for bug#7450481
  IF DELETING THEN

    JAI_AR_RCTA_TRIGGER_PKG.ARD_T1 (
                      pr_old            =>  t_old_rec         ,
                      pv_action         =>  lv_action         ,
                      pv_return_code    =>  lv_return_code    ,
                      pv_return_message =>  lv_return_message
                    );
    jai_cmn_utils_pkg.print_log ('jai_ar_rcta.log','ARD_T1: '|| lv_return_code ||', ' || lv_return_message);
    IF lv_return_code <> jai_constants.successful   then
           RAISE le_error;
    END IF;
  END IF;

EXCEPTION
   --
   -- Bug: 6156051
   -- In 11i code, the app_exception.raise_exception was displaying the message on the front-end, however on R12, the ARXTWMAI
   -- form is not showing this kind of message and it reads message stack for any error.  Hence to show a message on the front-end
   -- message stack must be pushed with proper error message which will be read by form's ON-ERROR trigger
   --
  WHEN le_error THEN
     -- BUG 6156051
     fnd_message.set_name ('JA','JAI_GENERIC_MSG');
     fnd_message.set_token ('MSG_TEXT', lv_return_message);
     -- End 6156051

     app_exception.raise_exception (
                                     EXCEPTION_TYPE  => 'APP'  ,
                                     EXCEPTION_CODE  => -20001 ,
                                     EXCEPTION_TEXT  => lv_return_message
                                   );

  WHEN OTHERS THEN
     -- BUG 6156051
     fnd_message.set_name ('JA','JAI_GENERIC_MSG');
     fnd_message.set_token ('MSG_TEXT', 'Encountered the error in trigger JAI_AR_RCTA_ARIUD_T1' || substr(sqlerrm,1,1900));
     -- End 6156051
     app_exception.raise_exception (
                                      EXCEPTION_TYPE  => 'APP',
                                      EXCEPTION_CODE  => -20001 ,
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AR_RCTA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AR_RCTA_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_AR_RCTA_ARIUD_T1" DISABLE;
