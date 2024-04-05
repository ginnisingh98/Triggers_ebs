--------------------------------------------------------
--  DDL for Trigger XTR_AU_DEALS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_DEALS_T" 
 AFTER UPDATE on "XTR"."XTR_DEALS"
 FOR EACH ROW
declare

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
 l_combin 		VARCHAR2(31);
 l_action 		VARCHAR2(10);
 l_start_date	 	DATE;
 l_maturity_date 	DATE;
 date_created 		DATE;
 l_action_type 		VARCHAR2(50);
 l_amount 		NUMBER;
 l_currency		VARCHAR2(15);
 l_contra_ccy		VARCHAR2(15);
 l_org_flag 		VARCHAR2(1);
 l_base_rate		NUMBER;
 l_year_calc_type 	VARCHAR2(15);
 l_calc_type		VARCHAR2(15);
 l_transaction_rate 	NUMBER;
--
begin
   /*================================================*/
   /* Update XTR_DEAL_DATE_AMOUNTS table             */
   /*================================================*/

  IF (
       :old.deal_subtype <> :new.deal_subtype or
       :old.product_type <> :new.product_type or
       :old.deal_type <> :new.deal_type or
       :old.portfolio_code <> :new.portfolio_code  or
       :old.status_code <> :new.status_code  or
       :old.dealer_code <> :new.dealer_code  or
       :old.client_code <> :new.client_code  or
       :old.cparty_code <> :new.cparty_code  or
       :old.limit_code <> :new.limit_code  or
       :old.company_code <> :new.company_code  or
       :old.riskparty_code <> :new.riskparty_code or
       :old.riskparty_limit_code <> :new.riskparty_limit_code or
       :old.deal_no <> :new.deal_no or
       :old.premium_amount <> :new.premium_amount or
       :old.buy_amount <> :new.buy_amount or
       :old.sell_amount <> :new.sell_amount or
       :old.face_value_amount <> :new.face_value_amount or
       :old.settle_amount <> :new.settle_amount or
       :old.maturity_balance_amount <> :new.maturity_balance_amount or
       :old.maturity_amount <> :new.maturity_amount or
       :old.interest_amount <> :new.interest_amount or
       :old.start_amount <> :new.start_amount or
       :old.contract_commission <> :new.contract_commission or
       :old.contract_fees <> :new.contract_fees or
       :old.exercise_price <> :new.exercise_price or
       :old.face_value_hce_amount <> :new.face_value_hce_amount or
       :old.buy_hce_amount <> :new.buy_hce_amount or
       :old.sell_hce_amount <> :new.sell_hce_amount or
       :old.premium_hce_amount <> :new.premium_hce_amount or
       :old.settle_hce_amount <> :new.settle_hce_amount or
       :old.start_hce_amount <> :new.start_hce_amount  or
       :old.maturity_hce_amount <> :new.maturity_hce_amount or
       :old.interest_hce_amount <> :new.interest_hce_amount or
       :old.maturity_balance_hce_amount <> :new.maturity_balance_hce_amount or
       :old.start_date <> :new.start_date or
       :old.maturity_date <> :new.maturity_date or
       :old.deal_date <> :new.deal_date or
       :old.rate_fixing_date <> :new.rate_fixing_date or
       :old.expiry_date <> :new.expiry_date or
       :old.premium_date <> :new.premium_date or
       :old.value_date <> :new.value_date or
       --Bug 8561305 Starts
       --:old.settle_date <> :new.settle_date or
       Nvl(:old.settle_date, To_Date('01-01-1900','DD-MM-YYYY')) <> Nvl(:new.settle_date, To_Date('01-01-1900','DD-MM-YYYY')) or
       --Bug 8561305 Ends
       :old.interest_rate <> :new.interest_rate or
       :old.settle_rate <> :new.settle_rate or
       :old.transaction_rate <> :new.transaction_rate or
       :old.contract_rate <> :new.contract_rate or
       :old.base_rate <> :new.base_rate or
       :old.currency <> :new.currency or
       :old.currency_buy <> :new.currency_buy or
       :old.currency_sell <> :new.currency_sell or
       :old.premium_currency <> :new.premium_currency or
       :old.settle_action <> :new.settle_action or
       :old.premium_action <> :new.premium_action or
       :old.cparty_account_no <> :new.cparty_account_no or
       :old.settle_account_no <> :new.settle_account_no or
       :old.buy_account_no <> :new.buy_account_no or
       :old.sell_account_no <> :new.sell_account_no or
       :old.premium_account_no <> :new.premium_account_no or
       :old.maturity_account_no <> :new.maturity_account_no or
       :old.bond_issue <> :new.bond_issue or
       :old.insert_for_cashflow <> :new.insert_for_cashflow or
       --Bug 8561305 starts
       nvl(:old.knock_type,'Z') <> nvl(:new.knock_type, 'Z') or
       nvl(:old.knock_insert_type,'Z') <> nvl(:new.knock_insert_type, 'Z') or
       --Bug 8561305 ends
       :old.ni_profit_loss <> :new.ni_profit_loss or
       :old.profit_loss <> :new.profit_loss or
       :old.fx_ro_pd_rate <> :new.fx_ro_pd_rate or
       :old.fx_m1_deal_no <> :new.fx_m1_deal_no) then

        XTR_MAINTAIN_DDA_P.MAINTAIN_DDA_PROC(
            'UPDATE',
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
		:OLD.STATUS_CODE,
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
            :NEW.RATE_FIXING_DATE,
            :NEW.PROFIT_LOSS,              /* EKL - Added for Bug 2252292. */
            :OLD.PROFIT_LOSS,              /* EKL - Added for Bug 2252292. */
            :NEW.FX_RO_PD_RATE,            /* EKL - Added for Bug 2252292. */
            :OLD.FX_RO_PD_RATE,            /* EKL - Added for Bug 2252292. */
            :NEW.FX_M1_DEAL_NO,            /* EKL - Added for Bug 2252292. */
            :OLD.FX_M1_DEAL_NO);           /* EKL - Added for Bug 2252292. */
End if;

  date_created :=sysdate;
  l_org_flag :='Y';
  if  nvl(:NEW.deal_type,'^') ='FXO'  then
      if nvl(:OLD.EXERCISE,'N')='N' and nvl(:NEW.EXERCISE,'N')='Y'
            and :NEW.FXO_DEAL_NO is not null then
        l_action_type :='EXERCISE_OF_FX_OPTION_CONTRACT';
        l_amount :=:NEW.BUY_AMOUNT;
        l_currency :=:NEW.CURRENCY_BUY;
      end if;
  elsif  nvl(:NEW.deal_type,'^') ='FRA'  then
      if :OLD.SETTLE_DATE is null and :NEW.SETTLE_DATE is not null  then
        l_action_type :='SETTLEMENT_OF_FRA_CONTRACT';
        l_amount :=:NEW.SETTLE_AMOUNT;
        l_currency :=:NEW.CURRENCY;
      end if;
  elsif  nvl(:NEW.deal_type,'^') ='IRO'  then
      if :OLD.SETTLE_DATE is null and :NEW.SETTLE_DATE is not null  then
        l_action_type :='EXERCISE_OF_IRO_CONTRACT';
        l_amount :=:NEW.SETTLE_AMOUNT;
        l_currency :=:NEW.CURRENCY;
       end if;
  elsif  nvl(:NEW.deal_type,'^') ='BDO'  then
      if (:OLD.SETTLE_DATE is null and :NEW.SETTLE_DATE is not null )
        or (nvl(:OLD.ENTER_INTO_SWAP,'N')='N' and
             nvl(:NEW.ENTER_INTO_SWAP,'N')='Y' )      then
        l_action_type :='EXERCISE_OF_BOND_OPTION_CONTRACT';
        l_amount :=:NEW.SETTLE_AMOUNT;  -----SETTLE_AMOUNT
        l_currency :=:NEW.CURRENCY;
       end if;
  elsif  nvl(:NEW.deal_type,'^') ='SWPTN'  then
      if :OLD.SETTLE_DATE is null and nvl(:OLD.ENTER_INTO_SWAP,'N') <> 'Y' and
       (:NEW.SETTLE_DATE is not null or :NEW.ENTER_INTO_SWAP = 'Y')  then
        l_action_type :='EXERCISE_OF_SWAPTION_CONTRACT';
        l_amount :=:NEW.SETTLE_AMOUNT;
        l_currency :=:NEW.CURRENCY;
      end if;
  end if;
if l_action_type is not null then
 -- Execute Stored procedure DEAL_ACTIONS
 XTR_MISC_P.DEAL_ACTIONS
  (:NEW.deal_type,:NEW.deal_no,null,l_action_type,
   :NEW.cparty_code,:NEW.client_code,date_created,
   :NEW.company_code,:NEW.status_code,null,
   :NEW.deal_subtype,l_currency,:NEW.cparty_advice,
   :NEW.client_advice,l_amount,l_org_flag);
end if;

   /*================================================*/
   /* Update XTR_POSITION_HISTORY table              */
   /*================================================*/
----for backdated COF

if (:OLD.COMPANY_CODE <> :NEW.COMPANY_CODE or
   :OLD.CPARTY_CODE <> :NEW.CPARTY_CODE or
   :OLD.DEAL_SUBTYPE <> :NEW.DEAL_SUBTYPE or
   :OLD.PRODUCT_TYPE <> :NEW.PRODUCT_TYPE or
   :OLD.PORTFOLIO_CODE <> :NEW.PORTFOLIO_CODE or
   nvl(:OLD.CURRENCY,'@#@') <> nvl(:NEW.CURRENCY,'@#@') or
   nvl(:OLD.CURRENCY_SELL,'@#@') <> nvl(:NEW.CURRENCY_SELL,'@#@') or
   nvl(:OLD.CURRENCY_BUY,'@#@') <> nvl(:NEW.CURRENCY_BUY,'@#@') or
   nvl(:OLD.YEAR_CALC_TYPE,'@#@') <> nvl(:NEW.YEAR_CALC_TYPE,'@#@') or
   nvl(:OLD.BUY_AMOUNT,0) <> nvl(:NEW.BUY_AMOUNT,0) or
   nvl(:OLD.SELL_AMOUNT,0) <> nvl(:NEW.SELL_AMOUNT,0) or
   nvl(:OLD.FACE_VALUE_AMOUNT,0) <> nvl(:NEW.FACE_VALUE_AMOUNT,0) or
  (:OLD.START_DATE is null and :NEW.START_DATE is not null) or
   nvl(:OLD.INTEREST_RATE,0) <> nvl(:NEW.INTEREST_RATE,0) or
   :OLD.STATUS_CODE <> :NEW.STATUS_CODE ) then

    L_ACTION :=NULL;

    if :NEW.DEAL_TYPE = 'FX' then
       L_YEAR_CALC_TYPE :=nvl(:NEW.YEAR_CALC_TYPE,'ACTUAL/ACTUAL');
       L_BASE_RATE :=:NEW.BASE_RATE;
       L_TRANSACTION_RATE :=:NEW.TRANSACTION_RATE;

        if :NEW.STATUS_CODE = 'CURRENT' then
          L_ACTION :='UPDATE';
        else
          L_ACTION :='DELETE';
        end if;

        open GET_COM(:NEW.CURRENCY_BUY,:NEW.CURRENCY_SELL);
        fetch GET_COM into L_COMBIN;
        close GET_COM;

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
              L_MATURITY_DATE :=nvl(:NEW.START_DATE,:NEW.VALUE_DATE);
         else
              L_MATURITY_DATE :=:NEW.EXPIRY_DATE;
           if :NEW.STATUS_CODE ='EXERCISED' then
              L_MATURITY_DATE :=nvl(:NEW.SETTLE_DATE,trunc(sysdate));
           else
              L_START_DATE :=nvl(:NEW.OPTION_COMMENCEMENT,:NEW.DEAL_DATE);
           end if;
         end if;

    elsif :NEW.DEAL_TYPE ='BOND' and (:NEW.STATUS_CODE = 'CANCELLED' and
	  :OLD.STATUS_CODE <> 'CANCELLED') then

         OPEN GET_BOND_TYPE(:NEW.BOND_ISSUE);
	 FETCH get_bond_type into l_year_calc_type, l_calc_type;
	 CLOSE get_bond_type;

          L_ACTION :='DELETE';  -- Invoke average rate only if BOND is cancelled
   	  L_START_DATE :=:NEW.START_DATE;
          L_MATURITY_DATE :=nvl(:NEW.BOND_SALE_DATE,:NEW.MATURITY_DATE);
          L_TRANSACTION_RATE :=:NEW.INTEREST_RATE;
          L_AMOUNT :=:NEW.START_AMOUNT;

     elsif :NEW.STATUS_CODE ='CANCELLED' and :OLD.STATUS_CODE <> 'CANCELLED' then
          L_ACTION :='DELETE';
     end if;

    if L_ACTION is not null and :NEW.STATUS_CODE <>'EXPIRED' and
       (:NEW.DEAL_TYPE = 'FX' or (:NEW.DEAL_TYPE = 'BOND' and L_ACTION = 'DELETE')) then

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
        P_BASE_RATE                   => L_BASE_RATE,
        P_STATUS_CODE                 => :NEW.STATUS_CODE,
        P_INTEREST                    => NULL,
        P_MATURITY_AMOUNT             => :NEW.MATURITY_AMOUNT,
        P_START_AMOUNT                => :NEW.START_AMOUNT,
        P_CALC_BASIS                  => NULL,
	P_CALC_TYPE		      => L_CALC_TYPE,
        P_ACTION                      => L_ACTION);
   end if;
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_DEALS_T" ENABLE;
