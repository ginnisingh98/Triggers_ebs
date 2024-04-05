--------------------------------------------------------
--  DDL for Trigger XTR_AU_JOURNALS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_JOURNALS_T" 
 AFTER UPDATE on "XTR"."XTR_JOURNALS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'JOURNALS';
 --
 l_val VARCHAR2(1);
 --
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
   INSERT INTO XTR_A_JOURNALS(
      COMPANY_CODE, JOURNAL_DATE, DEAL_NUMBER,
      TRANSACTION_NUMBER, DEAL_TYPE, DEAL_SUBTYPE,
      AMOUNT_TYPE, DEBIT_AMOUNT, CREDIT_AMOUNT,
      CODE_COMBINATION_ID, COMMENTS,
      GL_TRANSFER_DATE, JNL_REVERSAL_IND, CANCELLED_IN_GL,
      CREATED_BY, CREATED_ON, UPDATED_BY, UPDATED_ON,
      PRODUCT_TYPE, PORTFOLIO_CODE,
      AUDIT_INDICATOR, AUDIT_DATE_STORED,
      SET_OF_BOOKS_ID,
      SUSPENSE_GL,
      ACCOUNTED_DR,
      ACCOUNTED_CR,
      GL_SL_LINK_ID,
      SETTLEMENT_NUMBER
      ) VALUES (
      :old.COMPANY_CODE, :old.JOURNAL_DATE, :old.DEAL_NUMBER,
      :old.TRANSACTION_NUMBER, :old.DEAL_TYPE, :old.DEAL_SUBTYPE,
      :old.AMOUNT_TYPE, :old.DEBIT_AMOUNT, :old.CREDIT_AMOUNT,
      :old.CODE_COMBINATION_ID, :old.COMMENTS,
      :old.GL_TRANSFER_DATE, :old.JNL_REVERSAL_IND, :old.CANCELLED_IN_GL,
      :old.CREATED_BY, :old.CREATED_ON, :old.UPDATED_BY, sysdate,
      :old.PRODUCT_TYPE, :old.PORTFOLIO_CODE,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'),:old.SET_OF_BOOKS_ID,
      :old.SUSPENSE_GL,
      :old.ACCOUNTED_DR,
      :old.ACCOUNTED_CR,
      :old.GL_SL_LINK_ID,
      :old.SETTLEMENT_NUMBER);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_JOURNALS_T" ENABLE;
