--------------------------------------------------------
--  DDL for Trigger XTR_AU_INTERGROUP_TRANSFERS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_INTERGROUP_TRANSFERS_T" 
 AFTER UPDATE on "XTR"."XTR_INTERGROUP_TRANSFERS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'INTERGROUP TRANSFERS';
 --
 l_val 			VARCHAR2(1);
 --
 L_SUBTYPE		VARCHAR2(7);
 L_ACCOUNT_NO 		VARCHAR2(50);
 L_CPARTY_CODE		VARCHAR2(7);
 L_YEAR_CALC_TYPE	VARCHAR2(15);
 L_CURRENCY		VARCHAR2(15);

 cursor GET_YEAR_CALC_TYPE is
  select IG_YEAR_BASIS
    from XTR_MASTER_CURRENCIES
    where CURRENCY = L_CURRENCY;

begin
 -- Check that Audit on this table has been specified
 open CHK_AUDIT;
  fetch CHK_AUDIT INTO l_val;
 if CHK_AUDIT%NOTFOUND then
  l_val := 'N';
 end if;
 close CHK_AUDIT;

-- Copy to Audit Table the Pre-Updated row
 if nvl(upper(l_val),'N') = 'Y' then
   INSERT INTO XTR_A_INTERGROUP_TRANSFERS(
      DEAL_NUMBER, TRANSACTION_NUMBER, DEAL_TYPE,
      TRANSFER_DATE, COMPANY_CODE, PARTY_CODE,
      CURRENCY, NO_OF_DAYS, BALANCE_OUT,
      BALANCE_OUT_HCE, BALANCE_BF, BALANCE_BF_HCE,
      ACCUM_INTEREST_BF, ACCUM_INTEREST_BF_HCE,
      PRINCIPAL_ADJUST, PRINCIPAL_ADJUST_HCE,
      PRINCIPAL_ACTION, COMPANY_ACCOUNT_NO,
      PARTY_ACCOUNT_NO, INTEREST_RATE, INTEREST,
      INTEREST_HCE, INTEREST_SETTLED, INTEREST_SETTLED_HCE,
      DAY_COUNT_TYPE, ROUNDING_TYPE,
      CREATED_BY, CREATED_ON, SETTLE_DATE, UPDATED_BY,
      UPDATED_ON, PRODUCT_TYPE, AUDIT_INDICATOR, AUDIT_DATE_STORED
      ) VALUES (
      :old.DEAL_NUMBER, :old.TRANSACTION_NUMBER, :old.DEAL_TYPE,
      :old.TRANSFER_DATE, :old.COMPANY_CODE, :old.PARTY_CODE,
      :old.CURRENCY, :old.NO_OF_DAYS, :old.BALANCE_OUT,
      :old.BALANCE_OUT_HCE, :old.BALANCE_BF, :old.BALANCE_BF_HCE,
      :old.ACCUM_INTEREST_BF, :old.ACCUM_INTEREST_BF_HCE,
      :old.PRINCIPAL_ADJUST, :old.PRINCIPAL_ADJUST_HCE,
      :old.PRINCIPAL_ACTION, :old.COMPANY_ACCOUNT_NO,
      :old.PARTY_ACCOUNT_NO, :old.INTEREST_RATE, :old.INTEREST,
      :old.INTEREST_HCE, :old.INTEREST_SETTLED, :old.INTEREST_SETTLED_HCE,
      :old.DAY_COUNT_TYPE, :old.ROUNDING_TYPE,
      :old.CREATED_BY, :old.CREATED_ON, :old.SETTLE_DATE, :old.UPDATED_BY,
      sysdate, :old.PRODUCT_TYPE, :old.AUDIT_INDICATOR,
      to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'));
 end if;

---- Cof
if (nvl(:OLD.BALANCE_BF,0)<> nvl(:NEW.BALANCE_BF,0) or
    nvl(:OLD.BALANCE_OUT,0) <> nvl(:NEW.BALANCE_OUT,0) or
    :OLD.COMPANY_CODE <> :NEW.COMPANY_CODE or
    :OLD.CURRENCY <> :NEW.CURRENCY or
    :OLD.DEAL_NUMBER <> :NEW.DEAL_NUMBER or
    nvl(:OLD.INTEREST,0) <> nvl(:NEW.INTEREST,0) or
    nvl(:OLD.INTEREST_RATE,0) <> nvl(:NEW.INTEREST_RATE,0) or
    :OLD.PARTY_CODE <> :NEW.PARTY_CODE or
    :OLD.PORTFOLIO <> :NEW.PORTFOLIO or
    :OLD.PRINCIPAL_ACTION <> :NEW.PRINCIPAL_ACTION or
    :OLD.PRODUCT_TYPE <> :NEW.PRODUCT_TYPE or
    :OLD.TRANSACTION_NUMBER <> :NEW.TRANSACTION_NUMBER or
    :OLD.TRANSFER_DATE <> :NEW.TRANSFER_DATE) then

    -- bug 3305424: if :NEW.TRANSFER_DATE < trunc(sysdate) then
        if :NEW.BALANCE_OUT <0 then
           L_SUBTYPE :='FUND';
        else
           L_SUBTYPE :='INVEST';
        end if;

        L_CPARTY_CODE :=:NEW.PARTY_CODE;
        L_ACCOUNT_NO  :=:NEW.PARTY_ACCOUNT_NO;
        L_CURRENCY    :=:NEW.CURRENCY;

        open GET_YEAR_CALC_TYPE;
        fetch GET_YEAR_CALC_TYPE into L_YEAR_CALC_TYPE;
        close GET_YEAR_CALC_TYPE;

        XTR_COF_P.MAINTAIN_POSITION_HISTORY(
        P_START_DATE                  => :NEW.TRANSFER_DATE,
        P_MATURITY_DATE               => NULL,
        P_OTHER_DATE                  => NULL,
        P_DEAL_NUMBER                 => :NEW.DEAL_NUMBER,
        P_TRANSACTION_NUMBER          => :NEW.TRANSACTION_NUMBER,
        P_COMPANY_CODE                => :NEW.COMPANY_CODE,
        P_CURRENCY                    => :NEW.CURRENCY,
        P_DEAL_TYPE                   => 'IG',
        P_DEAL_SUBTYPE                => L_SUBTYPE,
        P_PRODUCT_TYPE                => :NEW.PRODUCT_TYPE,
        P_PORTFOLIO_CODE              => :NEW.PORTFOLIO,
        P_CPARTY_CODE                 => :NEW.PARTY_CODE,
        P_CONTRA_CCY                  => NULL,
        P_CURRENCY_COMBINATION        => NULL,
        P_ACCOUNT_NO                  => :NEW.PARTY_ACCOUNT_NO,
        P_TRANSACTION_RATE            => nvl(:NEW.INTEREST_RATE,0),
        P_YEAR_CALC_TYPE              => nvl(L_YEAR_CALC_TYPE,'ACTUAL/ACTUAL'),
        P_BASE_REF_AMOUNT             => nvl(:NEW.BALANCE_OUT,0),
        P_BASE_RATE                   => NULL,
        P_STATUS_CODE                 => 'CURRENT',
        P_INTEREST                    => NULL,
        P_MATURITY_AMOUNT             => NULL,
        P_START_AMOUNT                => NULL,
        P_CALC_BASIS                  => NULL,
        P_CALC_TYPE                   => NULL,
        P_ACTION                      => 'UPDATE',
	P_DAY_COUNT_TYPE	      => :NEW.DAY_COUNT_TYPE, -- Added for Interest Override
	P_FIRST_TRANS_FLAG	      => NULL);
    -- bug 3305424: end if;
end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_INTERGROUP_TRANSFERS_T" ENABLE;
