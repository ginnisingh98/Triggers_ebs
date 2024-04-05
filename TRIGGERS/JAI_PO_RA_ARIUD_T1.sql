--------------------------------------------------------
--  DDL for Trigger JAI_PO_RA_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_RA_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "PO"."PO_RELEASES_ALL"
FOR EACH ROW
DECLARE
  t_old_rec             PO_RELEASES_ALL%rowtype ;
  t_new_rec             PO_RELEASES_ALL%rowtype ;
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

    t_new_rec.PO_RELEASE_ID                            := :new.PO_RELEASE_ID                                 ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.PO_HEADER_ID                             := :new.PO_HEADER_ID                                  ;
    t_new_rec.RELEASE_NUM                              := :new.RELEASE_NUM                                   ;
    t_new_rec.AGENT_ID                                 := :new.AGENT_ID                                      ;
    t_new_rec.RELEASE_DATE                             := :new.RELEASE_DATE                                  ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.REVISION_NUM                             := :new.REVISION_NUM                                  ;
    t_new_rec.REVISED_DATE                             := :new.REVISED_DATE                                  ;
    t_new_rec.APPROVED_FLAG                            := :new.APPROVED_FLAG                                 ;
    t_new_rec.APPROVED_DATE                            := :new.APPROVED_DATE                                 ;
    t_new_rec.PRINT_COUNT                              := :new.PRINT_COUNT                                   ;
    t_new_rec.PRINTED_DATE                             := :new.PRINTED_DATE                                  ;
    t_new_rec.ACCEPTANCE_REQUIRED_FLAG                 := :new.ACCEPTANCE_REQUIRED_FLAG                      ;
    t_new_rec.ACCEPTANCE_DUE_DATE                      := :new.ACCEPTANCE_DUE_DATE                           ;
    t_new_rec.HOLD_BY                                  := :new.HOLD_BY                                       ;
    t_new_rec.HOLD_DATE                                := :new.HOLD_DATE                                     ;
    t_new_rec.HOLD_REASON                              := :new.HOLD_REASON                                   ;
    t_new_rec.HOLD_FLAG                                := :new.HOLD_FLAG                                     ;
    t_new_rec.CANCEL_FLAG                              := :new.CANCEL_FLAG                                   ;
    t_new_rec.CANCELLED_BY                             := :new.CANCELLED_BY                                  ;
    t_new_rec.CANCEL_DATE                              := :new.CANCEL_DATE                                   ;
    t_new_rec.CANCEL_REASON                            := :new.CANCEL_REASON                                 ;
    t_new_rec.FIRM_STATUS_LOOKUP_CODE                  := :new.FIRM_STATUS_LOOKUP_CODE                       ;
    t_new_rec.FIRM_DATE                                := :new.FIRM_DATE                                     ;
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
    t_new_rec.AUTHORIZATION_STATUS                     := :new.AUTHORIZATION_STATUS                          ;
    t_new_rec.USSGL_TRANSACTION_CODE                   := :new.USSGL_TRANSACTION_CODE                        ;
    t_new_rec.GOVERNMENT_CONTEXT                       := :new.GOVERNMENT_CONTEXT                            ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
    t_new_rec.PROGRAM_APPLICATION_ID                   := :new.PROGRAM_APPLICATION_ID                        ;
    t_new_rec.PROGRAM_ID                               := :new.PROGRAM_ID                                    ;
    t_new_rec.PROGRAM_UPDATE_DATE                      := :new.PROGRAM_UPDATE_DATE                           ;
    t_new_rec.CLOSED_CODE                              := :new.CLOSED_CODE                                   ;
    t_new_rec.FROZEN_FLAG                              := :new.FROZEN_FLAG                                   ;
    t_new_rec.RELEASE_TYPE                             := :new.RELEASE_TYPE                                  ;
    t_new_rec.NOTE_TO_VENDOR                           := :new.NOTE_TO_VENDOR                                ;
    t_new_rec.ORG_ID                                   := :new.ORG_ID                                        ;
    t_new_rec.EDI_PROCESSED_FLAG                       := :new.EDI_PROCESSED_FLAG                            ;
    t_new_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :new.GLOBAL_ATTRIBUTE_CATEGORY                     ;
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
    t_new_rec.WF_ITEM_TYPE                             := :new.WF_ITEM_TYPE                                  ;
    t_new_rec.WF_ITEM_KEY                              := :new.WF_ITEM_KEY                                   ;
    t_new_rec.PCARD_ID                                 := :new.PCARD_ID                                      ;
    t_new_rec.PAY_ON_CODE                              := :new.PAY_ON_CODE                                   ;
    t_new_rec.XML_FLAG                                 := :new.XML_FLAG                                      ;
    t_new_rec.XML_SEND_DATE                            := :new.XML_SEND_DATE                                 ;
    t_new_rec.XML_CHANGE_SEND_DATE                     := :new.XML_CHANGE_SEND_DATE                          ;
    t_new_rec.CONSIGNED_CONSUMPTION_FLAG               := :new.CONSIGNED_CONSUMPTION_FLAG                    ;
    t_new_rec.CBC_ACCOUNTING_DATE                      := :new.CBC_ACCOUNTING_DATE                           ;
    t_new_rec.CHANGE_REQUESTED_BY                      := :new.CHANGE_REQUESTED_BY                           ;
    t_new_rec.VENDOR_ORDER_NUM                         := :new.VENDOR_ORDER_NUM                              ;
    t_new_rec.SHIPPING_CONTROL                         := :new.SHIPPING_CONTROL                              ;
    t_new_rec.CHANGE_SUMMARY                           := :new.CHANGE_SUMMARY                                ;
    t_new_rec.DOCUMENT_CREATION_METHOD                 := :new.DOCUMENT_CREATION_METHOD                      ;
    t_new_rec.SUBMIT_DATE                              := :new.SUBMIT_DATE                                   ;
    t_new_rec.TAX_ATTRIBUTE_UPDATE_CODE                := :new.TAX_ATTRIBUTE_UPDATE_CODE                     ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.PO_RELEASE_ID                            := :old.PO_RELEASE_ID                                 ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.PO_HEADER_ID                             := :old.PO_HEADER_ID                                  ;
    t_old_rec.RELEASE_NUM                              := :old.RELEASE_NUM                                   ;
    t_old_rec.AGENT_ID                                 := :old.AGENT_ID                                      ;
    t_old_rec.RELEASE_DATE                             := :old.RELEASE_DATE                                  ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.REVISION_NUM                             := :old.REVISION_NUM                                  ;
    t_old_rec.REVISED_DATE                             := :old.REVISED_DATE                                  ;
    t_old_rec.APPROVED_FLAG                            := :old.APPROVED_FLAG                                 ;
    t_old_rec.APPROVED_DATE                            := :old.APPROVED_DATE                                 ;
    t_old_rec.PRINT_COUNT                              := :old.PRINT_COUNT                                   ;
    t_old_rec.PRINTED_DATE                             := :old.PRINTED_DATE                                  ;
    t_old_rec.ACCEPTANCE_REQUIRED_FLAG                 := :old.ACCEPTANCE_REQUIRED_FLAG                      ;
    t_old_rec.ACCEPTANCE_DUE_DATE                      := :old.ACCEPTANCE_DUE_DATE                           ;
    t_old_rec.HOLD_BY                                  := :old.HOLD_BY                                       ;
    t_old_rec.HOLD_DATE                                := :old.HOLD_DATE                                     ;
    t_old_rec.HOLD_REASON                              := :old.HOLD_REASON                                   ;
    t_old_rec.HOLD_FLAG                                := :old.HOLD_FLAG                                     ;
    t_old_rec.CANCEL_FLAG                              := :old.CANCEL_FLAG                                   ;
    t_old_rec.CANCELLED_BY                             := :old.CANCELLED_BY                                  ;
    t_old_rec.CANCEL_DATE                              := :old.CANCEL_DATE                                   ;
    t_old_rec.CANCEL_REASON                            := :old.CANCEL_REASON                                 ;
    t_old_rec.FIRM_STATUS_LOOKUP_CODE                  := :old.FIRM_STATUS_LOOKUP_CODE                       ;
    t_old_rec.FIRM_DATE                                := :old.FIRM_DATE                                     ;
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
    t_old_rec.AUTHORIZATION_STATUS                     := :old.AUTHORIZATION_STATUS                          ;
    t_old_rec.USSGL_TRANSACTION_CODE                   := :old.USSGL_TRANSACTION_CODE                        ;
    t_old_rec.GOVERNMENT_CONTEXT                       := :old.GOVERNMENT_CONTEXT                            ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
    t_old_rec.PROGRAM_APPLICATION_ID                   := :old.PROGRAM_APPLICATION_ID                        ;
    t_old_rec.PROGRAM_ID                               := :old.PROGRAM_ID                                    ;
    t_old_rec.PROGRAM_UPDATE_DATE                      := :old.PROGRAM_UPDATE_DATE                           ;
    t_old_rec.CLOSED_CODE                              := :old.CLOSED_CODE                                   ;
    t_old_rec.FROZEN_FLAG                              := :old.FROZEN_FLAG                                   ;
    t_old_rec.RELEASE_TYPE                             := :old.RELEASE_TYPE                                  ;
    t_old_rec.NOTE_TO_VENDOR                           := :old.NOTE_TO_VENDOR                                ;
    t_old_rec.ORG_ID                                   := :old.ORG_ID                                        ;
    t_old_rec.EDI_PROCESSED_FLAG                       := :old.EDI_PROCESSED_FLAG                            ;
    t_old_rec.GLOBAL_ATTRIBUTE_CATEGORY                := :old.GLOBAL_ATTRIBUTE_CATEGORY                     ;
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
    t_old_rec.WF_ITEM_TYPE                             := :old.WF_ITEM_TYPE                                  ;
    t_old_rec.WF_ITEM_KEY                              := :old.WF_ITEM_KEY                                   ;
    t_old_rec.PCARD_ID                                 := :old.PCARD_ID                                      ;
    t_old_rec.PAY_ON_CODE                              := :old.PAY_ON_CODE                                   ;
    t_old_rec.XML_FLAG                                 := :old.XML_FLAG                                      ;
    t_old_rec.XML_SEND_DATE                            := :old.XML_SEND_DATE                                 ;
    t_old_rec.XML_CHANGE_SEND_DATE                     := :old.XML_CHANGE_SEND_DATE                          ;
    t_old_rec.CONSIGNED_CONSUMPTION_FLAG               := :old.CONSIGNED_CONSUMPTION_FLAG                    ;
    t_old_rec.CBC_ACCOUNTING_DATE                      := :old.CBC_ACCOUNTING_DATE                           ;
    t_old_rec.CHANGE_REQUESTED_BY                      := :old.CHANGE_REQUESTED_BY                           ;
    t_old_rec.VENDOR_ORDER_NUM                         := :old.VENDOR_ORDER_NUM                              ;
    t_old_rec.SHIPPING_CONTROL                         := :old.SHIPPING_CONTROL                              ;
    t_old_rec.CHANGE_SUMMARY                           := :old.CHANGE_SUMMARY                                ;
    t_old_rec.DOCUMENT_CREATION_METHOD                 := :old.DOCUMENT_CREATION_METHOD                      ;
    t_old_rec.SUBMIT_DATE                              := :old.SUBMIT_DATE                                   ;
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
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_RA_ARIUD_T1', P_ORG_ID => :new.org_id) = FALSE THEN
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

    IF ( :NEW.authorization_status = 'APPROVED' AND  nvl(:OLD.authorization_status,'$') <>  'APPROVED' ) THEN

      JAI_PO_RA_TRIGGER_PKG.ARU_T1 (
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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_RA_ARIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_RA_ARIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_PO_RA_ARIUD_T1" DISABLE;
