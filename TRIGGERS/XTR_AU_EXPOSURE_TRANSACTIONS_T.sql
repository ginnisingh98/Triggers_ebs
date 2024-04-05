--------------------------------------------------------
--  DDL for Trigger XTR_AU_EXPOSURE_TRANSACTIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_EXPOSURE_TRANSACTIONS_T" 
 AFTER UPDATE on "XTR"."XTR_EXPOSURE_TRANSACTIONS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'EXPOSURE TRANSACTIONS';
 --
 l_val VARCHAR2(1);
 l_sys_date DATE;
 --
begin
 if :NEW.STATUS_CODE = 'CANCELLED' and :OLD.STATUS_CODE <> 'CANCELLED' then
  XTR_JOURNAL_PROCESS_P.UPDATE_JOURNALS(0,:NEW.TRANSACTION_NUMBER,'EXP');
 end if;
 -- Check that Audit on this table has been specified
 open CHK_AUDIT;
  fetch CHK_AUDIT INTO l_val;
 if CHK_AUDIT%NOTFOUND then
  l_val := 'N';
 end if;
 close CHK_AUDIT;

 -- Insert row into XTR_CONFIRMATION_DETAILS table if settle_action_reqd
 -- has been changed from 'N' to 'Y'
 l_sys_date :=trunc(sysdate);
 if :NEW.settle_action_reqd = 'Y'
    and :OLD.settle_action_reqd = 'N'
    and :NEW.purchasing_module = 'N'
    and nvl(:NEW.cash_position_exposure, 'N') = 'N' then

    XTR_MISC_P.DEAL_ACTIONS (:NEW.deal_type,
                             0,
                             :NEW.transaction_number,
                             'NEW_EXPOSURE_TRANSACTION',
                             :NEW.thirdparty_code,
                             null,
                             l_sys_date,
                             :NEW.company_code,
                             :NEW.status_code,
                             null,
                             :NEW.deal_subtype,
                             :NEW.currency,
                             null,
                             null,
                             :NEW.amount,
                             'Y');
 end if;

 -- Delete row from XTR_CONFIRMATION_DETAILS table if settle_action_reqd
 -- has been changed from 'Y' to 'N'
 if :NEW.settle_action_reqd = 'N'
    and :OLD.settle_action_reqd = 'Y'
    and :NEW.purchasing_module = 'N'
    and nvl(:NEW.cash_position_exposure, 'N') = 'N' then

    delete from XTR_CONFIRMATION_DETAILS
    where DEAL_TYPE = 'EXP'
    and TRANSACTION_NO = :NEW.transaction_number;
 end if;

 -- Copy to Audit Table the Pre-Updated row
 if nvl(upper(l_val),'N') = 'Y' then
   INSERT INTO XTR_A_EXPOSURE_TRANSACTIONS(
      TRANSACTION_NUMBER, COMPANY_CODE, DEAL_TYPE,
      DEAL_SUBTYPE, EXPOSURE_TYPE, CURRENCY,
      VALUE_DATE, AMOUNT, SETTLE_ACTION_REQD,
      AMOUNT_HCE, CREATED_BY, CREATED_ON, UPDATED_BY,
      UPDATED_ON, THIRDPARTY_CODE, ACTION_CODE,
      AMOUNT_TYPE, ACCOUNT_NO, COMMENTS, CPARTY_REF,
      PORTFOLIO_CODE, TAX_BROKERAGE_TYPE, ARCHIVE_DATE,
      ARCHIVE_BY, PURCHASING_MODULE, BENEFICIARY_CODE,
      NZD_AMOUNT, FIS_FOB, SUBSIDIARY_REF, STATUS_CODE,
      INTERMEDIARY_BANK_DETAILS, DEAL_STATUS,
      WHOLESALE_REFERENCE, SELECT_REFERENCE, PROFIT_LOSS,
      SELECT_ACTION, PAYMENT_AMOUNT, BALANCE, AVG_RATE,
      CONTRA_NZD_AMOUNT, CPARTY_CODE, PAYMENT_STATUS,
      AUDIT_INDICATOR, AUDIT_DATE_STORED
      ) VALUES (
      :old.TRANSACTION_NUMBER, :old.COMPANY_CODE, :old.DEAL_TYPE,
      :old.DEAL_SUBTYPE, :old.EXPOSURE_TYPE, :old.CURRENCY,
      :old.VALUE_DATE, :old.AMOUNT, :old.SETTLE_ACTION_REQD,
      :old.AMOUNT_HCE, :old.CREATED_BY, :old.CREATED_ON, :old.UPDATED_BY,
      sysdate, :old.THIRDPARTY_CODE, :old.ACTION_CODE,
      :old.AMOUNT_TYPE, :old.ACCOUNT_NO, :old.COMMENTS, :old.CPARTY_REF,
      :old.PORTFOLIO_CODE, :old.TAX_BROKERAGE_TYPE, :old.ARCHIVE_DATE,
      :old.ARCHIVE_BY, :old.PURCHASING_MODULE, :old.BENEFICIARY_CODE,
      :old.NZD_AMOUNT, :old.FIS_FOB, :old.SUBSIDIARY_REF, :old.STATUS_CODE,
      :old.INTERMEDIARY_BANK_DETAILS, :old.DEAL_STATUS,
      :old.WHOLESALE_REFERENCE, :old.SELECT_REFERENCE, :old.PROFIT_LOSS,
      :old.SELECT_ACTION, :old.PAYMENT_AMOUNT, :old.BALANCE, :old.AVG_RATE,
      :old.CONTRA_NZD_AMOUNT, :old.CPARTY_CODE, :old.PAYMENT_STATUS,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'));
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_EXPOSURE_TRANSACTIONS_T" ENABLE;
