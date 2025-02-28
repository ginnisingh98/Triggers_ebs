--------------------------------------------------------
--  DDL for Trigger XTR_AU_DEAL_DATE_AMOUNTS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_DEAL_DATE_AMOUNTS_T" 
 AFTER UPDATE on "XTR"."XTR_DEAL_DATE_AMOUNTS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT(p_event varchar2) is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = p_event;

   cursor GET_LIMIT_RELEASE_TYPE IS
 select param_value from  xtr_pro_param where
param_name = 'RELEASE_LIMIT_UTIL';
 --
 l_val VARCHAR2(1);
 --
 lv_sqlcode  number;
 lv_sqlerrm  varchar2(250);
 v_action varchar2(6);
 L_SYS_DATE			DATE;
 -- ER 6449996 Start
 L_RELEASE_TYPE    XTR_PRO_PARAM.PARAM_VALUE%TYPE;
 -- ER 6449996 End
--
begin
-- ER 6449996 Start
open GET_LIMIT_RELEASE_TYPE ;
 fetch GET_LIMIT_RELEASE_TYPE into L_RELEASE_TYPE ;
 close GET_LIMIT_RELEASE_TYPE;
 if L_RELEASE_TYPE = 'ON_MATURITY' then
 L_SYS_DATE :=trunc(sysdate)+1;
 else
 L_SYS_DATE :=trunc(sysdate);
 end if;
-- ER 6449996 End
 if :NEW.DEAL_TYPE = 'TMM' and nvl(:OLD.SETTLE,'N') = 'N'
  and :NEW.SETTLE = 'Y' and :NEW.AMOUNT_TYPE = 'INTSET' then
  update XTR_ROLLOVER_TRANSACTIONS
   set TRANS_CLOSEOUT_NO = :NEW.TRANSACTION_NUMBER
   where DEAL_NUMBER = :NEW.DEAL_NUMBER
   and START_DATE <= (select START_DATE
		      from XTR_ROLLOVER_TRANSACTIONS
		      where deal_number = :NEW.DEAL_NUMBER
		      and TRANSACTION_NUMBER = :NEW.TRANSACTION_NUMBER)
   and TRANS_CLOSEOUT_NO is NULL;
 elsif :NEW.DEAL_TYPE = 'TMM' and nvl(:OLD.SETTLE,'N') = 'Y'
  and nvl(:NEW.SETTLE,'N') = 'N' and :NEW.AMOUNT_TYPE = 'INTSET' then
  update XTR_ROLLOVER_TRANSACTIONS
   set TRANS_CLOSEOUT_NO = NULL
   where DEAL_NUMBER = :NEW.DEAL_NUMBER
   and TRANS_CLOSEOUT_NO = :NEW.TRANSACTION_NUMBER;
 end if;
 -- Check that Audit on this table has been specified
 open CHK_AUDIT('SETTLEMENTS');
  fetch CHK_AUDIT INTO l_val;
 if CHK_AUDIT%NOTFOUND then
  l_val := 'N';
 end if;
 close CHK_AUDIT;
 -- Copy to Audit Table the Pre-Updated row
 if nvl(upper(l_val),'N') = 'Y' then
   INSERT INTO XTR_A_DEAL_DATE_AMOUNTS(
      DEAL_TYPE, AMOUNT_TYPE, DATE_TYPE, DEAL_NUMBER,
      TRANSACTION_DATE, CURRENCY, AMOUNT, HCE_AMOUNT,
      AMOUNT_DATE, TRANSACTION_RATE, CASHFLOW_AMOUNT,
      COMPANY_CODE, ACCOUNT_NO, CPARTY_ACCOUNT_NO,
      CHQ_REQD, ACTION_CODE, TRANSACTION_NUMBER,
      JOURNAL_CREATED, DIARY_NOTE, AUTHORISED,
      DIRECT_DEBIT, TRANS_MTS, SETTLE, DEAL_SUBTYPE,
      PRODUCT_TYPE, LIMIT_CODE, STATUS_CODE,
      CLIENT_CODE, CPARTY_CODE, PORTFOLIO_CODE,
      DIARY_CREATED_BY, DEAL_ORDERS, DEALER_CODE,
      DUAL_AUTHORISATION_BY, MULTIPLE_SETTLEMENTS,
      MULTIPLE_REFERENCE_NUMBER, SETTLEMENT_NUMBER,
      SETTLEMENT_AUTHORISED_BY, SETTLEMENT_PARTY, COMMENTS,
      CLIENT_BROKER_CLRACCT, EXP_SETTLE_REQD,
      LIMIT_PARTY, DUAL_AUTHORISATION_ON, ARCHIVE_DATE,
      ARCHIVE_BY, CONTRACT_CODE, NETOFF_NUMBER,
      BENEFICIARY_PARTY, UPDATED_ON, UPDATED_BY,BENEFICIARY_ACCOUNT_NO,
      AUDIT_INDICATOR , CODE_COMBINATION_ID, RECONCILED_DAYS_ADJUST,
      RECONCILED_PASS_CODE, RECONCILED_REFERENCE, SERIAL_REFERENCE,
      AUDIT_DATE_STORED,CREATED_ON, CREATED_BY
      ) VALUES (
      :old.DEAL_TYPE, :old.AMOUNT_TYPE, :old.DATE_TYPE, :old.DEAL_NUMBER,
      :old.TRANSACTION_DATE, :old.CURRENCY, :old.AMOUNT, :old.HCE_AMOUNT,
      :old.AMOUNT_DATE, :old.TRANSACTION_RATE, :old.CASHFLOW_AMOUNT,
      :old.COMPANY_CODE, :old.ACCOUNT_NO, :old.CPARTY_ACCOUNT_NO,
      :old.CHQ_REQD, :old.ACTION_CODE, :old.TRANSACTION_NUMBER,
      :old.JOURNAL_CREATED, :old.DIARY_NOTE, :old.AUTHORISED,
      :old.DIRECT_DEBIT, :old.TRANS_MTS, :old.SETTLE, :old.DEAL_SUBTYPE,
      :old.PRODUCT_TYPE, :old.LIMIT_CODE, :old.STATUS_CODE,
      :old.CLIENT_CODE, :old.CPARTY_CODE, :old.PORTFOLIO_CODE,
      :old.DIARY_CREATED_BY, :old.DEAL_ORDERS, :old.DEALER_CODE,
      :old.DUAL_AUTHORISATION_BY, :old.MULTIPLE_SETTLEMENTS,
      :old.MULTIPLE_REFERENCE_NUMBER, :old.SETTLEMENT_NUMBER,
      :old.SETTLEMENT_AUTHORISED_BY, :old.SETTLEMENT_PARTY, :old.COMMENTS,
      :old.CLIENT_BROKER_CLRACCT, :old.EXP_SETTLE_REQD,
      :old.LIMIT_PARTY, :old.DUAL_AUTHORISATION_ON, :old.ARCHIVE_DATE,
      :old.ARCHIVE_BY, :old.CONTRACT_CODE, :old.NETOFF_NUMBER,
      :old.BENEFICIARY_PARTY, sysdate, :old.UPDATED_BY,:old.BENEFICIARY_ACCOUNT_NO,
      :old.AUDIT_INDICATOR,:old.CODE_COMBINATION_ID,:old.RECONCILED_DAYS_ADJUST,
      :old.RECONCILED_PASS_CODE, :old.RECONCILED_REFERENCE, :old.SERIAL_REFERENCE,
      to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY HH24:MI:SS'),
      :old.CREATED_ON, :old.CREATED_BY);
 end if;
-- ER 6449996 added one more condition
 if ((:old.LIMIT_CODE is NOT NULL or :new.LIMIT_CODE is NOT NULL) and :new.amount_date >=L_SYS_DATE ) then

    v_action := 'UPDATE';
   -- Now update mirror copy of DDA records where limit_type not null.
   xtr_limits_p.MIRROR_DDA_LIMIT_ROW_PROC
	   (v_action,:old.LIMIT_CODE,:old.DEAL_NUMBER,
	    :old.TRANSACTION_NUMBER,:new.PRODUCT_TYPE,
	    :new.COMPANY_CODE,nvl(:new.LIMIT_PARTY,:new.CPARTY_CODE),
	    :new.LIMIT_CODE,:new.AMOUNT_DATE,:new.AMOUNT,
	    :new.HCE_AMOUNT,:new.DEALER_CODE,:new.DEAL_NUMBER,
	    :new.DEAL_TYPE,:new.TRANSACTION_NUMBER,:new.DEAL_SUBTYPE,
	    :new.PORTFOLIO_CODE,:new.STATUS_CODE,:new.CURRENCY,
          :new.AMOUNT_TYPE,:new.TRANSACTION_RATE,:NEW.CURRENCY_COMBINATION,
          :new.ACCOUNT_NO,:new.COMMENCE_DATE);
end if;

end;
/
ALTER TRIGGER "APPS"."XTR_AU_DEAL_DATE_AMOUNTS_T" ENABLE;
