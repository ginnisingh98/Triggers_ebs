--------------------------------------------------------
--  DDL for Trigger XTR_AID_BANK_BALANCE_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AID_BANK_BALANCE_T" 
 AFTER INSERT or DELETE on "XTR"."XTR_BANK_BALANCES"
 FOR EACH ROW
declare
 --
 --
 L_COMPANY_CODE 	VARCHAR2(7);
 L_CPARTY_CODE    	VARCHAR2(7);
 L_ACCOUNT_NUMBER	VARCHAR2(50);
 L_SETOFF		VARCHAR2(1);
 L_PORTFOLIO_CODE	VARCHAR2(10);
 L_YEAR_CALC_TYPE 	VARCHAR2(15);
 L_SUBTYPE	 	VARCHAR2(7);
 L_CURRENCY		VARCHAR2(15);
 L_ACTION 		VARCHAR2(10);
 L_START_DATE		DATE;
 L_AMOUNT		NUMBER;
 L_INTEREST_RATE	NUMBER;

 cursor CHK_SETOFF is
  select nvl(SETOFF_ACCOUNT_YN,'N'),PORTFOLIO_CODE,YEAR_CALC_TYPE,
         BANK_CODE,CURRENCY
    from XTR_BANK_ACCOUNTS
     where PARTY_CODE=L_COMPANY_CODE
       and ACCOUNT_NUMBER =L_ACCOUNT_NUMBER;



begin
---
if inserting then
 L_ACTION :='UPDATE';  --- for CA'cof
 L_START_DATE := :NEW.BALANCE_DATE;
 L_ACCOUNT_NUMBER :=:NEW.ACCOUNT_NUMBER;
 L_COMPANY_CODE :=:NEW.COMPANY_CODE;
 L_AMOUNT :=nvl(:NEW.BALANCE_ADJUSTMENT,0)+nvl(:NEW.STATEMENT_BALANCE,0);
 L_INTEREST_RATE :=nvl(:NEW.INTEREST_RATE,0);
else
 L_ACTION :='DELETE';
 L_START_DATE := :OLD.BALANCE_DATE;
 L_ACCOUNT_NUMBER :=:OLD.ACCOUNT_NUMBER;
 L_COMPANY_CODE :=:OLD.COMPANY_CODE;
 L_AMOUNT :=nvl(:OLD.BALANCE_ADJUSTMENT,0)+nvl(:OLD.STATEMENT_BALANCE,0);
 L_INTEREST_RATE :=nvl(:OLD.INTEREST_RATE,0);
end if;

if L_START_DATE <trunc(sysdate) then
  open CHK_SETOFF;
  fetch CHK_SETOFF into L_SETOFF,L_PORTFOLIO_CODE,L_YEAR_CALC_TYPE,
              L_CPARTY_CODE,L_CURRENCY;
  close CHK_SETOFF;
  if L_SETOFF <> 'Y' then
     if L_AMOUNT <0 then
        L_SUBTYPE :='FUND';
     else
        L_SUBTYPE :='INVEST';
     end if;

      XTR_COF_P.MAINTAIN_POSITION_HISTORY(
        P_START_DATE                  => L_START_DATE,
        P_MATURITY_DATE               => NULL,
        P_OTHER_DATE                  => NULL,
        P_DEAL_NUMBER                 => NULL,
        P_TRANSACTION_NUMBER          => NULL,
        P_COMPANY_CODE                => L_COMPANY_CODE,
        P_CURRENCY                    => L_CURRENCY,
        P_DEAL_TYPE                   => 'CA',
        P_DEAL_SUBTYPE                => L_SUBTYPE,
        P_PRODUCT_TYPE                => NULL,
        P_PORTFOLIO_CODE              => L_PORTFOLIO_CODE,
        P_CPARTY_CODE                 => L_CPARTY_CODE,
        P_CONTRA_CCY                  => NULL,
        P_CURRENCY_COMBINATION        => NULL,
        P_ACCOUNT_NO                  => L_ACCOUNT_NUMBER,
        P_TRANSACTION_RATE            => L_INTEREST_RATE,
        P_YEAR_CALC_TYPE              => L_YEAR_CALC_TYPE,
        P_BASE_REF_AMOUNT             => L_AMOUNT,
        P_BASE_RATE                   => NULL,
        P_STATUS_CODE                 => 'CURRENT',
        P_INTEREST                    => NULL,
        P_MATURITY_AMOUNT             => NULL,
        P_START_AMOUNT                => NULL,
        P_CALC_BASIS                  => NULL,
        P_CALC_TYPE                   => NULL,
        P_ACTION                      => L_ACTION,
	P_DAY_COUNT_TYPE	      => :NEW.DAY_COUNT_TYPE,  -- Added for Interest Override
	P_FIRST_TRANS_FLAG	      => NULL -- Added for Interest Override
	);
    end if;
end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AID_BANK_BALANCE_T" ENABLE;
