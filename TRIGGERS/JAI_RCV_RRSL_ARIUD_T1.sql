--------------------------------------------------------
--  DDL for Trigger JAI_RCV_RRSL_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_RCV_RRSL_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."RCV_RECEIVING_SUB_LEDGER"
FOR EACH ROW
DECLARE
  t_old_rec             RCV_RECEIVING_SUB_LEDGER%rowtype ;
  t_new_rec             RCV_RECEIVING_SUB_LEDGER%rowtype ;
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

    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.RCV_TRANSACTION_ID                       := :new.RCV_TRANSACTION_ID                            ;
    t_new_rec.CURRENCY_CODE                            := :new.CURRENCY_CODE                                 ;
    t_new_rec.ACTUAL_FLAG                              := :new.ACTUAL_FLAG                                   ;
    t_new_rec.JE_SOURCE_NAME                           := :new.JE_SOURCE_NAME                                ;
    t_new_rec.JE_CATEGORY_NAME                         := :new.JE_CATEGORY_NAME                              ;
    t_new_rec.SET_OF_BOOKS_ID                          := :new.SET_OF_BOOKS_ID                               ;
    t_new_rec.ACCOUNTING_DATE                          := :new.ACCOUNTING_DATE                               ;
    t_new_rec.CODE_COMBINATION_ID                      := :new.CODE_COMBINATION_ID                           ;
    t_new_rec.ACCOUNTED_DR                             := :new.ACCOUNTED_DR                                  ;
    t_new_rec.ACCOUNTED_CR                             := :new.ACCOUNTED_CR                                  ;
    t_new_rec.ENCUMBRANCE_TYPE_ID                      := :new.ENCUMBRANCE_TYPE_ID                           ;
    t_new_rec.ENTERED_DR                               := :new.ENTERED_DR                                    ;
    t_new_rec.ENTERED_CR                               := :new.ENTERED_CR                                    ;
    t_new_rec.BUDGET_VERSION_ID                        := :new.BUDGET_VERSION_ID                             ;
    t_new_rec.CURRENCY_CONVERSION_DATE                 := :new.CURRENCY_CONVERSION_DATE                      ;
    t_new_rec.USER_CURRENCY_CONVERSION_TYPE            := :new.USER_CURRENCY_CONVERSION_TYPE                 ;
    t_new_rec.CURRENCY_CONVERSION_RATE                 := :new.CURRENCY_CONVERSION_RATE                      ;
    t_new_rec.TRANSACTION_DATE                         := :new.TRANSACTION_DATE                              ;
    t_new_rec.PERIOD_NAME                              := :new.PERIOD_NAME                                   ;
    t_new_rec.CHART_OF_ACCOUNTS_ID                     := :new.CHART_OF_ACCOUNTS_ID                          ;
    t_new_rec.FUNCTIONAL_CURRENCY_CODE                 := :new.FUNCTIONAL_CURRENCY_CODE                      ;
    t_new_rec.DATE_CREATED_IN_GL                       := :new.DATE_CREATED_IN_GL                            ;
    t_new_rec.JE_BATCH_NAME                            := :new.JE_BATCH_NAME                                 ;
    t_new_rec.JE_BATCH_DESCRIPTION                     := :new.JE_BATCH_DESCRIPTION                          ;
    t_new_rec.JE_HEADER_NAME                           := :new.JE_HEADER_NAME                                ;
    t_new_rec.JE_LINE_DESCRIPTION                      := :new.JE_LINE_DESCRIPTION                           ;
    t_new_rec.REVERSE_JOURNAL_FLAG                     := :new.REVERSE_JOURNAL_FLAG                          ;
    t_new_rec.REVERSAL_PERIOD_NAME                     := :new.REVERSAL_PERIOD_NAME                          ;
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
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.SUBLEDGER_DOC_SEQUENCE_ID                := :new.SUBLEDGER_DOC_SEQUENCE_ID                     ;
    t_new_rec.SUBLEDGER_DOC_SEQUENCE_VALUE             := :new.SUBLEDGER_DOC_SEQUENCE_VALUE                  ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.REFERENCE1                               := :new.REFERENCE1                                    ;
    t_new_rec.REFERENCE2                               := :new.REFERENCE2                                    ;
    t_new_rec.REFERENCE3                               := :new.REFERENCE3                                    ;
    t_new_rec.REFERENCE4                               := :new.REFERENCE4                                    ;
    t_new_rec.REFERENCE5                               := :new.REFERENCE5                                    ;
    t_new_rec.REFERENCE6                               := :new.REFERENCE6                                    ;
    t_new_rec.REFERENCE7                               := :new.REFERENCE7                                    ;
    t_new_rec.REFERENCE8                               := :new.REFERENCE8                                    ;
    t_new_rec.REFERENCE9                               := :new.REFERENCE9                                    ;
    t_new_rec.REFERENCE10                              := :new.REFERENCE10                                   ;
    t_new_rec.SOURCE_DOC_QUANTITY                      := :new.SOURCE_DOC_QUANTITY                           ;
    t_new_rec.ACCRUAL_METHOD_FLAG                      := :new.ACCRUAL_METHOD_FLAG                           ;
    t_new_rec.GL_SL_LINK_ID                            := :new.GL_SL_LINK_ID                                 ;
    t_new_rec.ENTERED_REC_TAX                          := :new.ENTERED_REC_TAX                               ;
    t_new_rec.ENTERED_NR_TAX                           := :new.ENTERED_NR_TAX                                ;
    t_new_rec.ACCOUNTED_REC_TAX                        := :new.ACCOUNTED_REC_TAX                             ;
    t_new_rec.ACCOUNTED_NR_TAX                         := :new.ACCOUNTED_NR_TAX                              ;
    t_new_rec.RCV_SUB_LEDGER_ID                        := :new.RCV_SUB_LEDGER_ID                             ;
    t_new_rec.ACCOUNTING_EVENT_ID                      := :new.ACCOUNTING_EVENT_ID                           ;
    t_new_rec.ACCOUNTING_LINE_TYPE                     := :new.ACCOUNTING_LINE_TYPE                          ;
    t_new_rec.PA_ADDITION_FLAG                         := :new.PA_ADDITION_FLAG                              ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.RCV_TRANSACTION_ID                       := :old.RCV_TRANSACTION_ID                            ;
    t_old_rec.CURRENCY_CODE                            := :old.CURRENCY_CODE                                 ;
    t_old_rec.ACTUAL_FLAG                              := :old.ACTUAL_FLAG                                   ;
    t_old_rec.JE_SOURCE_NAME                           := :old.JE_SOURCE_NAME                                ;
    t_old_rec.JE_CATEGORY_NAME                         := :old.JE_CATEGORY_NAME                              ;
    t_old_rec.SET_OF_BOOKS_ID                          := :old.SET_OF_BOOKS_ID                               ;
    t_old_rec.ACCOUNTING_DATE                          := :old.ACCOUNTING_DATE                               ;
    t_old_rec.CODE_COMBINATION_ID                      := :old.CODE_COMBINATION_ID                           ;
    t_old_rec.ACCOUNTED_DR                             := :old.ACCOUNTED_DR                                  ;
    t_old_rec.ACCOUNTED_CR                             := :old.ACCOUNTED_CR                                  ;
    t_old_rec.ENCUMBRANCE_TYPE_ID                      := :old.ENCUMBRANCE_TYPE_ID                           ;
    t_old_rec.ENTERED_DR                               := :old.ENTERED_DR                                    ;
    t_old_rec.ENTERED_CR                               := :old.ENTERED_CR                                    ;
    t_old_rec.BUDGET_VERSION_ID                        := :old.BUDGET_VERSION_ID                             ;
    t_old_rec.CURRENCY_CONVERSION_DATE                 := :old.CURRENCY_CONVERSION_DATE                      ;
    t_old_rec.USER_CURRENCY_CONVERSION_TYPE            := :old.USER_CURRENCY_CONVERSION_TYPE                 ;
    t_old_rec.CURRENCY_CONVERSION_RATE                 := :old.CURRENCY_CONVERSION_RATE                      ;
    t_old_rec.TRANSACTION_DATE                         := :old.TRANSACTION_DATE                              ;
    t_old_rec.PERIOD_NAME                              := :old.PERIOD_NAME                                   ;
    t_old_rec.CHART_OF_ACCOUNTS_ID                     := :old.CHART_OF_ACCOUNTS_ID                          ;
    t_old_rec.FUNCTIONAL_CURRENCY_CODE                 := :old.FUNCTIONAL_CURRENCY_CODE                      ;
    t_old_rec.DATE_CREATED_IN_GL                       := :old.DATE_CREATED_IN_GL                            ;
    t_old_rec.JE_BATCH_NAME                            := :old.JE_BATCH_NAME                                 ;
    t_old_rec.JE_BATCH_DESCRIPTION                     := :old.JE_BATCH_DESCRIPTION                          ;
    t_old_rec.JE_HEADER_NAME                           := :old.JE_HEADER_NAME                                ;
    t_old_rec.JE_LINE_DESCRIPTION                      := :old.JE_LINE_DESCRIPTION                           ;
    t_old_rec.REVERSE_JOURNAL_FLAG                     := :old.REVERSE_JOURNAL_FLAG                          ;
    t_old_rec.REVERSAL_PERIOD_NAME                     := :old.REVERSAL_PERIOD_NAME                          ;
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
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.SUBLEDGER_DOC_SEQUENCE_ID                := :old.SUBLEDGER_DOC_SEQUENCE_ID                     ;
    t_old_rec.SUBLEDGER_DOC_SEQUENCE_VALUE             := :old.SUBLEDGER_DOC_SEQUENCE_VALUE                  ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.REFERENCE1                               := :old.REFERENCE1                                    ;
    t_old_rec.REFERENCE2                               := :old.REFERENCE2                                    ;
    t_old_rec.REFERENCE3                               := :old.REFERENCE3                                    ;
    t_old_rec.REFERENCE4                               := :old.REFERENCE4                                    ;
    t_old_rec.REFERENCE5                               := :old.REFERENCE5                                    ;
    t_old_rec.REFERENCE6                               := :old.REFERENCE6                                    ;
    t_old_rec.REFERENCE7                               := :old.REFERENCE7                                    ;
    t_old_rec.REFERENCE8                               := :old.REFERENCE8                                    ;
    t_old_rec.REFERENCE9                               := :old.REFERENCE9                                    ;
    t_old_rec.REFERENCE10                              := :old.REFERENCE10                                   ;
    t_old_rec.SOURCE_DOC_QUANTITY                      := :old.SOURCE_DOC_QUANTITY                           ;
    t_old_rec.ACCRUAL_METHOD_FLAG                      := :old.ACCRUAL_METHOD_FLAG                           ;
    t_old_rec.GL_SL_LINK_ID                            := :old.GL_SL_LINK_ID                                 ;
    t_old_rec.ENTERED_REC_TAX                          := :old.ENTERED_REC_TAX                               ;
    t_old_rec.ENTERED_NR_TAX                           := :old.ENTERED_NR_TAX                                ;
    t_old_rec.ACCOUNTED_REC_TAX                        := :old.ACCOUNTED_REC_TAX                             ;
    t_old_rec.ACCOUNTED_NR_TAX                         := :old.ACCOUNTED_NR_TAX                              ;
    t_old_rec.RCV_SUB_LEDGER_ID                        := :old.RCV_SUB_LEDGER_ID                             ;
    t_old_rec.ACCOUNTING_EVENT_ID                      := :old.ACCOUNTING_EVENT_ID                           ;
    t_old_rec.ACCOUNTING_LINE_TYPE                     := :old.ACCOUNTING_LINE_TYPE                          ;
    t_old_rec.PA_ADDITION_FLAG                         := :old.PA_ADDITION_FLAG                              ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_RCV_RRSL_ARIUD_T1', p_set_of_books_id => :new.set_of_books_id ) = FALSE THEN
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

      JAI_RCV_RRSL_TRIGGER_PKG.ARIU_T1 (
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

  IF UPDATING THEN

      JAI_RCV_RRSL_TRIGGER_PKG.ARIU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_RCV_RRSL_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_RCV_RRSL_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_RCV_RRSL_ARIUD_T1" DISABLE;
