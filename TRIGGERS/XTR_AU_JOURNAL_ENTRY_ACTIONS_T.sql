--------------------------------------------------------
--  DDL for Trigger XTR_AU_JOURNAL_ENTRY_ACTIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_JOURNAL_ENTRY_ACTIONS_T" 
 AFTER UPDATE on "XTR"."XTR_JOURNAL_ENTRY_ACTIONS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'JOURNAL STRUCTURE';
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
   INSERT INTO XTR_A_JOURNAL_ENTRY_ACTIONS(
      COMPANY_CODE, DEAL_TYPE,
      DEAL_SUBTYPE, AMOUNT_TYPE, DATE_TYPE,
      CREDIT_OR_DEBIT, GET_GL_FROM_DEAL, CREATED_BY,GET_PRIN_CCID_FROM_DEAL,
      GET_INT_CCID_FROM_DEAL,CREATED_ON, UPDATED_BY, UPDATED_ON, ACTION_CODE,
      CODE_COMBINATION_ID, COMMENTS, PRODUCT_TYPE, PORTFOLIO_CODE,
      AUDIT_INDICATOR, AUDIT_DATE_STORED
      ) VALUES (
      :old.COMPANY_CODE, :old.DEAL_TYPE,
      :old.DEAL_SUBTYPE, :old.AMOUNT_TYPE, :old.DATE_TYPE,
      :old.CREDIT_OR_DEBIT, :old.GET_GL_FROM_DEAL, :old.CREATED_BY,:old.GET_PRIN_CCID_FROM_DEAL,
      :old.GET_INT_CCID_FROM_DEAL,:old.CREATED_ON, :old.UPDATED_BY, sysdate, :old.ACTION_CODE,
      :old.CODE_COMBINATION_ID, :old.COMMENTS, :old.PRODUCT_TYPE, :old.PORTFOLIO_CODE,
      :old.AUDIT_INDICATOR,to_date(to_char(sysdate,'DD/MM/YYYY HH24:MI:SS'),
      'DD/MM/YYYY HH24:MI:SS'));
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_JOURNAL_ENTRY_ACTIONS_T" ENABLE;
