--------------------------------------------------------
--  DDL for Trigger XTR_AU_PRODUCT_TYPES_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_PRODUCT_TYPES_T" 
 AFTER UPDATE on "XTR"."XTR_PRODUCT_TYPES"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'PRODUCT TYPES';
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
   INSERT INTO XTR_A_PRODUCT_TYPES(
      DEAL_TYPE, PRODUCT_TYPE, PRODUCT_DESC,
      PRODUCT_AUTH,
      REVAL_CROSS_REF, CALC_BASIS, UPDATED_ON,
      UPDATED_BY, AUDIT_INDICATOR, CPARTY_ADVICE,
      CLIENT_ADVICE, AUDIT_DATE_STORED, CREATED_ON, CREATED_BY
      ) VALUES (
      :old.DEAL_TYPE, :old.PRODUCT_TYPE, :old.PRODUCT_DESC,
      :old.PRODUCT_AUTH,
      :old.REVAL_CROSS_REF, :old.CALC_BASIS, sysdate,
      :old.UPDATED_BY, :old.AUDIT_INDICATOR, :old.CPARTY_ADVICE,
      :old.CLIENT_ADVICE, sysdate, :old.CREATED_ON, :old.CREATED_BY);
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_PRODUCT_TYPES_T" ENABLE;
