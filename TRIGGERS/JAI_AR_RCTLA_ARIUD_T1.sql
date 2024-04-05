--------------------------------------------------------
--  DDL for Trigger JAI_AR_RCTLA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_AR_RCTLA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "AR"."RA_CUSTOMER_TRX_LINES_ALL"
/* $Header: jai_ar_rctla_t.sql 120.10.12010000.8 2009/07/16 13:03:41 vkaranam ship $ */
FOR EACH ROW
DECLARE

/*------------------------------------------------------------------------------------------
   FILENAME: jai_ar_rctla_t.sql

   CHANGE HISTORY:
   S.No      Date          Author and Details
    1    28/02/2007    bduvarag for the bug#4694648
                       Forward porting the changes for the 11i bug#4643879

    2    24/04/1005    cbabu for bug#6012570 (5876390) Version: 120.6
                       Projects Billing Enh.
                       forward ported from R11i to R12
    3.   14/05/2007    bduvarag for bug 5879769 File Version 120.8
                       Removed the Project Billing Code
    4.   8/17/2007     brathod, cbabu for bug#6012570 (5876390) Version: 120.10
                       Redone changes for Projects Billing Enh.

    5.   11-10-07      JMEENA for bug# 6493501. File Version 120.4.12000000.4
                       Issue:  AUTOINVOICE PROGRAM GOING IN ERROR
                       Reason: IL doesn't processes the data which is being imported into Receivables,
                              if interface_line_context is any of the following :-
                              ('PROJECTS INVOICES', 'OKS CONTRACTS','LEGACY', 'Property-Projects','CLAIM')
                       Fix:   Trigger jai_ractl_ariud_trg.
                              IL sucessfully processes the data which is being imported into Receivables,
                              if interface_line_context is any of the following:-
                                ('ORDER ENTRY',  'SUPPLEMENT CM',  'SUPPLEMENT DM',  'SUPPLEMENT INVOICE',
                                 'TCS Debit Memo',  'TCS Credit Memo' )
                                  and interface_header_context is any of the following
                                 ('PROJECTS INVOICES',   'PA INVOICES') --'PA INTERNAL INVOICES'
                              (jai_ractl_trg_pkg) Function is_this_projects_context:
                                   Commented 'PA INTERNAL INVOICES' for bug# 6493501
                                   It can be used to support interproject or intercompany billing in future

    6.   07-/11/2008   CSahoo for bug#7450481, File Version 120.4.12000000.5
                       Issue : AUTOINVOICE IMPORT PROGRAM ENDING IN ERROR FOR BILL ONLY ORDERS
                       FIX: Added a IF condition in the code so that in case of inserting and updating
                            it picks :new.org_id and in case of deleting it picks :old.org_id

7. 18-Nov-2008    JMEENA for bug#6414523 (FP 6318850)
			Issue:  PROBLEM IN A.R. TRANSACTION LOCALISED SUMMARY SCREEN
			Reason: Invoice is created without Item name but description , qty, rate are provided. Once the qty / rate is modified, recalculation is not happening
			Fix:    Added  condition in IF UPDATING - OR :old.inventory_item_id is null.

8. 20-Nov-2008  JMEENA for bug#6391684( FP of 6386592)
			Added fnd_log messages in the exception to report the interface attributes in autoinvoice log file

9. 12-Dec-2008	JMEENA for bug#7636411
			Issue: TAXES NOT FLOWING TO RECEIVABLES FROM PROJECTS
			Fix:	Added PROJECTS INVOICES and PA INVOICES in the condition which checks the interface_line_context
				suppoerted by India Localization.
10. 16-jul-2009 vkaranam for bug#8671242
                Issue:
		Supplimentary Invoice/CM has been created with 0 value .
		Fix:
		Added "INDIA INVOICES" in the condition which checks the interface_line_context
	        supported by India Localization.


---------------------------------------------------------------------------------------- */




  t_old_rec             RA_CUSTOMER_TRX_LINES_ALL%rowtype ;
  t_new_rec             RA_CUSTOMER_TRX_LINES_ALL%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;
  lb_debug              boolean;
  lv_object             varchar2 (100) ; /* bug#6012570 (5876390) modified the size from 61 to 100 */


  -- Bug 6109941, Brathod
  CURSOR cur_get_created_from ( cp_customer_trx_id RA_CUSTOMER_TRX_ALL.CUSTOMER_TRX_ID%TYPE )
  IS
  SELECT
        '1'
  FROM
        ra_customer_trx_all
  WHERE
        customer_trx_id = cp_customer_trx_id
  AND   created_from    = jai_constants.created_fr_ar_invoice_api; /* 'AR_INVOICE_API'     */

  ln_exists  NUMBER(2) ;




  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.CUSTOMER_TRX_LINE_ID                     := :new.CUSTOMER_TRX_LINE_ID                          ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CUSTOMER_TRX_ID                          := :new.CUSTOMER_TRX_ID                               ;
    t_new_rec.LINE_NUMBER                              := :new.LINE_NUMBER                                   ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.REASON_CODE                              := :new.REASON_CODE                                   ;
    t_new_rec.INVENTORY_ITEM_ID                        := :new.INVENTORY_ITEM_ID                             ;
    t_new_rec.DESCRIPTION                              := :new.DESCRIPTION                                   ;
    t_new_rec.PREVIOUS_CUSTOMER_TRX_ID                 := :new.PREVIOUS_CUSTOMER_TRX_ID                      ;
    t_new_rec.PREVIOUS_CUSTOMER_TRX_LINE_ID            := :new.PREVIOUS_CUSTOMER_TRX_LINE_ID                 ;
    t_new_rec.QUANTITY_ORDERED                         := :new.QUANTITY_ORDERED                              ;
    t_new_rec.QUANTITY_CREDITED                        := :new.QUANTITY_CREDITED                             ;
    t_new_rec.QUANTITY_INVOICED                        := :new.QUANTITY_INVOICED                             ;
    t_new_rec.UNIT_STANDARD_PRICE                      := :new.UNIT_STANDARD_PRICE                           ;
    t_new_rec.UNIT_SELLING_PRICE                       := :new.UNIT_SELLING_PRICE                            ;
    t_new_rec.SALES_ORDER                              := :new.SALES_ORDER                                   ;
    t_new_rec.SALES_ORDER_REVISION                     := :new.SALES_ORDER_REVISION                          ;
    t_new_rec.SALES_ORDER_LINE                         := :new.SALES_ORDER_LINE                              ;
    t_new_rec.SALES_ORDER_DATE                         := :new.SALES_ORDER_DATE                              ;
    t_new_rec.ACCOUNTING_RULE_ID                       := :new.ACCOUNTING_RULE_ID                            ;
    t_new_rec.ACCOUNTING_RULE_DURATION                 := :new.ACCOUNTING_RULE_DURATION                      ;
    t_new_rec.LINE_TYPE                                := :new.LINE_TYPE                                     ;
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
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.RULE_START_DATE                          := :new.RULE_START_DATE                               ;
    t_new_rec.INITIAL_CUSTOMER_TRX_LINE_ID             := :new.INITIAL_CUSTOMER_TRX_LINE_ID                  ;
    t_new_rec.INTERFACE_LINE_CONTEXT                   := :new.INTERFACE_LINE_CONTEXT                        ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE1                := :new.INTERFACE_LINE_ATTRIBUTE1                     ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE2                := :new.INTERFACE_LINE_ATTRIBUTE2                     ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE3                := :new.INTERFACE_LINE_ATTRIBUTE3                     ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE4                := :new.INTERFACE_LINE_ATTRIBUTE4                     ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE5                := :new.INTERFACE_LINE_ATTRIBUTE5                     ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE6                := :new.INTERFACE_LINE_ATTRIBUTE6                     ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE7                := :new.INTERFACE_LINE_ATTRIBUTE7                     ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE8                := :new.INTERFACE_LINE_ATTRIBUTE8                     ;
    t_new_rec.SALES_ORDER_SOURCE                       := :new.SALES_ORDER_SOURCE                            ;
    t_new_rec.TAXABLE_FLAG                             := :new.TAXABLE_FLAG                                  ;
    t_new_rec.EXTENDED_AMOUNT                          := :new.EXTENDED_AMOUNT                               ;
    t_new_rec.REVENUE_AMOUNT                           := :new.REVENUE_AMOUNT                                ;
    t_new_rec.AUTORULE_COMPLETE_FLAG                   := :new.AUTORULE_COMPLETE_FLAG                        ;
    t_new_rec.LINK_TO_CUST_TRX_LINE_ID                 := :new.LINK_TO_CUST_TRX_LINE_ID                      ;
    t_new_rec.ATTRIBUTE11                              := :new.ATTRIBUTE11                                   ;
    t_new_rec.ATTRIBUTE12                              := :new.ATTRIBUTE12                                   ;
    t_new_rec.ATTRIBUTE13                              := :new.ATTRIBUTE13                                   ;
    t_new_rec.ATTRIBUTE14                              := :new.ATTRIBUTE14                                   ;
    t_new_rec.ATTRIBUTE15                              := :new.ATTRIBUTE15                                   ;
    t_new_rec.TAX_PRECEDENCE                           := :new.TAX_PRECEDENCE                                ;
    t_new_rec.TAX_RATE                                 := :new.TAX_RATE                                      ;
    t_new_rec.ITEM_EXCEPTION_RATE_ID                   := :new.ITEM_EXCEPTION_RATE_ID                        ;
    t_new_rec.TAX_EXEMPTION_ID                         := :new.TAX_EXEMPTION_ID                              ;
    t_new_rec.MEMO_LINE_ID                             := :new.MEMO_LINE_ID                                  ;
    t_new_rec.AUTORULE_DURATION_PROCESSED              := :new.AUTORULE_DURATION_PROCESSED                   ;
    t_new_rec.UOM_CODE                                 := :new.UOM_CODE                                      ;
    t_new_rec.DEFAULT_USSGL_TRANSACTION_CODE           := :new.DEFAULT_USSGL_TRANSACTION_CODE                ;
    t_new_rec.DEFAULT_USSGL_TRX_CODE_CONTEXT           := :new.DEFAULT_USSGL_TRX_CODE_CONTEXT                ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE10               := :new.INTERFACE_LINE_ATTRIBUTE10                    ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE11               := :new.INTERFACE_LINE_ATTRIBUTE11                    ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE12               := :new.INTERFACE_LINE_ATTRIBUTE12                    ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE13               := :new.INTERFACE_LINE_ATTRIBUTE13                    ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE14               := :new.INTERFACE_LINE_ATTRIBUTE14                    ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE15               := :new.INTERFACE_LINE_ATTRIBUTE15                    ;
    t_new_rec.INTERFACE_LINE_ATTRIBUTE9                := :new.INTERFACE_LINE_ATTRIBUTE9                     ;
    t_new_rec.VAT_TAX_ID                               := :new.VAT_TAX_ID                                    ;
    t_new_rec.AUTOTAX                                  := :new.AUTOTAX                                       ;
    t_new_rec.LAST_PERIOD_TO_CREDIT                    := :new.LAST_PERIOD_TO_CREDIT                         ;
    t_new_rec.ITEM_CONTEXT                             := :new.ITEM_CONTEXT                                  ;
    t_new_rec.TAX_EXEMPT_FLAG                          := :new.TAX_EXEMPT_FLAG                               ;
    t_new_rec.TAX_EXEMPT_NUMBER                        := :new.TAX_EXEMPT_NUMBER                             ;
    t_new_rec.TAX_EXEMPT_REASON_CODE                   := :new.TAX_EXEMPT_REASON_CODE                        ;
    t_new_rec.TAX_VENDOR_RETURN_CODE                   := :new.TAX_VENDOR_RETURN_CODE                        ;
    t_new_rec.SALES_TAX_ID                             := :new.SALES_TAX_ID                                  ;
    t_new_rec.LOCATION_SEGMENT_ID                      := :new.LOCATION_SEGMENT_ID                           ;
    t_new_rec.MOVEMENT_ID                              := :new.MOVEMENT_ID                                   ;
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
    t_new_rec.GROSS_UNIT_SELLING_PRICE                 := :new.GROSS_UNIT_SELLING_PRICE                      ;
    t_new_rec.GROSS_EXTENDED_AMOUNT                    := :new.GROSS_EXTENDED_AMOUNT                         ;
    t_new_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :new.AMOUNT_INCLUDES_TAX_FLAG                      ;
    t_new_rec.TAXABLE_AMOUNT                           := :new.TAXABLE_AMOUNT                                ;
    t_new_rec.WAREHOUSE_ID                             := :new.WAREHOUSE_ID                                  ;
    t_new_rec.TRANSLATED_DESCRIPTION                   := :new.TRANSLATED_DESCRIPTION                        ;
    t_new_rec.EXTENDED_ACCTD_AMOUNT                    := :new.EXTENDED_ACCTD_AMOUNT                         ;
    t_new_rec.BR_REF_CUSTOMER_TRX_ID                   := :new.BR_REF_CUSTOMER_TRX_ID                        ;
    t_new_rec.BR_REF_PAYMENT_SCHEDULE_ID               := :new.BR_REF_PAYMENT_SCHEDULE_ID                    ;
    t_new_rec.BR_ADJUSTMENT_ID                         := :new.BR_ADJUSTMENT_ID                              ;
    t_new_rec.MRC_EXTENDED_ACCTD_AMOUNT                := :new.MRC_EXTENDED_ACCTD_AMOUNT                     ;
    t_new_rec.PAYMENT_SET_ID                           := :new.PAYMENT_SET_ID                                ;
    t_new_rec.CONTRACT_LINE_ID                         := :new.CONTRACT_LINE_ID                              ;
    t_new_rec.SOURCE_DATA_KEY1                         := :new.SOURCE_DATA_KEY1                              ;
    t_new_rec.SOURCE_DATA_KEY2                         := :new.SOURCE_DATA_KEY2                              ;
    t_new_rec.SOURCE_DATA_KEY3                         := :new.SOURCE_DATA_KEY3                              ;
    t_new_rec.SOURCE_DATA_KEY4                         := :new.SOURCE_DATA_KEY4                              ;
    t_new_rec.SOURCE_DATA_KEY5                         := :new.SOURCE_DATA_KEY5                              ;
    t_new_rec.INVOICED_LINE_ACCTG_LEVEL                := :new.INVOICED_LINE_ACCTG_LEVEL                     ;
    t_new_rec.OVERRIDE_AUTO_ACCOUNTING_FLAG            := :new.OVERRIDE_AUTO_ACCOUNTING_FLAG                 ;
    t_new_rec.SHIP_TO_CUSTOMER_ID                      := :new.SHIP_TO_CUSTOMER_ID                           ;
    t_new_rec.SHIP_TO_ADDRESS_ID                       := :new.SHIP_TO_ADDRESS_ID                            ;
    t_new_rec.SHIP_TO_SITE_USE_ID                      := :new.SHIP_TO_SITE_USE_ID                           ;
    t_new_rec.SHIP_TO_CONTACT_ID                       := :new.SHIP_TO_CONTACT_ID                            ;
    t_new_rec.HISTORICAL_FLAG                          := :new.HISTORICAL_FLAG                               ;
    t_new_rec.TAX_LINE_ID                              := :new.TAX_LINE_ID                                   ;
    t_new_rec.LINE_RECOVERABLE                         := :new.LINE_RECOVERABLE                              ;
    t_new_rec.TAX_RECOVERABLE                          := :new.TAX_RECOVERABLE                               ;
    t_new_rec.TAX_CLASSIFICATION_CODE                  := :new.TAX_CLASSIFICATION_CODE                       ;
    t_new_rec.AMOUNT_DUE_REMAINING                     := :new.AMOUNT_DUE_REMAINING                          ;
    t_new_rec.ACCTD_AMOUNT_DUE_REMAINING               := :new.ACCTD_AMOUNT_DUE_REMAINING                    ;
    t_new_rec.AMOUNT_DUE_ORIGINAL                      := :new.AMOUNT_DUE_ORIGINAL                           ;
    t_new_rec.ACCTD_AMOUNT_DUE_ORIGINAL                := :new.ACCTD_AMOUNT_DUE_ORIGINAL                     ;
    t_new_rec.CHRG_AMOUNT_REMAINING                    := :new.CHRG_AMOUNT_REMAINING                         ;
    t_new_rec.CHRG_ACCTD_AMOUNT_REMAINING              := :new.CHRG_ACCTD_AMOUNT_REMAINING                   ;
    t_new_rec.FRT_ADJ_REMAINING                        := :new.FRT_ADJ_REMAINING                             ;
    t_new_rec.FRT_ADJ_ACCTD_REMAINING                  := :new.FRT_ADJ_ACCTD_REMAINING                       ;
    t_new_rec.FRT_ED_AMOUNT                            := :new.FRT_ED_AMOUNT                                 ;
    t_new_rec.FRT_ED_ACCTD_AMOUNT                      := :new.FRT_ED_ACCTD_AMOUNT                           ;
    t_new_rec.FRT_UNED_AMOUNT                          := :new.FRT_UNED_AMOUNT                               ;
    t_new_rec.FRT_UNED_ACCTD_AMOUNT                    := :new.FRT_UNED_ACCTD_AMOUNT                         ;
    t_new_rec.DEFERRAL_EXCLUSION_FLAG                  := :new.DEFERRAL_EXCLUSION_FLAG                       ;
    t_new_rec.RULE_END_DATE                            := :new.RULE_END_DATE                                 ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.CUSTOMER_TRX_LINE_ID                     := :old.CUSTOMER_TRX_LINE_ID                          ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CUSTOMER_TRX_ID                          := :old.CUSTOMER_TRX_ID                               ;
    t_old_rec.LINE_NUMBER                              := :old.LINE_NUMBER                                   ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.REASON_CODE                              := :old.REASON_CODE                                   ;
    t_old_rec.INVENTORY_ITEM_ID                        := :old.INVENTORY_ITEM_ID                             ;
    t_old_rec.DESCRIPTION                              := :old.DESCRIPTION                                   ;
    t_old_rec.PREVIOUS_CUSTOMER_TRX_ID                 := :old.PREVIOUS_CUSTOMER_TRX_ID                      ;
    t_old_rec.PREVIOUS_CUSTOMER_TRX_LINE_ID            := :old.PREVIOUS_CUSTOMER_TRX_LINE_ID                 ;
    t_old_rec.QUANTITY_ORDERED                         := :old.QUANTITY_ORDERED                              ;
    t_old_rec.QUANTITY_CREDITED                        := :old.QUANTITY_CREDITED                             ;
    t_old_rec.QUANTITY_INVOICED                        := :old.QUANTITY_INVOICED                             ;
    t_old_rec.UNIT_STANDARD_PRICE                      := :old.UNIT_STANDARD_PRICE                           ;
    t_old_rec.UNIT_SELLING_PRICE                       := :old.UNIT_SELLING_PRICE                            ;
    t_old_rec.SALES_ORDER                              := :old.SALES_ORDER                                   ;
    t_old_rec.SALES_ORDER_REVISION                     := :old.SALES_ORDER_REVISION                          ;
    t_old_rec.SALES_ORDER_LINE                         := :old.SALES_ORDER_LINE                              ;
    t_old_rec.SALES_ORDER_DATE                         := :old.SALES_ORDER_DATE                              ;
    t_old_rec.ACCOUNTING_RULE_ID                       := :old.ACCOUNTING_RULE_ID                            ;
    t_old_rec.ACCOUNTING_RULE_DURATION                 := :old.ACCOUNTING_RULE_DURATION                      ;
    t_old_rec.LINE_TYPE                                := :old.LINE_TYPE                                     ;
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
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.RULE_START_DATE                          := :old.RULE_START_DATE                               ;
    t_old_rec.INITIAL_CUSTOMER_TRX_LINE_ID             := :old.INITIAL_CUSTOMER_TRX_LINE_ID                  ;
    t_old_rec.INTERFACE_LINE_CONTEXT                   := :old.INTERFACE_LINE_CONTEXT                        ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE1                := :old.INTERFACE_LINE_ATTRIBUTE1                     ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE2                := :old.INTERFACE_LINE_ATTRIBUTE2                     ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE3                := :old.INTERFACE_LINE_ATTRIBUTE3                     ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE4                := :old.INTERFACE_LINE_ATTRIBUTE4                     ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE5                := :old.INTERFACE_LINE_ATTRIBUTE5                     ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE6                := :old.INTERFACE_LINE_ATTRIBUTE6                     ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE7                := :old.INTERFACE_LINE_ATTRIBUTE7                     ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE8                := :old.INTERFACE_LINE_ATTRIBUTE8                     ;
    t_old_rec.SALES_ORDER_SOURCE                       := :old.SALES_ORDER_SOURCE                            ;
    t_old_rec.TAXABLE_FLAG                             := :old.TAXABLE_FLAG                                  ;
    t_old_rec.EXTENDED_AMOUNT                          := :old.EXTENDED_AMOUNT                               ;
    t_old_rec.REVENUE_AMOUNT                           := :old.REVENUE_AMOUNT                                ;
    t_old_rec.AUTORULE_COMPLETE_FLAG                   := :old.AUTORULE_COMPLETE_FLAG                        ;
    t_old_rec.LINK_TO_CUST_TRX_LINE_ID                 := :old.LINK_TO_CUST_TRX_LINE_ID                      ;
    t_old_rec.ATTRIBUTE11                              := :old.ATTRIBUTE11                                   ;
    t_old_rec.ATTRIBUTE12                              := :old.ATTRIBUTE12                                   ;
    t_old_rec.ATTRIBUTE13                              := :old.ATTRIBUTE13                                   ;
    t_old_rec.ATTRIBUTE14                              := :old.ATTRIBUTE14                                   ;
    t_old_rec.ATTRIBUTE15                              := :old.ATTRIBUTE15                                   ;
    t_old_rec.TAX_PRECEDENCE                           := :old.TAX_PRECEDENCE                                ;
    t_old_rec.TAX_RATE                                 := :old.TAX_RATE                                      ;
    t_old_rec.ITEM_EXCEPTION_RATE_ID                   := :old.ITEM_EXCEPTION_RATE_ID                        ;
    t_old_rec.TAX_EXEMPTION_ID                         := :old.TAX_EXEMPTION_ID                              ;
    t_old_rec.MEMO_LINE_ID                             := :old.MEMO_LINE_ID                                  ;
    t_old_rec.AUTORULE_DURATION_PROCESSED              := :old.AUTORULE_DURATION_PROCESSED                   ;
    t_old_rec.UOM_CODE                                 := :old.UOM_CODE                                      ;
    t_old_rec.DEFAULT_USSGL_TRANSACTION_CODE           := :old.DEFAULT_USSGL_TRANSACTION_CODE                ;
    t_old_rec.DEFAULT_USSGL_TRX_CODE_CONTEXT           := :old.DEFAULT_USSGL_TRX_CODE_CONTEXT                ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE10               := :old.INTERFACE_LINE_ATTRIBUTE10                    ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE11               := :old.INTERFACE_LINE_ATTRIBUTE11                    ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE12               := :old.INTERFACE_LINE_ATTRIBUTE12                    ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE13               := :old.INTERFACE_LINE_ATTRIBUTE13                    ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE14               := :old.INTERFACE_LINE_ATTRIBUTE14                    ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE15               := :old.INTERFACE_LINE_ATTRIBUTE15                    ;
    t_old_rec.INTERFACE_LINE_ATTRIBUTE9                := :old.INTERFACE_LINE_ATTRIBUTE9                     ;
    t_old_rec.VAT_TAX_ID                               := :old.VAT_TAX_ID                                    ;
    t_old_rec.AUTOTAX                                  := :old.AUTOTAX                                       ;
    t_old_rec.LAST_PERIOD_TO_CREDIT                    := :old.LAST_PERIOD_TO_CREDIT                         ;
    t_old_rec.ITEM_CONTEXT                             := :old.ITEM_CONTEXT                                  ;
    t_old_rec.TAX_EXEMPT_FLAG                          := :old.TAX_EXEMPT_FLAG                               ;
    t_old_rec.TAX_EXEMPT_NUMBER                        := :old.TAX_EXEMPT_NUMBER                             ;
    t_old_rec.TAX_EXEMPT_REASON_CODE                   := :old.TAX_EXEMPT_REASON_CODE                        ;
    t_old_rec.TAX_VENDOR_RETURN_CODE                   := :old.TAX_VENDOR_RETURN_CODE                        ;
    t_old_rec.SALES_TAX_ID                             := :old.SALES_TAX_ID                                  ;
    t_old_rec.LOCATION_SEGMENT_ID                      := :old.LOCATION_SEGMENT_ID                           ;
    t_old_rec.MOVEMENT_ID                              := :old.MOVEMENT_ID                                   ;
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
    t_old_rec.GROSS_UNIT_SELLING_PRICE                 := :old.GROSS_UNIT_SELLING_PRICE                      ;
    t_old_rec.GROSS_EXTENDED_AMOUNT                    := :old.GROSS_EXTENDED_AMOUNT                         ;
    t_old_rec.AMOUNT_INCLUDES_TAX_FLAG                 := :old.AMOUNT_INCLUDES_TAX_FLAG                      ;
    t_old_rec.TAXABLE_AMOUNT                           := :old.TAXABLE_AMOUNT                                ;
    t_old_rec.WAREHOUSE_ID                             := :old.WAREHOUSE_ID                                  ;
    t_old_rec.TRANSLATED_DESCRIPTION                   := :old.TRANSLATED_DESCRIPTION                        ;
    t_old_rec.EXTENDED_ACCTD_AMOUNT                    := :old.EXTENDED_ACCTD_AMOUNT                         ;
    t_old_rec.BR_REF_CUSTOMER_TRX_ID                   := :old.BR_REF_CUSTOMER_TRX_ID                        ;
    t_old_rec.BR_REF_PAYMENT_SCHEDULE_ID               := :old.BR_REF_PAYMENT_SCHEDULE_ID                    ;
    t_old_rec.BR_ADJUSTMENT_ID                         := :old.BR_ADJUSTMENT_ID                              ;
    t_old_rec.MRC_EXTENDED_ACCTD_AMOUNT                := :old.MRC_EXTENDED_ACCTD_AMOUNT                     ;
    t_old_rec.PAYMENT_SET_ID                           := :old.PAYMENT_SET_ID                                ;
    t_old_rec.CONTRACT_LINE_ID                         := :old.CONTRACT_LINE_ID                              ;
    t_old_rec.SOURCE_DATA_KEY1                         := :old.SOURCE_DATA_KEY1                              ;
    t_old_rec.SOURCE_DATA_KEY2                         := :old.SOURCE_DATA_KEY2                              ;
    t_old_rec.SOURCE_DATA_KEY3                         := :old.SOURCE_DATA_KEY3                              ;
    t_old_rec.SOURCE_DATA_KEY4                         := :old.SOURCE_DATA_KEY4                              ;
    t_old_rec.SOURCE_DATA_KEY5                         := :old.SOURCE_DATA_KEY5                              ;
    t_old_rec.INVOICED_LINE_ACCTG_LEVEL                := :old.INVOICED_LINE_ACCTG_LEVEL                     ;
    t_old_rec.OVERRIDE_AUTO_ACCOUNTING_FLAG            := :old.OVERRIDE_AUTO_ACCOUNTING_FLAG                 ;
    t_old_rec.SHIP_TO_CUSTOMER_ID                      := :old.SHIP_TO_CUSTOMER_ID                           ;
    t_old_rec.SHIP_TO_ADDRESS_ID                       := :old.SHIP_TO_ADDRESS_ID                            ;
    t_old_rec.SHIP_TO_SITE_USE_ID                      := :old.SHIP_TO_SITE_USE_ID                           ;
    t_old_rec.SHIP_TO_CONTACT_ID                       := :old.SHIP_TO_CONTACT_ID                            ;
    t_old_rec.HISTORICAL_FLAG                          := :old.HISTORICAL_FLAG                               ;
    t_old_rec.TAX_LINE_ID                              := :old.TAX_LINE_ID                                   ;
    t_old_rec.LINE_RECOVERABLE                         := :old.LINE_RECOVERABLE                              ;
    t_old_rec.TAX_RECOVERABLE                          := :old.TAX_RECOVERABLE                               ;
    t_old_rec.TAX_CLASSIFICATION_CODE                  := :old.TAX_CLASSIFICATION_CODE                       ;
    t_old_rec.AMOUNT_DUE_REMAINING                     := :old.AMOUNT_DUE_REMAINING                          ;
    t_old_rec.ACCTD_AMOUNT_DUE_REMAINING               := :old.ACCTD_AMOUNT_DUE_REMAINING                    ;
    t_old_rec.AMOUNT_DUE_ORIGINAL                      := :old.AMOUNT_DUE_ORIGINAL                           ;
    t_old_rec.ACCTD_AMOUNT_DUE_ORIGINAL                := :old.ACCTD_AMOUNT_DUE_ORIGINAL                     ;
    t_old_rec.CHRG_AMOUNT_REMAINING                    := :old.CHRG_AMOUNT_REMAINING                         ;
    t_old_rec.CHRG_ACCTD_AMOUNT_REMAINING              := :old.CHRG_ACCTD_AMOUNT_REMAINING                   ;
    t_old_rec.FRT_ADJ_REMAINING                        := :old.FRT_ADJ_REMAINING                             ;
    t_old_rec.FRT_ADJ_ACCTD_REMAINING                  := :old.FRT_ADJ_ACCTD_REMAINING                       ;
    t_old_rec.FRT_ED_AMOUNT                            := :old.FRT_ED_AMOUNT                                 ;
    t_old_rec.FRT_ED_ACCTD_AMOUNT                      := :old.FRT_ED_ACCTD_AMOUNT                           ;
    t_old_rec.FRT_UNED_AMOUNT                          := :old.FRT_UNED_AMOUNT                               ;
    t_old_rec.FRT_UNED_ACCTD_AMOUNT                    := :old.FRT_UNED_ACCTD_AMOUNT                         ;
    t_old_rec.DEFERRAL_EXCLUSION_FLAG                  := :old.DEFERRAL_EXCLUSION_FLAG                       ;
    t_old_rec.RULE_END_DATE                            := :old.RULE_END_DATE                                 ;
  END populate_old ;

BEGIN

  lb_debug := false;

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
    IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AR_RCTLA_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
         RETURN;
    END IF;
  ELSIF deleting THEN
    IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_AR_RCTLA_ARIUD_T1', P_ORG_ID => :old.org_id) = FALSE THEN
         RETURN;
    END IF;
  END IF;
  -- bug#7450481, end

 /* Added by JMEENA for bug# 6493501 */
  IF  t_new_rec.interface_line_context IS NOT NULL AND
      (t_new_rec.interface_line_context NOT IN ('ORDER ENTRY',
                                          'SUPPLEMENT CM',
                                          'SUPPLEMENT DM',
                                          'SUPPLEMENT INVOICE',
                                          'TCS Debit Memo',
                                         'TCS Credit Memo','PROJECTS INVOICES','PA INVOICES' ,'INDIA INVOICES')) THEN
                                          --Added PROJECTS INVOICES and PA INVOICES in the condition for bug#7636411 by JMEENA
					  --added INDIA INVOICES for bug#8671242
return ;
   END IF ;

--End Bug# 6493501

  -- Bug 6109941, brathod , fwd porting for 4742259
  OPEN   cur_get_created_from(  cp_customer_trx_id =>  :new.customer_trx_id  );
  FETCH  cur_get_created_from INTO ln_exists;
  IF CUR_GET_CREATED_FROM%FOUND THEN
    CLOSE  cur_get_created_from ;
    return;
  END IF;
  CLOSE  cur_get_created_from ;
  -- End Bug 6109941

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

     /* Start bug#6012570 (5876390) */
    if :new.line_type = 'LINE'
      and JAI_AR_RCTLA_TRIGGER_PKG.is_this_projects_context(:new.interface_line_context)
    then
      lv_object := 'jai_ar_rctla_trigger_pkg.is_this_projects_context(||'|| :new.customer_trx_id ||')';

      if lb_debug then
        fnd_file.put_line(fnd_file.log, lv_action||'-JAI_AR_RCTLA_ARIUD_T1. Before JAI_AR_RCTLA_TRIGGER_PKG.import_projects_taxes');
      end if;

      JAI_AR_RCTLA_TRIGGER_PKG.import_projects_taxes
      (
              r_new         =>     t_new_rec
          ,   r_old         =>     t_old_rec
          ,   pv_action     =>     lv_action
          ,   pv_err_msg    =>     lv_return_message
          ,   pv_err_flg    =>     lv_return_code
      );

      if lv_return_code in (jai_constants.expected_error, jai_constants.unexpected_error)  then
        raise le_error ;
      end if;

    else
    /* End, bug#6012570 (5876390) */


      IF ((:NEW.inventory_item_id <> :OLD.inventory_item_id) OR (:OLD.inventory_item_id IS NULL)) THEN

        JAI_AR_RCTLA_TRIGGER_PKG.ARI_T1 (
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

      IF ( :NEW.LINE_TYPE = 'LINE' ) THEN

        JAI_AR_RCTLA_TRIGGER_PKG.ARI_T2 (
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

      IF ( :NEW.LINE_TYPE = 'LINE' ) THEN

        JAI_AR_RCTLA_TRIGGER_PKG.ARI_T3 (
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

      IF ( (:NEW.LINE_TYPE in ('LINE')) AND ((NVL(:NEW.inventory_item_id,0) <> NVL(:OLD.inventory_item_id,0)) OR (:OLD.inventory_item_id IS NULL AND :OLD.Description IS NULL)) )THEN

        JAI_AR_RCTLA_TRIGGER_PKG.ARIU_T1 (
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
    end if; -- 6012570
  end if;

  IF UPDATING THEN

    IF ((:OLD.LINE_TYPE = 'LINE') AND (:NEW.quantity_credited <> :OLD.quantity_credited OR :NEW.unit_selling_price <> :OLD.unit_selling_price OR :NEW.UOM_CODE <> :OLD.UOM_CODE) ) THEN

      JAI_AR_RCTLA_TRIGGER_PKG.ARU_T1 (
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
/*Bug 4694648 bduvarag*/
/*  JMEENA for bug#6414523
Added condition - OR :old.inventory_item_id is null.
When Qty / Rate is changed for a memo line and old.inventory_item_id is NULL Taxes should be recalculated.
*/
    IF ((:OLD.LINE_TYPE = 'LINE') AND (nvl(:NEW.inventory_item_id,-99999) = nvl(:OLD.inventory_item_id,-99999) OR :old.inventory_item_id is null )
    AND (:NEW.quantity_invoiced <> :OLD.quantity_invoiced OR :NEW.quantity_credited <> :OLD.quantity_credited OR :NEW.unit_selling_price <> :OLD.unit_selling_price OR :NEW.UOM_CODE <> :OLD.UOM_CODE) ) THEN

      JAI_AR_RCTLA_TRIGGER_PKG.ARU_T2 (
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

    IF ( (:NEW.LINE_TYPE in ('LINE')) AND ((NVL(:NEW.inventory_item_id,0) <> NVL(:OLD.inventory_item_id,0)) OR (:OLD.inventory_item_id IS NULL AND :OLD.Description IS NULL))) THEN

      JAI_AR_RCTLA_TRIGGER_PKG.ARIU_T1 (
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

  IF DELETING THEN

    IF ( :OLD.LINE_TYPE = 'LINE' ) THEN

      JAI_AR_RCTLA_TRIGGER_PKG.ARD_T1 (
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

	/* Added by JMEENA for bug# 6391684 (FP of 6386592 )*/
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_context     = ' ||:new.interface_line_context      );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute1  = ' ||:new.interface_line_attribute1   );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute3  = ' ||:new.interface_line_attribute3   );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute6  = ' ||:new.interface_line_attribute6   );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute11 = ' ||:new.interface_line_attribute11  );

     FND_FILE.PUT_LINE(FND_FILE.LOG,
      ' Error in trigger JAI_AR_RCTLA_ARIUD_T1'|| lv_return_message);
     app_exception.raise_exception (
                                     EXCEPTION_TYPE  => 'APP'  ,
                                     EXCEPTION_CODE  => -20110 ,
                                     EXCEPTION_TEXT  => lv_return_message
                                   );

  WHEN OTHERS THEN
	/* Added by JMEENA for bug# 6391684 (FP of 6386592 )*/
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_context     = ' ||:new.interface_line_context      );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute1  = ' ||:new.interface_line_attribute1   );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute3  = ' ||:new.interface_line_attribute3   );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute6  = ' ||:new.interface_line_attribute6   );
    fnd_file.put_line(fnd_file.log, 'JAI: interface_line_attribute11 = ' ||:new.interface_line_attribute11  );

     FND_FILE.PUT_LINE(FND_FILE.LOG,
      ' Error in trigger JAI_AR_RCTLA_ARIUD_T1'|| lv_return_message);

      app_exception.raise_exception (
                                      EXCEPTION_TYPE  => 'APP',
                                      EXCEPTION_CODE  => -20110 ,
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_AR_RCTLA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_AR_RCTLA_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_AR_RCTLA_ARIUD_T1" DISABLE;
