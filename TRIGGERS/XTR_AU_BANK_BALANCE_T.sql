--------------------------------------------------------
--  DDL for Trigger XTR_AU_BANK_BALANCE_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_BANK_BALANCE_T" 
 AFTER UPDATE on "XTR"."XTR_BANK_BALANCES"
 FOR EACH ROW
declare
 cursor CHK_AUDIT(p_event varchar2) is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = p_event;
 --
 l_val VARCHAR2(1);
 --
 L_COMPANY_CODE 	VARCHAR2(7);
 L_CPARTY_CODE    	VARCHAR2(7);
 L_ACCOUNT_NUMBER	VARCHAR2(50);
 L_SETOFF		VARCHAR2(1);
 L_PORTFOLIO_CODE	VARCHAR2(10);
 L_YEAR_CALC_TYPE 	VARCHAR2(15);
 L_SUBTYPE	 	VARCHAR2(7);
 L_CURRENCY		VARCHAR2(15);
 L_AMOUNT 		NUMBER;

 cursor CHK_SETOFF is
  select nvl(SETOFF_ACCOUNT_YN,'N'),PORTFOLIO_CODE,YEAR_CALC_TYPE,
         BANK_CODE,CURRENCY
    from XTR_BANK_ACCOUNTS
     where PARTY_CODE=L_COMPANY_CODE
       and ACCOUNT_NUMBER =L_ACCOUNT_NUMBER;
begin
 -- Check that Audit on this table has been specified
 open CHK_AUDIT('BANK BALANCES');
  fetch CHK_AUDIT INTO l_val;
 if CHK_AUDIT%NOTFOUND then
  l_val := 'N';
 end if;
 close CHK_AUDIT;
 -- Copy to Audit Table the Pre-Updated row
 if nvl(upper(l_val),'N') = 'Y' then
   INSERT INTO XTR_A_BANK_BALANCES(
      COMPANY_CODE, ACCOUNT_NUMBER, BALANCE_DATE,
      NO_OF_DAYS, STATEMENT_BALANCE, BALANCE_ADJUSTMENT,
      BALANCE_CFLOW, ACCUM_INT_BFWD, INTEREST,
      INTEREST_RATE, INTEREST_SETTLED, INTEREST_SETTLED_HCE,
      ACCUM_INT_CFWD, UPDATED_BY, UPDATED_ON, SETOFF,
      AUDIT_INDICATOR, AUDIT_DATE_STORED, CREATED_BY, CREATED_ON
      ) VALUES (
      :old.COMPANY_CODE, :old.ACCOUNT_NUMBER, :old.BALANCE_DATE,
      :old.NO_OF_DAYS, :old.STATEMENT_BALANCE, :old.BALANCE_ADJUSTMENT,
      :old.BALANCE_CFLOW, :old.ACCUM_INT_BFWD, :old.INTEREST,
      :old.INTEREST_RATE, :old.INTEREST_SETTLED, :old.INTEREST_SETTLED_HCE,
      :old.ACCUM_INT_CFWD, :old.UPDATED_BY, sysdate, :old.SETOFF,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'), :old.CREATED_BY, :old.CREATED_ON);
 end if;

---Cof
If (:OLD.ACCOUNT_NUMBER <> :NEW.ACCOUNT_NUMBER or
    nvl(:OLD.ACCUM_INT_BFWD,0) <> nvl(:NEW.ACCUM_INT_BFWD,0) or
    nvl(:OLD.ACCUM_INT_CFWD,0) <> nvl(:NEW.ACCUM_INT_CFWD,0) or
    nvl(:OLD.BALANCE_ADJUSTMENT,0) <> nvl(:NEW.BALANCE_ADJUSTMENT,0) or
    nvl(:OLD.BALANCE_CFLOW,0) <> nvl(:NEW.BALANCE_CFLOW,0) or
    :OLD.BALANCE_DATE <> :NEW.BALANCE_DATE or
    :OLD.COMPANY_CODE <> :NEW.COMPANY_CODE or
    nvl(:OLD.INTEREST,0) <> nvl(:NEW.INTEREST,0) or
    :OLD.INTEREST_RATE <> :NEW.INTEREST_RATE or
    nvl(:OLD.INTEREST_SETTLED,0) <> nvl(:NEW.INTEREST_SETTLED,0) or
    nvl(:OLD.INTEREST_SETTLED_HCE,0) <> nvl(:NEW.INTEREST_SETTLED_HCE,0) or
    nvl(:OLD.STATEMENT_BALANCE,0) <> nvl(:NEW.STATEMENT_BALANCE,0) or
    nvl(:OLD.ACCRUAL_INTEREST,0) <> nvl(:NEW.ACCRUAL_INTEREST,0)) then

   if :NEW.BALANCE_DATE <trunc(sysdate) then
      L_COMPANY_CODE :=:NEW.COMPANY_CODE;
      L_ACCOUNT_NUMBER :=:NEW.ACCOUNT_NUMBER;
      open CHK_SETOFF;
      fetch CHK_SETOFF into L_SETOFF,L_PORTFOLIO_CODE,L_YEAR_CALC_TYPE,
              L_CPARTY_CODE,L_CURRENCY;
      close CHK_SETOFF;
      if L_SETOFF <> 'Y' then
     	L_AMOUNT := nvl(:NEW.BALANCE_ADJUSTMENT,0)+nvl(:NEW.STATEMENT_BALANCE,0);
     	if L_AMOUNT <0 then
           L_SUBTYPE :='FUND';
        else
           L_SUBTYPE :='INVEST';
     	end if;

        XTR_COF_P.MAINTAIN_POSITION_HISTORY(
        P_START_DATE                  => :NEW.BALANCE_DATE,
        P_MATURITY_DATE               => NULL,
        P_OTHER_DATE                  => NULL,
        P_DEAL_NUMBER                 => NULL,
        P_TRANSACTION_NUMBER          => NULL,
        P_COMPANY_CODE                => :NEW.COMPANY_CODE,
        P_CURRENCY                    => L_CURRENCY,
        P_DEAL_TYPE                   => 'CA',
        P_DEAL_SUBTYPE                => L_SUBTYPE,
        P_PRODUCT_TYPE                => NULL,
        P_PORTFOLIO_CODE              => L_PORTFOLIO_CODE,
        P_CPARTY_CODE                 => L_CPARTY_CODE,
        P_CONTRA_CCY                  => NULL,
        P_CURRENCY_COMBINATION        => NULL,
        P_ACCOUNT_NO                  => :NEW.ACCOUNT_NUMBER,
        P_TRANSACTION_RATE            => nvl(:NEW.INTEREST_RATE,0),
        P_YEAR_CALC_TYPE              => L_YEAR_CALC_TYPE,
        P_BASE_REF_AMOUNT             => L_AMOUNT,
        P_BASE_RATE                   => NULL,
        P_STATUS_CODE                 => 'CURRENT',
        P_INTEREST                    => NULL,
        P_MATURITY_AMOUNT             => NULL,
        P_START_AMOUNT                => NULL,
        P_CALC_BASIS                  => NULL,
	P_CALC_TYPE		      => NULL,
        P_ACTION                      => 'UPDATE',
	P_DAY_COUNT_TYPE	      => :NEW.DAY_COUNT_TYPE,  -- Added for Interest Override
	P_FIRST_TRANS_FLAG	      => NULL -- Added for Interest Override
	);
       end if;
    end if;
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_BANK_BALANCE_T" ENABLE;
