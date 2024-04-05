--------------------------------------------------------
--  DDL for Trigger JAI_JAR_TL_ARIUD_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JAI_JAR_TL_ARIUD_T1" 
AFTER INSERT OR UPDATE OR DELETE ON "JA"."JAI_AR_TRX_LINES"
FOR EACH ROW
  /*
  REM +======================================================================+
  REM NAME          JAI_JAR_TL_ARIUD_T1
  REM
  REM DESCRIPTION   Trigger on table jai_ar_trx_lines
  REM
  REM NOTES
  REM
  REM+=======================================================================+
  REM Change History
  REM slno  Date        Name     BugNo    File Version
  REM +=======================================================================+
  REM
  REM
  REM -----------------------------------------------------------------------
  REM 1.    04-Jul-2006 aiyer    5364288  120.3
  REM -----------------------------------------------------------------------
  REM Comments:-
  REM Moved the cursor org_cur from the begining of the trigger to within the inserting and the updating  logic of the trigger
  REM This has been done so as to avoid the mutation error being faced when excise_invoice_no is updated in jai_ar_trx_lines
  REM table from trigger JAI_AR_RCTA_ARIUD_T1.
  REM
  REM -----------------------------------------------------------------------
  REM 2.    10-JUL-2007	CSahoo	 5597146  120.9
  REM -----------------------------------------------------------------------
  REM	Comments:-
  REM	modified the cursor ORG_CUR.
  REM -----------------------------------------------------------------------
  REM 3.    28-AUG-2007 brathod  6366169  120.10
  REM -----------------------------------------------------------------------
  REM first attempting to retrieve org_id from ra_customer_trx_all table, if it fails
  REM (for some scenario mutation error may occur) then attempt
  REM RA_CUST_TRX_LINE_GL_DIST_ALL table to get ORG_ID.
  REM -----------------------------------------------------------------------
  REM 4.
  REM -----------------------------------------------------------------------
  REM
  REM
  REM+======================================================================+
*/
DECLARE
  t_old_rec             JAI_AR_TRX_LINES%rowtype ;
  t_new_rec             JAI_AR_TRX_LINES%rowtype ;
  lv_return_message     VARCHAR2(2000);
  lv_return_code        VARCHAR2(100) ;
  le_error              EXCEPTION     ;
  lv_action             VARCHAR2(20)  ;

  /*CURSOR ORG_CUR IS
  SELECT ORG_ID
  FROM   RA_CUSTOMER_TRX_ALL
  WHERE  CUSTOMER_TRX_ID = :new.customer_trx_id;*/

  --commented the above org_cur cursor and added the following cursor for bug#5597146
	CURSOR ORG_CUR IS
	SELECT ORG_ID
	FROM	 RA_CUST_TRX_LINE_GL_DIST_ALL
	WHERE  CUSTOMER_TRX_ID = :new.customer_trx_id
	AND    account_class ='REC'
  AND 	 latest_rec_flag ='Y';

  V_ORG_ID RA_CUSTOMER_TRX_ALL.ORG_ID%TYPE ;

  /*
  || Here initialising the pr_new record type in the inline procedure
  ||
  */

  PROCEDURE populate_new IS
  BEGIN

    t_new_rec.CUSTOMER_TRX_LINE_ID                     := :new.CUSTOMER_TRX_LINE_ID                          ;
    t_new_rec.CUSTOMER_TRX_ID                          := :new.CUSTOMER_TRX_ID                               ;
    t_new_rec.LINE_NUMBER                              := :new.LINE_NUMBER                                   ;
    t_new_rec.INVENTORY_ITEM_ID                        := :new.INVENTORY_ITEM_ID                             ;
    t_new_rec.DESCRIPTION                              := :new.DESCRIPTION                                   ;
    t_new_rec.UNIT_CODE                                := :new.UNIT_CODE                                     ;
    t_new_rec.QUANTITY                                 := :new.QUANTITY                                      ;
    t_new_rec.UNIT_SELLING_PRICE                       := :new.UNIT_SELLING_PRICE                            ;
    t_new_rec.TAX_CATEGORY_ID                          := :new.TAX_CATEGORY_ID                               ;
    t_new_rec.LINE_AMOUNT                              := :new.LINE_AMOUNT                                   ;
    t_new_rec.TAX_AMOUNT                               := :new.TAX_AMOUNT                                    ;
    t_new_rec.TOTAL_AMOUNT                             := :new.TOTAL_AMOUNT                                  ;
    t_new_rec.GL_DATE                                  := :new.GL_DATE                                       ;
    t_new_rec.AUTO_INVOICE_FLAG                        := :new.AUTO_INVOICE_FLAG                             ;
    t_new_rec.ASSESSABLE_VALUE                         := :new.ASSESSABLE_VALUE                              ;
    t_new_rec.PAYMENT_REGISTER                         := :new.PAYMENT_REGISTER                              ;
    t_new_rec.EXCISE_INVOICE_NO                        := :new.EXCISE_INVOICE_NO                             ;
    t_new_rec.EXCISE_INVOICE_DATE                      := :new.EXCISE_INVOICE_DATE                           ;
    t_new_rec.CREATION_DATE                            := :new.CREATION_DATE                                 ;
    t_new_rec.CREATED_BY                               := :new.CREATED_BY                                    ;
    t_new_rec.LAST_UPDATE_DATE                         := :new.LAST_UPDATE_DATE                              ;
    t_new_rec.LAST_UPDATED_BY                          := :new.LAST_UPDATED_BY                               ;
    t_new_rec.LAST_UPDATE_LOGIN                        := :new.LAST_UPDATE_LOGIN                             ;
    t_new_rec.PREPRINTED_EXCISE_INV_NO                 := :new.PREPRINTED_EXCISE_INV_NO                      ;
    t_new_rec.EXCISE_EXEMPT_TYPE                       := :new.EXCISE_EXEMPT_TYPE                            ;
    t_new_rec.EXCISE_EXEMPT_REFNO                      := :new.EXCISE_EXEMPT_REFNO                           ;
    t_new_rec.EXCISE_EXEMPT_DATE                       := :new.EXCISE_EXEMPT_DATE                            ;
    t_new_rec.AR3_FORM_NO                              := :new.AR3_FORM_NO                                   ;
    t_new_rec.AR3_FORM_DATE                            := :new.AR3_FORM_DATE                                 ;
    t_new_rec.VAT_EXEMPTION_FLAG                       := :new.VAT_EXEMPTION_FLAG                            ;
    t_new_rec.VAT_EXEMPTION_TYPE                       := :new.VAT_EXEMPTION_TYPE                            ;
    t_new_rec.VAT_EXEMPTION_DATE                       := :new.VAT_EXEMPTION_DATE                            ;
    t_new_rec.VAT_EXEMPTION_REFNO                      := :new.VAT_EXEMPTION_REFNO                           ;
    t_new_rec.VAT_ASSESSABLE_VALUE                     := :new.VAT_ASSESSABLE_VALUE                          ;
    t_new_rec.OBJECT_VERSION_NUMBER                    := :new.OBJECT_VERSION_NUMBER                         ;
  END populate_new ;

  PROCEDURE populate_old IS
  BEGIN
    t_old_rec.CUSTOMER_TRX_LINE_ID                     := :old.CUSTOMER_TRX_LINE_ID                          ;
    t_old_rec.CUSTOMER_TRX_ID                          := :old.CUSTOMER_TRX_ID                               ;
    t_old_rec.LINE_NUMBER                              := :old.LINE_NUMBER                                   ;
    t_old_rec.INVENTORY_ITEM_ID                        := :old.INVENTORY_ITEM_ID                             ;
    t_old_rec.DESCRIPTION                              := :old.DESCRIPTION                                   ;
    t_old_rec.UNIT_CODE                                := :old.UNIT_CODE                                     ;
    t_old_rec.QUANTITY                                 := :old.QUANTITY                                      ;
    t_old_rec.UNIT_SELLING_PRICE                       := :old.UNIT_SELLING_PRICE                            ;
    t_old_rec.TAX_CATEGORY_ID                          := :old.TAX_CATEGORY_ID                               ;
    t_old_rec.LINE_AMOUNT                              := :old.LINE_AMOUNT                                   ;
    t_old_rec.TAX_AMOUNT                               := :old.TAX_AMOUNT                                    ;
    t_old_rec.TOTAL_AMOUNT                             := :old.TOTAL_AMOUNT                                  ;
    t_old_rec.GL_DATE                                  := :old.GL_DATE                                       ;
    t_old_rec.AUTO_INVOICE_FLAG                        := :old.AUTO_INVOICE_FLAG                             ;
    t_old_rec.ASSESSABLE_VALUE                         := :old.ASSESSABLE_VALUE                              ;
    t_old_rec.PAYMENT_REGISTER                         := :old.PAYMENT_REGISTER                              ;
    t_old_rec.EXCISE_INVOICE_NO                        := :old.EXCISE_INVOICE_NO                             ;
    t_old_rec.EXCISE_INVOICE_DATE                      := :old.EXCISE_INVOICE_DATE                           ;
    t_old_rec.CREATION_DATE                            := :old.CREATION_DATE                                 ;
    t_old_rec.CREATED_BY                               := :old.CREATED_BY                                    ;
    t_old_rec.LAST_UPDATE_DATE                         := :old.LAST_UPDATE_DATE                              ;
    t_old_rec.LAST_UPDATED_BY                          := :old.LAST_UPDATED_BY                               ;
    t_old_rec.LAST_UPDATE_LOGIN                        := :old.LAST_UPDATE_LOGIN                             ;
    t_old_rec.PREPRINTED_EXCISE_INV_NO                 := :old.PREPRINTED_EXCISE_INV_NO                      ;
    t_old_rec.EXCISE_EXEMPT_TYPE                       := :old.EXCISE_EXEMPT_TYPE                            ;
    t_old_rec.EXCISE_EXEMPT_REFNO                      := :old.EXCISE_EXEMPT_REFNO                           ;
    t_old_rec.EXCISE_EXEMPT_DATE                       := :old.EXCISE_EXEMPT_DATE                            ;
    t_old_rec.AR3_FORM_NO                              := :old.AR3_FORM_NO                                   ;
    t_old_rec.AR3_FORM_DATE                            := :old.AR3_FORM_DATE                                 ;
    t_old_rec.VAT_EXEMPTION_FLAG                       := :old.VAT_EXEMPTION_FLAG                            ;
    t_old_rec.VAT_EXEMPTION_TYPE                       := :old.VAT_EXEMPTION_TYPE                            ;
    t_old_rec.VAT_EXEMPTION_DATE                       := :old.VAT_EXEMPTION_DATE                            ;
    t_old_rec.VAT_EXEMPTION_REFNO                      := :old.VAT_EXEMPTION_REFNO                           ;
    t_old_rec.VAT_ASSESSABLE_VALUE                     := :old.VAT_ASSESSABLE_VALUE                          ;
    t_old_rec.OBJECT_VERSION_NUMBER                    := :old.OBJECT_VERSION_NUMBER                         ;
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
      -- Bug# 6366169
      -- At this point sometimes RA_CUST_TRX_LINE_GL_DIST may not have records hence first attempting RA_CUSTOMER_TRX_ALL table
      -- to get ORG_ID.  However for some senario a mutatio may occur for RA_CUSTOMER_TRX_ALL table in that case attempting
      -- RA_CUSTOMER_TRX_LINE_GL_DIST_ALL table.
      begin
        fnd_file.put_line (fnd_file.log ,'JAI:Attempting to fetch org id from ra_customer_trx_all');
        select org_id into v_org_id
        from   ra_customer_trx_all
        where customer_trx_id = :new.customer_trx_id;
        fnd_file.put_line (fnd_file.log ,'JAI:ra_customer_trx_all.org_id='||v_org_id ||' for customer_trx_id='||:new.customer_trx_id);
      exception
        when others then
        fnd_file.put_line (fnd_file.log ,'JAI:Attempt on RA_CUSTOMER_TRX_ALL Failed due to ...');
        fnd_file.put_line (fnd_file.log ,SQLERRM);
        fnd_file.put_line (fnd_file.log ,'JAI:Attempting to fetch org_id from RA_CUST_TRX_LINE_GL_DIST_ALL');
        OPEN  ORG_CUR;
        FETCH ORG_CUR INTO V_ORG_ID;
        CLOSE ORG_CUR;
        fnd_file.put_line (fnd_file.log ,'JAI:RA_CUSTOMER_TRX_LINE_GL_DIST_ALL.ORG_ID='||V_ORG_ID);
      end;
      -- End Bug# 6366169
    /*
    || make a call to the INR check package.
    */
    IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_JAR_TL_ARIUD_T1', P_ORG_ID => V_ORG_ID) = FALSE THEN
         RETURN;
    END IF;

      JAI_JAR_TL_TRIGGER_PKG.ARI_T1 (
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

    IF ( ( ( :NEW.AUTO_INVOICE_FLAG <> 'Y'    AND
            :OLD.AUTO_INVOICE_FLAG <> 'Y'
           )                                  AND
            (:NEW.Excise_Invoice_No IS NULL)  AND
            (:NEW.payment_Register  IS NULL)  AND
            (:NEW.Excise_Invoice_Date IS NULL)
         )                                    OR
         (:NEW.Customer_Trx_Id <> :OLD.Customer_Trx_Id)
       )
    THEN

      OPEN  org_cur;
      FETCH org_cur INTO v_org_id;
      CLOSE org_cur;

      /*
      || make a call to the INR check package.
      */
      IF jai_cmn_utils_pkg.check_jai_exists(P_CALLING_OBJECT => 'JAI_JAR_TL_ARIUD_T1', P_ORG_ID => V_ORG_ID) = FALSE THEN
           RETURN;
      END IF;

      JAI_JAR_TL_TRIGGER_PKG.ARU_T1 (
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
    /*
    ||Add the call to fnd_file.put_line as a part of the bug
    */
     fnd_file.put_line(fnd_file.log, lv_return_message);

     /*
     ||Start of Bug 5141293
     ||Added the call to fnd_message.set_name and set_token
     */
     fnd_message.set_name ( application => 'JA',
                            NAME        => 'JAI_ERR_DESC'
                           );

     fnd_message.set_token ( token => 'JAI_ERROR_DESCRIPTION',
                             value => lv_return_message
                           );

    app_exception.raise_exception;

  WHEN OTHERS THEN
     /*
     ||Add the call to fnd_file.put_line as a part of the bug 5104997
     */
     fnd_file.put_line(fnd_file.log, 'Encountered the error in trigger JAI_JAR_TL_ARIUD_T1' || substr(sqlerrm,1,1900));

     fnd_message.set_name ( application => 'JA',
                            NAME        => 'JAI_ERR_DESC'
                           );

     fnd_message.set_token ( token => 'JAI_ERROR_DESCRIPTION',
                             value => 'Encountered the error in trigger JAI_JAR_TL_ARIUD_T1' || substr(sqlerrm,1,1900)
                           );
    app_exception.raise_exception;
    /*
    ||End of Bug 5141293
    */

END JAI_JAR_TL_ARIUD_T1 ;

/
ALTER TRIGGER "APPS"."JAI_JAR_TL_ARIUD_T1" DISABLE;
