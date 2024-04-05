--------------------------------------------------------
--  DDL for Trigger XTR_AI_DEALS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AI_DEALS_T" 
 AFTER INSERT on "XTR"."XTR_DEALS"
 FOR EACH ROW
declare
--
cursor GET_COM(P_CURRENCY_BUY varchar2,P_CURRENCY_SELL varchar2) is
 select CURRENCY_FIRST||'/'||CURRENCY_SECOND
  from XTR_BUY_SELL_COMBINATIONS
  where (CURRENCY_BUY = P_CURRENCY_BUY and CURRENCY_SELL = P_CURRENCY_SELL)
  or (CURRENCY_BUY = P_CURRENCY_SELL and CURRENCY_SELL = P_CURRENCY_BUY);

cursor GET_BOND_TYPE(P_BOND_ISSUE VARCHAR2) is
select year_calc_type, calc_type
from XTR_BOND_ISSUES B
where bond_issue_code = p_bond_issue;

--
 l_combin VARCHAR2(31);

 date_created 	date;
 l_action_type 	varchar2(50);
 l_amount 	number;
 l_currency 	varchar2(15);
 l_contra_ccy 	varchar2(15);
 l_org_flag 	varchar2(1);
 l_start_date	 DATE;
 l_maturity_date DATE;
 l_year_calc_type VARCHAR2(15);
 l_calc_type     VARCHAR2(15);
 l_transaction_rate	NUMBER;
 -- Added for Interest Override feature
 l_day_count_type VARCHAR2(1) := NULL;
 l_first_trans_flag VARCHAR2(1) := NULL;
 --
--
begin
xtr_debug_pkg.debug('Before XTR_AI_DEALS_T on:'||to_char(sysdate,'MM:DD:HH24:MI:SS'));

IF :NEW.DEAL_TYPE = 'FX' and NVL(:NEW.QUICK_INPUT, 'N') = 'Y' THEN
   NULL;    -- Confirmation and DDA should not be done for incomplete quick deals bug 1577055
ELSE

 XTR_MAINTAIN_DDA_P.MAINTAIN_DDA_PROC(
            'INSERT',
            :NEW.DEAL_TYPE,
            :NEW.DEAL_NO,
            :NEW.DEAL_NO,
            :NEW.STATUS_CODE,
            :NEW.DEAL_SUBTYPE,
            :NEW.COMPANY_CODE,
            :NEW.CPARTY_CODE,
            :NEW.CLIENT_CODE,
            :NEW.LIMIT_CODE,
            :NEW.PRODUCT_TYPE,
            :NEW.PORTFOLIO_CODE,
            :NEW.CURRENCY,
        	:NEW.CURRENCY_BUY,
   	    	:NEW.CURRENCY_SELL,
            :NEW.SWAP_DEPO_FLAG,
            :NEW.DEALER_CODE,
            :NEW.DEAL_DATE,
            :NEW.START_DATE,
            :NEW.MATURITY_DATE,
            :NEW.INTEREST_RATE,
            :NEW.FACE_VALUE_AMOUNT,
            :NEW.FACE_VALUE_HCE_AMOUNT,
		:NEW.CPARTY_ACCOUNT_NO,
            :OLD.CPARTY_ACCOUNT_NO,
		:NEW.SETTLE_ACCOUNT_NO,
            :OLD.SETTLE_ACCOUNT_NO,
            :NEW.SETTLE_ACTION,
		:NEW.SETTLE_AMOUNT,
            :NEW.SETTLE_HCE_AMOUNT,
            :NEW.SETTLE_RATE,
            :NEW.EXERCISE_PRICE,
            :NEW.SETTLE_DATE,
		:NEW.PREMIUM_ACTION,
            :NEW.PREMIUM_DATE,
            :NEW.PREMIUM_AMOUNT,
		:NEW.PREMIUM_HCE_AMOUNT,
            :NEW.PREMIUM_ACCOUNT_NO,
            :OLD.PREMIUM_ACCOUNT_NO,
		:NEW.TRANSACTION_RATE,
		:NEW.INSERT_FOR_CASHFLOW,
 		:NEW.KNOCK_TYPE,
		:NEW.KNOCK_INSERT_TYPE,
		:NEW.SELL_AMOUNT,
		:NEW.BUY_AMOUNT,
		:NEW.SELL_HCE_AMOUNT,
		:NEW.BUY_HCE_AMOUNT,
		:NEW.SELL_ACCOUNT_NO,
            :OLD.SELL_ACCOUNT_NO,
		:NEW.BUY_ACCOUNT_NO,
            :OLD.BUY_ACCOUNT_NO,
		:NEW.VALUE_DATE,
		:NEW.EXPIRY_DATE,
		:NEW.OPTION_COMMENCEMENT,
		:NEW.COMMENTS,
		'@#@',
            :NEW.QUICK_INPUT,
		:NEW.START_AMOUNT,
		:NEW.START_HCE_AMOUNT,
		:NEW.MATURITY_AMOUNT,
		:NEW.MATURITY_HCE_AMOUNT,
		:NEW.MATURITY_ACCOUNT_NO,
            :OLD.MATURITY_ACCOUNT_NO,
		:NEW.MATURITY_BALANCE_AMOUNT,
		:NEW.MATURITY_BALANCE_HCE_AMOUNT,
		:NEW.INTEREST_AMOUNT,
		:NEW.INTEREST_HCE_AMOUNT,
		:NEW.RISKPARTY_LIMIT_CODE,
		:NEW.RISKPARTY_CODE,
		:NEW.BOND_ISSUE,
		:NEW.COUPON_ACTION,
		:NEW.ACCRUED_INTEREST_PRICE,
		:NEW.CUM_COUPON_DATE,
		:NEW.NEXT_COUPON_DATE,
		:NEW.COUPON_RATE,
		:NEW.FREQUENCY,
		:NEW.ACCEPTOR_CODE,
		:NEW.CAPITAL_PRICE,
		:NEW.PREMIUM_CURRENCY,
		:NEW.CONTRACT_RATE,
		:NEW.CONTRACT_COMMISSION,
		:NEW.CONTRACT_FEES,
            :NEW.BASE_RATE,
            :NEW.NI_PROFIT_LOSS,
            :NEW.RATE_FIXING_DATE);
  date_created := trunc(sysdate);
  l_org_flag :='Y';
  l_currency :=:NEW.CURRENCY;
  if nvl(:NEW.deal_type,'^') = 'FX' then
     if :NEW.FXD_DEAL_NO is not null then
       l_action_type := 'FX_CONTRACT_SWAP';
     elsif :NEW.FX_PD_DEAL_NO is not null
        and :NEW.DISCOUNT is null then
        l_action_type := 'PREDELIVERY_OF_FX_CONTRACT';
     elsif :NEW.FX_RO_DEAL_NO is not null then
        -- commented this condition bug 7649189 and :NEW.DISCOUNT is null
        l_action_type := 'ROLLOVER_OF_FX_CONTRACT';
     elsif :NEW.FX_RO_DEAL_NO is null and
           :NEW.FXD_DEAL_NO is null then
        l_action_type :='NEW_FX_CONTRACT';
        if nvl(:NEW.SYNTHETIC_PRINTED_YN,'Y')='U' then
           l_org_flag :='U';
        end if;
      end if;
      l_amount :=:NEW.BUY_AMOUNT;
      l_currency :=:NEW.CURRENCY_BUY;
  elsif  nvl(:NEW.deal_type,'^') ='FXO'  then
        l_action_type :='NEW_FXO_CONTRACT';
       if nvl(:NEW.SYNTHETIC_PRINTED_YN,'Y')='U' then
          l_org_flag :='U';
       end if;
        l_amount :=:NEW.BUY_AMOUNT;
        l_currency :=:NEW.CURRENCY_BUY;
  elsif  nvl(:NEW.deal_type,'^') ='FRA'  then
        l_action_type :='NEW_FRA_CONTRACT';
        l_amount :=:NEW.FACE_VALUE_AMOUNT;
  elsif  nvl(:NEW.deal_type,'^') ='IRO'  then
          l_action_type :='NEW_IRO_CONTRACT';
          l_amount := nvl(:NEW.FACE_VALUE_AMOUNT,
                          :NEW.MATURITY_AMOUNT);
  elsif  nvl(:NEW.deal_type,'^') ='BDO'  then
          l_action_type :='NEW_BOND_OPTION_CONTRACT';
          l_amount :=:NEW.FACE_VALUE_AMOUNT;
  elsif  nvl(:NEW.deal_type,'^') ='NI'  then
        l_action_type :='NEW_NI_CONTRACT';
        l_amount :=:NEW.MATURITY_AMOUNT;
  elsif  nvl(:NEW.deal_type,'^') ='BOND'  then
        l_action_type :='NEW_BOND_CONTRACT';
        l_amount :=:NEW.MATURITY_AMOUNT;
  elsif  nvl(:NEW.deal_type,'^') ='IRS'  and :NEW.deal_subtype = 'FUND' then
        l_action_type :='NEW_INT_RATE_SWAP_CONTRACT';
        l_amount :=:NEW.FACE_VALUE_AMOUNT;
  elsif  nvl(:NEW.deal_type,'^') ='SWPTN' then
        l_action_type :='NEW_SWAPTION_CONTRACT';
        l_amount :=:NEW.FACE_VALUE_AMOUNT;
  elsif  nvl(:NEW.deal_type,'^') ='RTMM' then
        l_action_type :='NEW_RETAIL_TERM_CONTRACT';
        l_amount :=:NEW.FACE_VALUE_AMOUNT;
  elsif  nvl(:NEW.deal_type,'^') ='TMM' then
        l_action_type :='NEW_WHOLESALE_TERM_CONTRACT';
        l_amount :=:NEW.FACE_VALUE_AMOUNT;
  end if;
if l_action_type is not null and nvl(:NEW.quick_input,'N') <>'Y'  then
 -- Execute procedure deal actions
  XTR_MISC_P.DEAL_ACTIONS
   (:NEW.deal_type,:NEW.deal_no,null,l_action_type,:NEW.cparty_code,
   :NEW.client_code,date_created,:NEW.company_code,
   :NEW.status_code,null,:NEW.deal_subtype,l_currency,
   :NEW.cparty_advice,:NEW.client_advice,l_amount,l_org_flag );
end if;
END IF;

   /*================================================*/
   /* Insert into XTR_POSITION_HISTORY table         */
   /*================================================*/
   L_CURRENCY :=:NEW.CURRENCY;

 if :NEW.DEAL_TYPE = 'FX' then
   open GET_COM(:NEW.CURRENCY_BUY,:NEW.CURRENCY_SELL);
   fetch GET_COM into L_COMBIN;
   close GET_COM;
   L_TRANSACTION_RATE :=:NEW.TRANSACTION_RATE;
   L_YEAR_CALC_TYPE :='ACTUAL/ACTUAL';

   if :NEW.CURRENCY_BUY =substr(L_COMBIN,1,3) then
     L_AMOUNT :=:NEW.BUY_AMOUNT;
     L_CURRENCY :=:NEW.CURRENCY_BUY;
     L_CONTRA_CCY :=:NEW.CURRENCY_SELL;
   else
     L_AMOUNT :=0-:NEW.SELL_AMOUNT;
     L_CURRENCY :=:NEW.CURRENCY_SELL;
     L_CONTRA_CCY :=:NEW.CURRENCY_BUY;
   end if;
   if :NEW.DEAL_TYPE='FX' then
      L_START_DATE :=:NEW.DEAL_DATE;
      if :NEW.DEAL_DATE = :NEW.VALUE_DATE then
         L_MATURITY_DATE :=:NEW.VALUE_DATE+1;
      else
	 L_MATURITY_DATE :=:NEW.VALUE_DATE;
      end if;
   else
      L_START_DATE :=nvl(:NEW.OPTION_COMMENCEMENT,:NEW.DEAL_DATE);
      L_MATURITY_DATE :=:NEW.EXPIRY_DATE;
   end if;
 elsif :NEW.DEAL_TYPE = 'BOND' then
    L_START_DATE :=:NEW.START_DATE;
    L_MATURITY_DATE :=:NEW.MATURITY_DATE;
    L_TRANSACTION_RATE :=:NEW.INTEREST_RATE;
    L_AMOUNT :=:NEW.START_AMOUNT;
    -- Added for Interest Override feature
    L_DAY_COUNT_TYPE := :NEW.DAY_COUNT_TYPE;
    if L_DAY_COUNT_TYPE ='B' then
	L_FIRST_TRANS_FLAG :='Y';
    else
	L_FIRST_TRANS_FLAG :=null;
    end if;
    --

    /* Get year calc type from Bond Issue table */
    OPEN get_bond_type(:NEW.BOND_ISSUE);
    FETCH get_bond_type into l_year_calc_type, l_calc_type;
    CLOSE get_bond_type;

 end if;

 if (:NEW.DEAL_TYPE = 'FX') or (:NEW.DEAL_TYPE = 'BOND' and :NEW.DEAL_SUBTYPE in
     ('BUY', 'ISSUE')) then
     XTR_COF_P.MAINTAIN_POSITION_HISTORY(
        P_START_DATE                  => L_START_DATE,
        P_MATURITY_DATE               => L_MATURITY_DATE,
        P_OTHER_DATE                  => NULL,
        P_DEAL_NUMBER                 => :NEW.DEAL_NO,
        P_TRANSACTION_NUMBER          => 1,
        P_COMPANY_CODE                => :NEW.COMPANY_CODE,
        P_CURRENCY                    =>  L_CURRENCY,
        P_DEAL_TYPE                   => :NEW.DEAl_TYPE,
        P_DEAL_SUBTYPE                => :NEW.DEAL_SUBTYPE,
        P_PRODUCT_TYPE                => :NEW.PRODUCT_TYPE,
        P_PORTFOLIO_CODE              => :NEW.PORTFOLIO_CODE,
        P_CPARTY_CODE                 => :NEW.CPARTY_CODE,
        P_CONTRA_CCY                  => L_CONTRA_CCY,
        P_CURRENCY_COMBINATION        => L_COMBIN,
        P_ACCOUNT_NO                  => NULL,
        P_TRANSACTION_RATE            => L_TRANSACTION_RATE,
        P_YEAR_CALC_TYPE              => L_YEAR_CALC_TYPE,
        P_BASE_REF_AMOUNT             => L_AMOUNT,
        P_BASE_RATE                   => :NEW.BASE_RATE,
        P_STATUS_CODE                 => :NEW.STATUS_CODE,
        P_INTEREST                    => NULL,
        P_MATURITY_AMOUNT             => :NEW.MATURITY_AMOUNT,
        P_START_AMOUNT                => :NEW.START_AMOUNT,
        P_CALC_BASIS                  => NULL,
        P_CALC_TYPE                   => L_CALC_TYPE,
        P_ACTION                      => 'INSERT',
	P_DAY_COUNT_TYPE	      => L_DAY_COUNT_TYPE,
	P_FIRST_TRANS_FLAG	      => L_FIRST_TRANS_FLAG
	);
 end if;

xtr_debug_pkg.debug('After XTR_AI_DEALS_T on:'||to_char(sysdate,'MM:DD:HH24:MI:SS'));
end;
/
ALTER TRIGGER "APPS"."XTR_AI_DEALS_T" ENABLE;
