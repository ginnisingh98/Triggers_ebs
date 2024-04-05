--------------------------------------------------------
--  DDL for Trigger XTR_AID_DEAL_DATE_AMOUNTS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AID_DEAL_DATE_AMOUNTS_T" 
 AFTER INSERT or DELETE on "XTR"."XTR_DEAL_DATE_AMOUNTS"
 FOR EACH ROW
declare
 v_action VARCHAR2(6);
--
 L_REF_DATE			DATE;
 L_COMPANY_CODE		VARCHAR2(7);
 L_CURRENCY			VARCHAR2(15);
 L_DEAL_TYPE		VARCHAR2(7);
 L_DEAL_SUBTYPE		VARCHAR2(7);
 L_PRODUCT_TYPE		VARCHAR2(10);
 L_PORTFOLIO_CODE		VARCHAR2(10);
 L_PARTY_CODE		VARCHAR2(7);
 L_CONTRA_CCY		VARCHAR2(15);
 L_CURRENCY_COMBINATION	VARCHAR2(31);
 L_AMOUNT_DATE		DATE;
 L_DATE_LAST_SET		DATE;
 L_ACCOUNT			VARCHAR2(20);
 L_TRANSACTION_RATE	NUMBER;
 L_AMOUNT			NUMBER;
 L_AMOUNT_INDIC		NUMBER :=1;
 L_ACTION_INDIC		NUMBER;
 L_SYS_DATE			DATE;
 -- ER 6449996 Start
 L_RELEASE_TYPE    XTR_PRO_PARAM.PARAM_VALUE%TYPE;
 -- ER 6449996 End
 l_DEAL_NUMBER          NUMBER;
 l_TRANSACTION_NUMBER   NUMBER;
 l_MATURITY_DATE        DATE;

 cursor GET_ONC_MATURITY_DATE is
  select maturity_date
      from xtr_rollover_transactions
       where deal_number=l_deal_number
         and transaction_number=l_transaction_number
         and deal_type = 'ONC';

 -- ER 6449996 Start
 cursor GET_LIMIT_RELEASE_TYPE IS
 select param_value from  xtr_pro_param where
param_name = 'RELEASE_LIMIT_UTIL';
-- ER 6449996 End
begin
xtr_debug_pkg.debug('Before XTR_AID_DEAL_DATE_AMOUNTS_T on:'||to_char(sysdate,'MM:DD:HH24:MI:SS'));
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
if inserting then

-- IAC Redesign Project  3800146 code shifted to after insert trigger on XTR_INTERACCNT_TRANSFER
/* if :NEW.deal_type='IAC' and :NEW.action_code='PAY' then
  XTR_MISC_P.DEAL_ACTIONS
    (:NEW.deal_type,:NEW.deal_number,:NEW.transaction_number,'INTERACCOUNT_TRANSFER',:NEW.cparty_code,
    :NEW.client_code,L_SYS_DATE,:NEW.company_code,
    :NEW.status_code,null,:NEW.deal_subtype,:NEW.currency,
    null,null,:NEW.amount,'Y');
 end if; */

 if :NEW.LIMIT_CODE is NOT NULL then
   v_action := 'INSERT';

  if :new.deal_type='ONC' then
   L_MATURITY_DATE :=NULL;
   L_DEAL_NUMBER :=:new.DEAL_NUMBER;
   L_TRANSACTION_NUMBER :=:new.TRANSACTION_NUMBER;
   open GET_ONC_MATURITY_DATE;
   fetch GET_ONC_MATURITY_DATE into L_MATURITY_DATE;
   close GET_ONC_MATURITY_DATE;
  end if;

  if (:new.amount_date >=L_SYS_DATE
      or :new.deal_type='CA' or :new.deal_type = 'IG' --RV 2229236/2197301
      or :new.deal_type = 'STOCK' -- Bug 4401195
      or (:new.deal_type='ONC' and nvl(L_MATURITY_DATE,L_SYS_DATE)>=L_SYS_DATE)) then
   -- Now update mirror copy of DDA records where limit_type not null.
   xtr_limits_p.MIRROR_DDA_LIMIT_ROW_PROC
	   (v_action,:new.LIMIT_CODE,:new.deal_number,
	    :new.transaction_number,:new.PRODUCT_TYPE,
	    :new.COMPANY_CODE,nvl(:new.LIMIT_PARTY,:new.CPARTY_CODE),
	    :new.LIMIT_CODE,:new.AMOUNT_DATE,:new.AMOUNT,
	    :new.HCE_AMOUNT,:new.DEALER_CODE,:new.DEAL_NUMBER,
	    :new.DEAL_TYPE,:new.TRANSACTION_NUMBER,:new.DEAL_SUBTYPE,
	    :new.PORTFOLIO_CODE,:new.STATUS_CODE,:new.CURRENCY,
          :new.AMOUNT_TYPE,:new.TRANSACTION_RATE,:NEW.CURRENCY_COMBINATION,
          :new.ACCOUNT_NO,:new.COMMENCE_DATE);
  end if;
end if;
--
elsif DELETING then

 if :OLD.LIMIT_CODE is NOT NULL then
    v_action := 'DELETE';

   -- Now update mirror copy of DDA records where limit_type not null.
   xtr_limits_p.MIRROR_DDA_LIMIT_ROW_PROC
	   (v_action,:old.LIMIT_CODE,:old.deal_number,
	    :old.transaction_number,:old.PRODUCT_TYPE,
	    :old.COMPANY_CODE,nvl(:old.LIMIT_PARTY,:old.CPARTY_CODE),
	    :old.LIMIT_CODE,:old.AMOUNT_DATE,:old.AMOUNT,
	    :old.HCE_AMOUNT,:old.DEALER_CODE,:old.DEAL_NUMBER,
	    :old.DEAL_TYPE,:old.TRANSACTION_NUMBER,:old.DEAL_SUBTYPE,
	    :old.PORTFOLIO_CODE,:new.STATUS_CODE,:old.CURRENCY,
          :old.AMOUNT_TYPE,:old.TRANSACTION_RATE,:old.CURRENCY_COMBINATION,
          :old.ACCOUNT_NO,:old.COMMENCE_DATE);
 end if;
end if;
xtr_debug_pkg.debug('After XTR_AID_DEAL_DATE_AMOUNTS_T on:'||to_char(sysdate,'MM:DD:HH24:MI:SS'));
end;
/
ALTER TRIGGER "APPS"."XTR_AID_DEAL_DATE_AMOUNTS_T" ENABLE;
