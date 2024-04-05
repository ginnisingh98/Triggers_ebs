--------------------------------------------------------
--  DDL for Trigger XTR_AU_ROLLOVER_TRANSACTIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_ROLLOVER_TRANSACTIONS_T" 
 AFTER UPDATE on "XTR"."XTR_ROLLOVER_TRANSACTIONS"
 FOR EACH ROW

declare
  L_ACTION 		VARCHAR2(10);
  L_AMOUNT 		NUMBER;
  L_START_DATE 		DATE;
  L_DEAL_NUMBER		NUMBER;
  L_TRANSACTION_NUMBER	NUMBER;
  L_YEAR_CALC_TYPE	VARCHAR2(15);
  L_CALC_BASIS 		VARCHAR2(15);
  L_INTEREST_RATE	NUMBER;
  L_YEAR_BASIS		NUMBER;
  L_DEAL_SUBTYPE 	VARCHAR2(7);
  L_STATUS_CODE		VARCHAR2(10);
  L_PRODUCT_TYPE	VARCHAR2(10);
  L_PORTFOLIO_CODE	VARCHAR2(7);
  L_CPARTY_CODE		VARCHAR2(7);
  L_MATURITY_DATE	DATE;
  L_NO_OF_DAYS          NUMBER;
  L_YIELD_RATE		NUMBER;
  L_SETTLE_DATE		DATE;
  L_INTEREST		NUMBER;
  L_MATURITY_AMT	NUMBER;
  L_START_AMOUNT	NUMBER;

 -- For Interest Override feature
 -- Added day_count_type to get_year_calc_type
 --
 cursor get_year_calc_type is
  select year_calc_type,year_basis,calc_basis,day_count_type
   from xtr_deals
   where deal_no=L_DEAL_NUMBER;

 -- For Interest Override feature
 -- Added the new variables.
 -- Added new cursor for other deals than RTMM and NI.
 L_DAY_COUNT_TYPE	VARCHAR2(1) := NULL;
 L_FIRST_TRANS_FLAG	VARCHAR2(4) := NULL;

 cursor get_types is
  select day_count_type
  from	 xtr_deals
  where  deal_no=L_DEAL_NUMBER;
 --
--
begin

 if :NEW.STATUS_CODE = 'CANCELLED' then
  update XTR_ACCRLS_AMORT
   set REVERSAL_DATE = trunc(sysdate)
   where DEAL_NO = :NEW.DEAL_NUMBER
   and TRANS_NO = :NEW.TRANSACTION_NUMBER
   and DEAL_TYPE = :NEW.DEAL_TYPE
   and  TRANSFERED_ON is NOT NULL;
  if SQL%NOTFOUND then
   delete from XTR_ACCRLS_AMORT
    where DEAL_NO = :NEW.DEAL_NUMBER
    and TRANS_NO = :NEW.TRANSACTION_NUMBER
    and DEAL_TYPE = :NEW.DEAL_TYPE
    and TRANSFERED_ON is NULL;
   end if;
 end if;

if (:OLD.COMPANY_CODE <> :NEW.COMPANY_CODE or
   :OLD.CPARTY_CODE <> :NEW.CPARTY_CODE or
   :OLD.DEAL_SUBTYPE <> :NEW.DEAL_SUBTYPE or
   :OLD.PRODUCT_TYPE <> :NEW.PRODUCT_TYPE or
   :OLD.PORTFOLIO_CODE <> :NEW.PORTFOLIO_CODE or
   :OLD.CURRENCY <> :NEW.CURRENCY or
   nvl(:OLD.YEAR_CALC_TYPE,'@#@') <> nvl(:NEW.YEAR_CALC_TYPE,'@#@') or
   nvl(:OLD.BALANCE_OUT,0) <> nvl(:NEW.BALANCE_OUT,0) or
   nvl(:OLD.BALANCE_OUT_BF,0) <> nvl(:NEW.BALANCE_OUT_BF,0) or
   nvl(:OLD.PRINCIPAL_ADJUST,0) <> nvl(:NEW.PRINCIPAL_ADJUST,0) or
   nvl(:OLD.INTEREST_RATE,0) <> nvl(:NEW.INTEREST_RATE,0) or
   nvl(:OLD.INTEREST,0) <> nvl(:NEW.INTEREST,0) or
   :OLD.STATUS_CODE <> :NEW.STATUS_CODE ) then

   L_ACTION := NULL;
   L_INTEREST_RATE :=:NEW.INTEREST_RATE;
   L_YEAR_CALC_TYPE :=:NEW.YEAR_CALC_TYPE;
   L_START_DATE :=:NEW.START_DATE;
   L_STATUS_CODE :=:NEW.STATUS_CODE;
   L_DEAL_SUBTYPE :=:NEW.DEAL_SUBTYPE;
   L_PRODUCT_TYPE :=:NEW.PRODUCT_TYPE;
   L_PORTFOLIO_CODE :=:NEW.PORTFOLIO_CODE;
   L_CPARTY_CODE :=:NEW.CPARTY_CODE;
   L_DEAL_NUMBER :=:NEW.DEAL_NUMBER;
   L_TRANSACTION_NUMBER :=:NEW.TRANSACTION_NUMBER;
   L_MATURITY_DATE :=:NEW.MATURITY_DATE;
   L_NO_OF_DAYS   := :NEW.NO_OF_DAYS;

   if :NEW.DEAl_TYPE in('TMM','RTMM') then
      if :OLD.STATUS_CODE <> :NEW.STATUS_CODE
         and :NEW.STATUS_CODE <> 'CURRENT' then
          L_ACTION :='DELETE';
      else
          L_ACTION :='UPDATE';
      end if;

      if nvl(:NEW.PRINCIPAL_ACTION,'@#@')='DECRSE' then
         L_AMOUNT :=nvl(:NEW.BALANCE_OUT_BF,0)-nvl(:NEW.PRINCIPAL_ADJUST,0);
      else
         L_AMOUNT :=nvl(:NEW.BALANCE_OUT_BF,0)+nvl(:NEW.PRINCIPAL_ADJUST,0);
      end if;

      if :NEW.DEAL_TYPE = 'RTMM' then
          open get_year_calc_type;
          fetch get_year_calc_type into L_YEAR_CALC_TYPE,L_YEAR_BASIS,
                                        L_CALC_BASIS,
					L_DAY_COUNT_TYPE; -- Adde for Interest Override
   	  close get_year_calc_type;
      -- Added for Interest Override feature
      elsif :NEW.DEAL_TYPE = 'TMM' then
	 open get_types;
	 fetch get_types into L_DAY_COUNT_TYPE;
	 close get_types;
      end if;

      if :NEW.TRANSACTION_NUMBER =1 and L_DAY_COUNT_TYPE ='B' then
	L_FIRST_TRANS_FLAG :='Y';
      else
	L_FIRST_TRANS_FLAG := null;
      end if;
      --
   elsif :NEW.DEAL_TYPE ='ONC' then
      -- Added for Interest Override feature
      open get_types;
      fetch get_types into L_DAY_COUNT_TYPE;
      close get_types;
      L_FIRST_TRANS_FLAG := :NEW.FIRST_TRANSACTION_FLAG;
      --
      if :OLD.STATUS_CODE <> :NEW.STATUS_CODE
         and :NEW.STATUS_CODE <> 'CURRENT' then
          L_ACTION :='DELETE';
      else
        -- Added for Interest Override
	 L_ACTION :='UPDATE';
	--
      end if;
       L_AMOUNT :=nvl(:NEW.BALANCE_OUT,0);

   elsif :NEW.DEAL_TYPE ='NI' and :NEW.DEAL_SUBTYPE in ('BUY', 'ISSUE') then
      if (:OLD.STATUS_CODE <> :NEW.STATUS_CODE
          or (:OLD.NI_RENEG_DATE is null and :NEW.NI_RENEG_DATE is not null ))
         -- NEW NI --
         and :NEW.DEAL_SUBTYPE not in ('SHORT', 'SELL')
-- bug 4304543 Modified 'not equal to '  to '>='  below
         and nvl(:NEW.NI_RENEG_DATE,:NEW.MATURITY_DATE) >=  :NEW.START_DATE  then
         L_AMOUNT :=nvl(:NEW.BALANCE_OUT,0) - nvl(:NEW.INTEREST, 0);
         L_START_DATE :=:NEW.START_DATE;
         L_MATURITY_DATE :=nvl(:NEW.NI_RENEG_DATE,:NEW.MATURITY_DATE);
         L_DEAL_NUMBER :=:NEW.DEAL_NUMBER;
         open get_year_calc_type;
         fetch get_year_calc_type into L_YEAR_CALC_TYPE,L_YEAR_BASIS,
                                       L_CALC_BASIS,
				       L_DAY_COUNT_TYPE; -- Added for Interest Override
         close get_year_calc_type;

/*
         if :OLD.STATUS_CODE <> :NEW.STATUS_CODE then
            L_ACTION :='UPDATE';
            L_STATUS_CODE :=:NEW.STATUS_CODE;  */
         -- NEW NI --
      /*   elsif :OLD.DEAL_SUBTYPE = 'SHORT' then -- elsif :OLD.DEAL_SUBTYPE = 'S_SELL' then
            L_ACTION :='INSERT';
            L_STATUS_CODE :=:OLD.STATUS_CODE;  */
         -- NEW NI --
   /*      elsif :OLD.DEAL_SUBTYPE = 'ISSUE' then
            L_ACTION :='DELETE';
            L_STATUS_CODE :=:NEW.STATUS_CODE;
         end if;  */

        if :OLD.STATUS_CODE <> :NEW.STATUS_CODE
         and :NEW.STATUS_CODE <> 'CURRENT' then
          L_ACTION :='DELETE';
          L_STATUS_CODE :=:NEW.STATUS_CODE;
        else
          L_ACTION :='UPDATE';
          L_STATUS_CODE :=:NEW.STATUS_CODE;
        end if;
     -- Added for Interest Override
     elsif :OLD.INTEREST <> :NEW.INTEREST then
         L_MATURITY_DATE :=nvl(:NEW.NI_RENEG_DATE,:NEW.MATURITY_DATE);
         L_AMOUNT :=nvl(:NEW.BALANCE_OUT,0) - nvl(:NEW.INTEREST, 0);
	 L_FIRST_TRANS_FLAG :='Y';
	 open get_year_calc_type;
         fetch get_year_calc_type into L_YEAR_CALC_TYPE,L_YEAR_BASIS,
                                       L_CALC_BASIS,
				       L_DAY_COUNT_TYPE;
         close get_year_calc_type;
	 L_ACTION :='UPDATE';
     --
     end if;
   end if;

 if L_ACTION is NOT NULL  then
      XTR_COF_P.MAINTAIN_POSITION_HISTORY(
        P_START_DATE                  => L_START_DATE,
        P_MATURITY_DATE               => L_MATURITY_DATE,
        P_OTHER_DATE                  => NULL,
        P_DEAL_NUMBER                 => L_DEAL_NUMBER,
        P_TRANSACTION_NUMBER          => L_TRANSACTION_NUMBER,
        P_COMPANY_CODE                => :NEW.COMPANY_CODE,
        P_CURRENCY                    => :NEW.CURRENCY,
        P_DEAL_TYPE                   => :NEW.DEAl_TYPE,
        P_DEAL_SUBTYPE                => L_DEAL_SUBTYPE,
        P_PRODUCT_TYPE                => L_PRODUCT_TYPE,
        P_PORTFOLIO_CODE              => L_PORTFOLIO_CODE,
        P_CPARTY_CODE                 => L_CPARTY_CODE,
        P_CONTRA_CCY                  => NULL,
        P_CURRENCY_COMBINATION        => NULL,
        P_ACCOUNT_NO                  => NULL,
        P_TRANSACTION_RATE            => L_INTEREST_RATE,
        P_YEAR_CALC_TYPE              => L_YEAR_CALC_TYPE,
        P_BASE_REF_AMOUNT             => L_AMOUNT,
        P_BASE_RATE                   => NULL,
        P_STATUS_CODE                 => L_STATUS_CODE,
        P_INTEREST                    => :NEW.INTEREST,
        P_MATURITY_AMOUNT             => NULL,
        P_START_AMOUNT                => NULL,
        P_CALC_BASIS                  => L_CALC_BASIS,
        P_CALC_TYPE                   => NULL,
        P_ACTION                      => L_ACTION,
	-- Added for Interest Override feature
	P_DAY_COUNT_TYPE	      => L_DAY_COUNT_TYPE,
	P_FIRST_TRANS_FLAG	      => L_FIRST_TRANS_FLAG
	);
  end if;
end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_ROLLOVER_TRANSACTIONS_T" ENABLE;
