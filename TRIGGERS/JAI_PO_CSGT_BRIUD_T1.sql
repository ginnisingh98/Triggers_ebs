--------------------------------------------------------
--  DDL for Trigger JAI_PO_CSGT_BRIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_PO_CSGT_BRIUD_T1" 
BEFORE  INSERT OR UPDATE OR DELETE ON "BOM"."CST_RECONCILIATION_GTT"
FOR EACH ROW
DECLARE
  t_old_rec             CST_RECONCILIATION_GTT%rowtype ;
  t_new_rec             CST_RECONCILIATION_GTT%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;
  ln_set_of_books_id      GL_SETS_OF_BOOKS.SET_OF_BOOKS_ID%TYPE;


  CURSOR cur_get_setOfBooksId
    (cpn_operating_unit_id   HR_OPERATING_UNITS.ORGANIZATION_ID%TYPE,
     cpv_information_context HR_ORGANIZATION_INFORMATION.ORG_INFORMATION_CONTEXT%TYPE
    )
  IS
  SELECT to_number(o3.org_information3) set_of_books_id
  FROM   hr_organization_information o3
  WHERE  organization_id = cpn_operating_unit_id
  AND    o3.org_information_context = cpv_information_context;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.TRANSACTION_DATE                         := :new.TRANSACTION_DATE                              ;
    t_new_rec.AMOUNT                                   := :new.AMOUNT                                        ;
    t_new_rec.ENTERED_AMOUNT                           := :new.ENTERED_AMOUNT                                ;
    t_new_rec.QUANTITY                                 := :new.QUANTITY                                      ;
    t_new_rec.CURRENCY_CODE                            := :new.CURRENCY_CODE                                 ;
    t_new_rec.CURRENCY_CONVERSION_TYPE                 := :new.CURRENCY_CONVERSION_TYPE                      ;
    t_new_rec.CURRENCY_CONVERSION_RATE                 := :new.CURRENCY_CONVERSION_RATE                      ;
    t_new_rec.CURRENCY_CONVERSION_DATE                 := :new.CURRENCY_CONVERSION_DATE                      ;
    t_new_rec.PO_DISTRIBUTION_ID                       := :new.PO_DISTRIBUTION_ID                            ;
    t_new_rec.RCV_TRANSACTION_ID                       := :new.RCV_TRANSACTION_ID                            ;
    t_new_rec.INVOICE_DISTRIBUTION_ID                  := :new.INVOICE_DISTRIBUTION_ID                       ;
    t_new_rec.ACCRUAL_ACCOUNT_ID                       := :new.ACCRUAL_ACCOUNT_ID                            ;
    t_new_rec.TRANSACTION_TYPE_CODE                    := :new.TRANSACTION_TYPE_CODE                         ;
    t_new_rec.INVENTORY_ITEM_ID                        := :new.INVENTORY_ITEM_ID                             ;
    t_new_rec.VENDOR_ID                                := :new.VENDOR_ID                                     ;
    t_new_rec.INVENTORY_ORGANIZATION_ID                := :new.INVENTORY_ORGANIZATION_ID                     ;
    t_new_rec.WRITE_OFF_ID                             := :new.WRITE_OFF_ID                                  ;
    t_new_rec.DESTINATION_TYPE_CODE                    := :new.DESTINATION_TYPE_CODE                         ;
    t_new_rec.AE_HEADER_ID                             := :new.AE_HEADER_ID                                  ;
    t_new_rec.AE_LINE_NUM                              := :new.AE_LINE_NUM                                   ;
    t_new_rec.OPERATING_UNIT_ID                        := :new.OPERATING_UNIT_ID                             ;
    t_new_rec.BUILD_ID                                 := :new.BUILD_ID                                      ;
    t_new_rec.REQUEST_ID                               := :new.REQUEST_ID                                    ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.TRANSACTION_DATE                         := :old.TRANSACTION_DATE                              ;
    t_old_rec.AMOUNT                                   := :old.AMOUNT                                        ;
    t_old_rec.ENTERED_AMOUNT                           := :old.ENTERED_AMOUNT                                ;
    t_old_rec.QUANTITY                                 := :old.QUANTITY                                      ;
    t_old_rec.CURRENCY_CODE                            := :old.CURRENCY_CODE                                 ;
    t_old_rec.CURRENCY_CONVERSION_TYPE                 := :old.CURRENCY_CONVERSION_TYPE                      ;
    t_old_rec.CURRENCY_CONVERSION_RATE                 := :old.CURRENCY_CONVERSION_RATE                      ;
    t_old_rec.CURRENCY_CONVERSION_DATE                 := :old.CURRENCY_CONVERSION_DATE                      ;
    t_old_rec.PO_DISTRIBUTION_ID                       := :old.PO_DISTRIBUTION_ID                            ;
    t_old_rec.RCV_TRANSACTION_ID                       := :old.RCV_TRANSACTION_ID                            ;
    t_old_rec.INVOICE_DISTRIBUTION_ID                  := :old.INVOICE_DISTRIBUTION_ID                       ;
    t_old_rec.ACCRUAL_ACCOUNT_ID                       := :old.ACCRUAL_ACCOUNT_ID                            ;
    t_old_rec.TRANSACTION_TYPE_CODE                    := :old.TRANSACTION_TYPE_CODE                         ;
    t_old_rec.INVENTORY_ITEM_ID                        := :old.INVENTORY_ITEM_ID                             ;
    t_old_rec.VENDOR_ID                                := :old.VENDOR_ID                                     ;
    t_old_rec.INVENTORY_ORGANIZATION_ID                := :old.INVENTORY_ORGANIZATION_ID                     ;
    t_old_rec.WRITE_OFF_ID                             := :old.WRITE_OFF_ID                                  ;
    t_old_rec.DESTINATION_TYPE_CODE                    := :old.DESTINATION_TYPE_CODE                         ;
    t_old_rec.AE_HEADER_ID                             := :old.AE_HEADER_ID                                  ;
    t_old_rec.AE_LINE_NUM                              := :old.AE_LINE_NUM                                   ;
    t_old_rec.OPERATING_UNIT_ID                        := :old.OPERATING_UNIT_ID                             ;
    t_old_rec.BUILD_ID                                 := :old.BUILD_ID                                      ;
    t_old_rec.REQUEST_ID                               := :old.REQUEST_ID                                    ;
  END populate_old ;

  /*
  || Populate new with t_new_rec returned values
  */

  PROCEDURE populate_t_new_rec IS
  BEGIN

    :new.TRANSACTION_DATE                         := t_new_rec.TRANSACTION_DATE                              ;
    :new.AMOUNT                                   := t_new_rec.AMOUNT                                        ;
    :new.ENTERED_AMOUNT                           := t_new_rec.ENTERED_AMOUNT                                ;
    :new.QUANTITY                                 := t_new_rec.QUANTITY                                      ;
    :new.CURRENCY_CODE                            := t_new_rec.CURRENCY_CODE                                 ;
    :new.CURRENCY_CONVERSION_TYPE                 := t_new_rec.CURRENCY_CONVERSION_TYPE                      ;
    :new.CURRENCY_CONVERSION_RATE                 := t_new_rec.CURRENCY_CONVERSION_RATE                      ;
    :new.CURRENCY_CONVERSION_DATE                 := t_new_rec.CURRENCY_CONVERSION_DATE                      ;
    :new.PO_DISTRIBUTION_ID                       := t_new_rec.PO_DISTRIBUTION_ID                            ;
    :new.RCV_TRANSACTION_ID                       := t_new_rec.RCV_TRANSACTION_ID                            ;
    :new.INVOICE_DISTRIBUTION_ID                  := t_new_rec.INVOICE_DISTRIBUTION_ID                       ;
    :new.ACCRUAL_ACCOUNT_ID                       := t_new_rec.ACCRUAL_ACCOUNT_ID                            ;
    :new.TRANSACTION_TYPE_CODE                    := t_new_rec.TRANSACTION_TYPE_CODE                         ;
    :new.INVENTORY_ITEM_ID                        := t_new_rec.INVENTORY_ITEM_ID                             ;
    :new.VENDOR_ID                                := t_new_rec.VENDOR_ID                                     ;
    :new.INVENTORY_ORGANIZATION_ID                := t_new_rec.INVENTORY_ORGANIZATION_ID                     ;
    :new.WRITE_OFF_ID                             := t_new_rec.WRITE_OFF_ID                                  ;
    :new.DESTINATION_TYPE_CODE                    := t_new_rec.DESTINATION_TYPE_CODE                         ;
    :new.AE_HEADER_ID                             := t_new_rec.AE_HEADER_ID                                  ;
    :new.AE_LINE_NUM                              := t_new_rec.AE_LINE_NUM                                   ;
    :new.OPERATING_UNIT_ID                        := t_new_rec.OPERATING_UNIT_ID                             ;
    :new.BUILD_ID                                 := t_new_rec.BUILD_ID                                      ;
    :new.REQUEST_ID                               := t_new_rec.REQUEST_ID                                    ;
  END populate_t_new_rec ;

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

  OPEN  cur_get_setOfBooksId (cpn_operating_unit_id =>    :new.operating_unit_id,
                              cpv_information_context => 'Operating Unit Information'
                              );
  FETCH cur_get_setOfBooksId INTO ln_set_of_books_id;
  CLOSE cur_get_setOfBooksId;

  /*
  || make a call to the INR check package.
  */
  IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_PO_CSGT_BRIUD_T1', p_set_of_books_id =>ln_set_of_books_id) = FALSE THEN
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

      JAI_PO_CST_TRIGGER_PKG.BRI_T1 (
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

  /*
  || assign the new record values depending upon the triggering event.
  */
  IF UPDATING OR INSERTING THEN
     populate_t_new_rec;
  END IF;

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
                                      EXCEPTION_TEXT  => 'Encountered the error in trigger JAI_PO_CSGT_BRIUD_T1' || substr(sqlerrm,1,1900)
                                    );

END JAI_PO_CSGT_BRIUD_T1 ;


/
ALTER TRIGGER "APPS"."JAI_PO_CSGT_BRIUD_T1" DISABLE;
