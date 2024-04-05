--------------------------------------------------------
--  DDL for Trigger JAI_PO_DA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_DA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."PO_DISTRIBUTIONS_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             PO_DISTRIBUTIONS_ALL%rowtype ;
  t_new_rec             PO_DISTRIBUTIONS_ALL%rowtype ;
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

    t_new_rec.PO_DISTRIBUTION_ID                       := :new.PO_DISTRIBUTION_ID                            ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.PO_LINE_ID                               := :new.PO_LINE_ID                                    ;
    t_new_rec.LINE_LOCATION_ID                         := :new.LINE_LOCATION_ID                              ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.CODE_COMBINATION_ID                      := :new.CODE_COMBINATION_ID                           ;
    t_new_rec.QUANTITY_ORDERED                         := :new.QUANTITY_ORDERED                              ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.PO_RELEASE_ID                            := :new.PO_RELEASE_ID                                 ;
    t_new_rec.QUANTITY_DELIVERED                       := :new.QUANTITY_DELIVERED                            ;
    t_new_rec.QUANTITY_BILLED                          := :new.QUANTITY_BILLED                               ;
    t_new_rec.QUANTITY_CANCELLED                       := :new.QUANTITY_CANCELLED                            ;
    t_new_rec.REQ_HEADER_REFERENCE_NUM                 := :new.REQ_HEADER_REFERENCE_NUM                      ;
    t_new_rec.REQ_LINE_REFERENCE_NUM                   := :new.REQ_LINE_REFERENCE_NUM                        ;
    t_new_rec.REQ_DISTRIBUTION_ID                      := :new.REQ_DISTRIBUTION_ID                           ;
    t_new_rec.DELIVER_TO_LOCATION_ID                   := :new.DELIVER_TO_LOCATION_ID                        ;
    t_new_rec.DELIVER_TO_PERSON_ID                     := :new.DELIVER_TO_PERSON_ID                          ;
    t_new_rec.RATE_DATE                                := :new.RATE_DATE                                     ;
    t_new_rec.RATE                                     := :new.RATE                                          ;
    t_new_rec.AMOUNT_BILLED                            := :new.AMOUNT_BILLED                                 ;
    t_new_rec.ACCRUED_FLAG                             := :new.ACCRUED_FLAG                                  ;
    t_new_rec.ENCUMBERED_FLAG                          := :new.ENCUMBERED_FLAG                               ;
    t_new_rec.ENCUMBERED_AMOUNT                        := :new.ENCUMBERED_AMOUNT                             ;
    t_new_rec.UNENCUMBERED_QUANTITY                    := :new.UNENCUMBERED_QUANTITY                         ;
    t_new_rec.UNENCUMBERED_AMOUNT                      := :new.UNENCUMBERED_AMOUNT                           ;
    t_new_rec.FAILED_FUNDS_LOOKUP_CODE                 := :new.FAILED_FUNDS_LOOKUP_CODE                      ;
    t_new_rec.GL_ENCUMBERED_DATE                       := :new.GL_ENCUMBERED_DATE                            ;
    t_new_rec.GL_ENCUMBERED_PERIOD_NAME                := :new.GL_ENCUMBERED_PERIOD_NAME                     ;
    t_new_rec.GL_CANCELLED_DATE                        := :new.GL_CANCELLED_DATE                             ;
    t_new_rec.DESTINATION_TYPE_CODE                    := :new.DESTINATION_TYPE_CODE                         ;
    t_new_rec.DESTINATION_ORGANIZATION_ID              := :new.DESTINATION_ORGANIZATION_ID                   ;
    t_new_rec.DESTINATION_SUBINVENTORY                 := :new.DESTINATION_SUBINVENTORY                      ;
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
    t_new_rec.WIP_ENTITY_ID                            := :new.WIP_ENTITY_ID                                 ;
    t_new_rec.WIP_OPERATION_SEQ_NUM                    := :new.WIP_OPERATION_SEQ_NUM                         ;
    t_new_rec.WIP_RESOURCE_SEQ_NUM                     := :new.WIP_RESOURCE_SEQ_NUM                          ;
    t_new_rec.WIP_REPETITIVE_SCHEDULE_ID               := :new.WIP_REPETITIVE_SCHEDULE_ID                    ;
    t_new_rec.WIP_LINE_ID                              := :new.WIP_LINE_ID                                   ;
    t_new_rec.BOM_RESOURCE_ID                          := :new.BOM_RESOURCE_ID                               ;
    t_new_rec.BUDGET_ACCOUNT_ID                        := :new.BUDGET_ACCOUNT_ID                             ;
    t_new_rec.ACCRUAL_ACCOUNT_ID                       := :new.ACCRUAL_ACCOUNT_ID                            ;
    t_new_rec.VARIANCE_ACCOUNT_ID                      := :new.VARIANCE_ACCOUNT_ID                           ;
    t_new_rec.PREVENT_ENCUMBRANCE_FLAG                 := :new.PREVENT_ENCUMBRANCE_FLAG                      ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.GOVERNMENT_CONTEXT                       := :new.GOVERNMENT_CONTEXT                            ;
    t_new_rec.DESTINATION_CONTEXT                      := :new.DESTINATION_CONTEXT                           ;
    t_new_rec.DISTRIBUTION_NUM                         := :new.DISTRIBUTION_NUM                              ;
    t_new_rec.SOURCE_DISTRIBUTION_ID                   := :new.SOURCE_DISTRIBUTION_ID                        ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.PROJECT_ID                               := :new.PROJECT_ID                                    ;
    t_new_rec.TASK_ID                                  := :new.TASK_ID                                       ;
    t_new_rec.EXPENDITURE_TYPE                         := :new.EXPENDITURE_TYPE                              ;
    t_new_rec.PROJECT_ACCOUNTING_CONTEXT               := :new.PROJECT_ACCOUNTING_CONTEXT                    ;
    t_new_rec.EXPENDITURE_ORGANIZATION_ID              := :new.EXPENDITURE_ORGANIZATION_ID                   ;
    t_new_rec.GL_CLOSED_DATE                           := :new.GL_CLOSED_DATE                                ;
    t_new_rec.ACCRUE_ON_RECEIPT_FLAG                   := :new.ACCRUE_ON_RECEIPT_FLAG                        ;
    t_new_rec.EXPENDITURE_ITEM_DATE                    := :new.EXPENDITURE_ITEM_DATE                         ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.KANBAN_CARD_ID                           := :new.KANBAN_CARD_ID                                ;
    t_new_rec.AWARD_ID                                 := :new.AWARD_ID                                      ;
    t_new_rec.MRC_RATE_DATE                            := :new.MRC_RATE_DATE                                 ;
    t_new_rec.MRC_RATE                                 := :new.MRC_RATE                                      ;
    t_new_rec.MRC_ENCUMBERED_AMOUNT                    := :new.MRC_ENCUMBERED_AMOUNT                         ;
    t_new_rec.MRC_UNENCUMBERED_AMOUNT                  := :new.MRC_UNENCUMBERED_AMOUNT                       ;
    t_new_rec.END_ITEM_UNIT_NUMBER                     := :new.END_ITEM_UNIT_NUMBER                          ;
    t_new_rec.TAX_RECOVERY_OVERRIDE_FLAG               := :new.TAX_RECOVERY_OVERRIDE_FLAG                    ;
    t_new_rec.RECOVERABLE_TAX                          := :new.RECOVERABLE_TAX                               ;
    t_new_rec.NONRECOVERABLE_TAX                       := :new.NONRECOVERABLE_TAX                            ;
    t_new_rec.RECOVERY_RATE                            := :new.RECOVERY_RATE                                 ;
    t_new_rec.OKE_CONTRACT_LINE_ID                     := :new.OKE_CONTRACT_LINE_ID                          ;
    t_new_rec.OKE_CONTRACT_DELIVERABLE_ID              := :new.OKE_CONTRACT_DELIVERABLE_ID                   ;
    t_new_rec.AMOUNT_ORDERED                           := :new.AMOUNT_ORDERED                                ;
    t_new_rec.AMOUNT_DELIVERED                         := :new.AMOUNT_DELIVERED                              ;
    t_new_rec.AMOUNT_CANCELLED                         := :new.AMOUNT_CANCELLED                              ;
    t_new_rec.DISTRIBUTION_TYPE                        := :new.DISTRIBUTION_TYPE                             ;
    t_new_rec.AMOUNT_TO_ENCUMBER                       := :new.AMOUNT_TO_ENCUMBER                            ;
    t_new_rec.INVOICE_ADJUSTMENT_FLAG                  := :new.INVOICE_ADJUSTMENT_FLAG                       ;
    t_new_rec.DEST_CHARGE_ACCOUNT_ID                   := :new.DEST_CHARGE_ACCOUNT_ID                        ;
    t_new_rec.DEST_VARIANCE_ACCOUNT_ID                 := :new.DEST_VARIANCE_ACCOUNT_ID                      ;
    t_new_rec.QUANTITY_FINANCED                        := :new.QUANTITY_FINANCED                             ;
    t_new_rec.AMOUNT_FINANCED                          := :new.AMOUNT_FINANCED                               ;
    t_new_rec.QUANTITY_RECOUPED                        := :new.QUANTITY_RECOUPED                             ;
    t_new_rec.AMOUNT_RECOUPED                          := :new.AMOUNT_RECOUPED                               ;
    t_new_rec.RETAINAGE_WITHHELD_AMOUNT                := :new.RETAINAGE_WITHHELD_AMOUNT                     ;
    t_new_rec.RETAINAGE_RELEASED_AMOUNT                := :new.RETAINAGE_RELEASED_AMOUNT                     ;
    t_new_rec.WF_ITEM_KEY                              := :new.WF_ITEM_KEY                                   ;
    t_new_rec.INVOICED_VAL_IN_NTFN                     := :new.INVOICED_VAL_IN_NTFN                          ;
    t_new_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :new.TAX_ATTRIBUTE_UPDATE_CODE                     ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.PO_DISTRIBUTION_ID                       := :old.PO_DISTRIBUTION_ID                            ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.PO_LINE_ID                               := :old.PO_LINE_ID                                    ;
    t_old_rec.LINE_LOCATION_ID                         := :old.LINE_LOCATION_ID                              ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.CODE_COMBINATION_ID                      := :old.CODE_COMBINATION_ID                           ;
    t_old_rec.QUANTITY_ORDERED                         := :old.QUANTITY_ORDERED                              ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.PO_RELEASE_ID                            := :old.PO_RELEASE_ID                                 ;
    t_old_rec.QUANTITY_DELIVERED                       := :old.QUANTITY_DELIVERED                            ;
    t_old_rec.QUANTITY_BILLED                          := :old.QUANTITY_BILLED                               ;
    t_old_rec.QUANTITY_CANCELLED                       := :old.QUANTITY_CANCELLED                            ;
    t_old_rec.REQ_HEADER_REFERENCE_NUM                 := :old.REQ_HEADER_REFERENCE_NUM                      ;
    t_old_rec.REQ_LINE_REFERENCE_NUM                   := :old.REQ_LINE_REFERENCE_NUM                        ;
    t_old_rec.REQ_DISTRIBUTION_ID                      := :old.REQ_DISTRIBUTION_ID                           ;
    t_old_rec.DELIVER_TO_LOCATION_ID                   := :old.DELIVER_TO_LOCATION_ID                        ;
    t_old_rec.DELIVER_TO_PERSON_ID                     := :old.DELIVER_TO_PERSON_ID                          ;
    t_old_rec.RATE_DATE                                := :old.RATE_DATE                                     ;
    t_old_rec.RATE                                     := :old.RATE                                          ;
    t_old_rec.AMOUNT_BILLED                            := :old.AMOUNT_BILLED                                 ;
    t_old_rec.ACCRUED_FLAG                             := :old.ACCRUED_FLAG                                  ;
    t_old_rec.ENCUMBERED_FLAG                          := :old.ENCUMBERED_FLAG                               ;
    t_old_rec.ENCUMBERED_AMOUNT                        := :old.ENCUMBERED_AMOUNT                             ;
    t_old_rec.UNENCUMBERED_QUANTITY                    := :old.UNENCUMBERED_QUANTITY                         ;
    t_old_rec.UNENCUMBERED_AMOUNT                      := :old.UNENCUMBERED_AMOUNT                           ;
    t_old_rec.FAILED_FUNDS_LOOKUP_CODE                 := :old.FAILED_FUNDS_LOOKUP_CODE                      ;
    t_old_rec.GL_ENCUMBERED_DATE                       := :old.GL_ENCUMBERED_DATE                            ;
    t_old_rec.GL_ENCUMBERED_PERIOD_NAME                := :old.GL_ENCUMBERED_PERIOD_NAME                     ;
    t_old_rec.GL_CANCELLED_DATE                        := :old.GL_CANCELLED_DATE                             ;
    t_old_rec.DESTINATION_TYPE_CODE                    := :old.DESTINATION_TYPE_CODE                         ;
    t_old_rec.DESTINATION_ORGANIZATION_ID              := :old.DESTINATION_ORGANIZATION_ID                   ;
    t_old_rec.DESTINATION_SUBINVENTORY                 := :old.DESTINATION_SUBINVENTORY                      ;
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
    t_old_rec.WIP_ENTITY_ID                            := :old.WIP_ENTITY_ID                                 ;
    t_old_rec.WIP_OPERATION_SEQ_NUM                    := :old.WIP_OPERATION_SEQ_NUM                         ;
    t_old_rec.WIP_RESOURCE_SEQ_NUM                     := :old.WIP_RESOURCE_SEQ_NUM                          ;
    t_old_rec.WIP_REPETITIVE_SCHEDULE_ID               := :old.WIP_REPETITIVE_SCHEDULE_ID                    ;
    t_old_rec.WIP_LINE_ID                              := :old.WIP_LINE_ID                                   ;
    t_old_rec.BOM_RESOURCE_ID                          := :old.BOM_RESOURCE_ID                               ;
    t_old_rec.BUDGET_ACCOUNT_ID                        := :old.BUDGET_ACCOUNT_ID                             ;
    t_old_rec.ACCRUAL_ACCOUNT_ID                       := :old.ACCRUAL_ACCOUNT_ID                            ;
    t_old_rec.VARIANCE_ACCOUNT_ID                      := :old.VARIANCE_ACCOUNT_ID                           ;
    t_old_rec.PREVENT_ENCUMBRANCE_FLAG                 := :old.PREVENT_ENCUMBRANCE_FLAG                      ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.GOVERNMENT_CONTEXT                       := :old.GOVERNMENT_CONTEXT                            ;
    t_old_rec.DESTINATION_CONTEXT                      := :old.DESTINATION_CONTEXT                           ;
    t_old_rec.DISTRIBUTION_NUM                         := :old.DISTRIBUTION_NUM                              ;
    t_old_rec.SOURCE_DISTRIBUTION_ID                   := :old.SOURCE_DISTRIBUTION_ID                        ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.PROJECT_ID                               := :old.PROJECT_ID                                    ;
    t_old_rec.TASK_ID                                  := :old.TASK_ID                                       ;
    t_old_rec.EXPENDITURE_TYPE                         := :old.EXPENDITURE_TYPE                              ;
    t_old_rec.PROJECT_ACCOUNTING_CONTEXT               := :old.PROJECT_ACCOUNTING_CONTEXT                    ;
    t_old_rec.EXPENDITURE_ORGANIZATION_ID              := :old.EXPENDITURE_ORGANIZATION_ID                   ;
    t_old_rec.GL_CLOSED_DATE                           := :old.GL_CLOSED_DATE                                ;
    t_old_rec.ACCRUE_ON_RECEIPT_FLAG                   := :old.ACCRUE_ON_RECEIPT_FLAG                        ;
    t_old_rec.EXPENDITURE_ITEM_DATE                    := :old.EXPENDITURE_ITEM_DATE                         ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.KANBAN_CARD_ID                           := :old.KANBAN_CARD_ID                                ;
    t_old_rec.AWARD_ID                                 := :old.AWARD_ID                                      ;
    t_old_rec.MRC_RATE_DATE                            := :old.MRC_RATE_DATE                                 ;
    t_old_rec.MRC_RATE                                 := :old.MRC_RATE                                      ;
    t_old_rec.MRC_ENCUMBERED_AMOUNT                    := :old.MRC_ENCUMBERED_AMOUNT                         ;
    t_old_rec.MRC_UNENCUMBERED_AMOUNT                  := :old.MRC_UNENCUMBERED_AMOUNT                       ;
    t_old_rec.END_ITEM_UNIT_NUMBER                     := :old.END_ITEM_UNIT_NUMBER                          ;
    t_old_rec.TAX_RECOVERY_OVERRIDE_FLAG               := :old.TAX_RECOVERY_OVERRIDE_FLAG                    ;
    t_old_rec.RECOVERABLE_TAX                          := :old.RECOVERABLE_TAX                               ;
    t_old_rec.NONRECOVERABLE_TAX                       := :old.NONRECOVERABLE_TAX                            ;
    t_old_rec.RECOVERY_RATE                            := :old.RECOVERY_RATE                                 ;
    t_old_rec.OKE_CONTRACT_LINE_ID                     := :old.OKE_CONTRACT_LINE_ID                          ;
    t_old_rec.OKE_CONTRACT_DELIVERABLE_ID              := :old.OKE_CONTRACT_DELIVERABLE_ID                   ;
    t_old_rec.AMOUNT_ORDERED                           := :old.AMOUNT_ORDERED                                ;
    t_old_rec.AMOUNT_DELIVERED                         := :old.AMOUNT_DELIVERED                              ;
    t_old_rec.AMOUNT_CANCELLED                         := :old.AMOUNT_CANCELLED                              ;
    t_old_rec.DISTRIBUTION_TYPE                        := :old.DISTRIBUTION_TYPE                             ;
    t_old_rec.AMOUNT_TO_ENCUMBER                       := :old.AMOUNT_TO_ENCUMBER                            ;
    t_old_rec.INVOICE_ADJUSTMENT_FLAG                  := :old.INVOICE_ADJUSTMENT_FLAG                       ;
    t_old_rec.DEST_CHARGE_ACCOUNT_ID                   := :old.DEST_CHARGE_ACCOUNT_ID                        ;
    t_old_rec.DEST_VARIANCE_ACCOUNT_ID                 := :old.DEST_VARIANCE_ACCOUNT_ID                      ;
    t_old_rec.QUANTITY_FINANCED                        := :old.QUANTITY_FINANCED                             ;
    t_old_rec.AMOUNT_FINANCED                          := :old.AMOUNT_FINANCED                               ;
    t_old_rec.QUANTITY_RECOUPED                        := :old.QUANTITY_RECOUPED                             ;
    t_old_rec.AMOUNT_RECOUPED                          := :old.AMOUNT_RECOUPED                               ;
    t_old_rec.RETAINAGE_WITHHELD_AMOUNT                := :old.RETAINAGE_WITHHELD_AMOUNT                     ;
    t_old_rec.RETAINAGE_RELEASED_AMOUNT                := :old.RETAINAGE_RELEASED_AMOUNT                     ;
    t_old_rec.WF_ITEM_KEY                              := :old.WF_ITEM_KEY                                   ;
    t_old_rec.INVOICED_VAL_IN_NTFN                     := :old.INVOICED_VAL_IN_NTFN                          ;
    t_old_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :old.TAX_ATTRIBUTE_UPDATE_CODE                     ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_DA_ARIUD_T1', p_set_of_books_id => :new.set_of_books_id ) = FALSE THEN
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

      JAI_PO_DA_TRIGGER_PKG.ARI_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_DA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_DA_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_PO_DA_ARIUD_T1" DISABLE;
