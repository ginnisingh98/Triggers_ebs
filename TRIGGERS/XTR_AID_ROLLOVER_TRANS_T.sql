--------------------------------------------------------
--  DDL for Trigger XTR_AID_ROLLOVER_TRANS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AID_ROLLOVER_TRANS_T" 
 AFTER INSERT or DELETE on "XTR"."XTR_ROLLOVER_TRANSACTIONS"
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
  L_DEAL_TYPE		VARCHAR2(7);
  L_COMPANY_CODE	VARCHAR2(7);
  L_CURRENCY		VARCHAR2(15);
  L_NO_OF_DAYS          NUMBER;
  L_YIELD_RATE		NUMBER;
  L_INTEREST		NUMBER;

  -- Added for Interest Override feature
  L_DAY_COUNT_TYPE 	VARCHAR2(1) :=NULL;
  L_FIRST_TRANS_FLAG 	VARCHAR2(1) := NULL;
  --

 --Added day_count_type for Interest Override feature
 cursor get_year_calc_type is
  select year_calc_type,year_basis,calc_basis,day_count_type
   from xtr_deals
   where deal_no=L_DEAL_NUMBER;

 --Added for Intrest Override
 cursor get_types is
  select day_count_type
  from 	 xtr_deals
  where  deal_no=L_DEAL_NUMBER;
 --
--
begin

 if inserting then

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
   L_MATURITY_DATE :=nvl(:NEW.NI_RENEG_DATE,:NEW.MATURITY_DATE);
   L_AMOUNT :=:NEW.BALANCE_OUT;
   L_DEAL_TYPE :=:NEW.DEAL_TYPE;
   L_CURRENCY :=:NEW.CURRENCY;
   L_COMPANY_CODE :=:NEW.COMPANY_CODE;
   L_NO_OF_DAYS   := :NEW.NO_OF_DAYS;
   L_INTEREST     := :NEW.INTEREST;

   if L_DEAl_TYPE in('TMM','RTMM') then
      L_ACTION :='UPDATE';
      if nvl(:NEW.PRINCIPAL_ACTION,'@#@')='DECRSE' then
         L_AMOUNT :=nvl(:NEW.BALANCE_OUT_BF,0)-nvl(:NEW.PRINCIPAL_ADJUST,0);
      else
         L_AMOUNT :=nvl(:NEW.BALANCE_OUT_BF,0)+nvl(:NEW.PRINCIPAL_ADJUST,0);
      end if;

       if L_DEAL_TYPE = 'RTMM' then
          open get_year_calc_type;
          fetch get_year_calc_type into L_YEAR_CALC_TYPE,L_YEAR_BASIS,
                                        L_CALC_BASIS,
					L_DAY_COUNT_TYPE; -- Added for Interest Override
	  close get_year_calc_type;
       -- Added for Interest Override feature
       -- For the TMM, get Day count type from XTR_DEALS table
       elsif L_DEAL_TYPE = 'TMM' then
	  open get_types;
	  fetch get_types into L_DAY_COUNT_TYPE;
	  close get_types;
       end if;
       --
   elsif L_DEAL_TYPE ='NI' then
       -- NEW NI --
       if L_DEAL_SUBTYPE in ('BUY', 'ISSUE') then -- if L_DEAL_SUBTYPE <>'S_SELL' then
          L_ACTION :='INSERT';
	  L_AMOUNT :=nvl(:NEW.BALANCE_OUT,0) - nvl(:NEW.INTEREST, 0);
	  L_FIRST_TRANS_FLAG :='Y';  -- Added for Interest Override
          open get_year_calc_type;
          fetch get_year_calc_type into L_YEAR_CALC_TYPE,L_YEAR_BASIS,
                                        L_CALC_BASIS,
					L_DAY_COUNT_TYPE; -- Added for Interest Override
          close get_year_calc_type;
       end if;
   -- Added for Interest Override feature
   elsif L_DEAL_TYPE='ONC' then
	  open get_types;
	  fetch get_types into L_DAY_COUNT_TYPE;
	  close get_types;
	  L_FIRST_TRANS_FLAG := :NEW.FIRST_TRANSACTION_FLAG;
          L_ACTION :='INSERT';
   --
   else
          L_ACTION :='INSERT';
   end if;
 else
   L_INTEREST_RATE :=:OLD.INTEREST_RATE;
   L_YEAR_CALC_TYPE :=:OLD.YEAR_CALC_TYPE;
   L_START_DATE :=:OLD.START_DATE;
   L_STATUS_CODE :=:OLD.STATUS_CODE;
   L_DEAL_SUBTYPE :=:OLD.DEAL_SUBTYPE;
   L_PRODUCT_TYPE :=:OLD.PRODUCT_TYPE;
   L_PORTFOLIO_CODE :=:OLD.PORTFOLIO_CODE;
   L_CPARTY_CODE :=:OLD.CPARTY_CODE;
   L_DEAL_NUMBER :=:OLD.DEAL_NUMBER;
   L_TRANSACTION_NUMBER :=:OLD.TRANSACTION_NUMBER;
   L_MATURITY_DATE :=nvl(:OLD.NI_RENEG_DATE,:OLD.MATURITY_DATE);
   L_AMOUNT :=:OLD.BALANCE_OUT;
   L_DEAL_TYPE :=:OLD.DEAL_TYPE;
   L_CURRENCY :=:OLD.CURRENCY;
   L_COMPANY_CODE :=:OLD.COMPANY_CODE;
   L_INTEREST     :=:OLD.INTEREST;

   if L_DEAL_TYPE <> 'NI' then
      L_ACTION :='DELETE';
   end if;
 end if;

if (L_DEAL_TYPE in ('ONC','TMM','RTMM') or
   (L_DEAL_TYPE = 'NI' and L_DEAL_SUBTYPE in('BUY', 'ISSUE'))) -- Eliminate IRS deal type
    and L_ACTION is not null then
      XTR_COF_P.MAINTAIN_POSITION_HISTORY(
        P_START_DATE                  => L_START_DATE,
        P_MATURITY_DATE               => L_MATURITY_DATE,
        P_OTHER_DATE                  => NULL,
        P_DEAL_NUMBER                 => L_DEAL_NUMBER,
        P_TRANSACTION_NUMBER          => L_TRANSACTION_NUMBER,
        P_COMPANY_CODE                => L_COMPANY_CODE,
        P_CURRENCY                    => L_CURRENCY,
        P_DEAL_TYPE                   => L_DEAl_TYPE,
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
        P_INTEREST                    => L_INTEREST,
        P_MATURITY_AMOUNT             => NULL,
        P_START_AMOUNT                => NULL,
        P_CALC_BASIS                  => L_CALC_BASIS,
        P_CALC_TYPE                   => NULL,
        P_ACTION                      => L_ACTION,
	-- Added for Intrerest Override feature
	P_DAY_COUNT_TYPE 	      => L_DAY_COUNT_TYPE,
	P_FIRST_TRANS_FLAG	      => L_FIRST_TRANS_FLAG
);
end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AID_ROLLOVER_TRANS_T" ENABLE;
