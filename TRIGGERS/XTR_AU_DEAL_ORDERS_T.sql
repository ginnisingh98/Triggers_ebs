--------------------------------------------------------
--  DDL for Trigger XTR_AU_DEAL_ORDERS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AU_DEAL_ORDERS_T" 
 AFTER UPDATE on "XTR"."XTR_DEAL_ORDERS"
 FOR EACH ROW
declare
 cursor CHK_AUDIT is
  select nvl(AUDIT_YN,'N')
   from XTR_SETUP_AUDIT_REQMTS
   where rtrim(EVENT) = 'DEAL ORDERS';
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
   INSERT INTO XTR_A_DEAL_ORDERS(
      UNIQUE_REF_NUM, DEAL_TYPE, ORDER_TYPE,
      COMPANY_CODE, CPARTY_CODE, STATUS_CODE,
      PLACED_ON, VALID_UNTIL, CREATED_BY, CREATED_ON,
      DETAILS_OF_ORDER, CONFIRMED_BY_DEALER, DEAL_SUBTYPE,
      PRODUCT_TYPE, DEALER_COMPANY, DEALER_CPARTY,
      UPDATED_BY, UPDATED_ON, AUDIT_INDICATOR,
      order_rate, order_ccy_a,ccy_a_amount,order_ccy_b,ccy_b_amount,
      order_delivery_date,AUDIT_DATE_STORED)
     VALUES (:old.UNIQUE_REF_NUM, :old.DEAL_TYPE, :old.ORDER_TYPE,
      :old.COMPANY_CODE, :old.CPARTY_CODE, :old.STATUS_CODE,
      :old.PLACED_ON, :old.VALID_UNTIL, :old.CREATED_BY, :old.CREATED_ON,
      :old.DETAILS_OF_ORDER, :old.CONFIRMED_BY_DEALER, :old.DEAL_SUBTYPE,
      :old.PRODUCT_TYPE, :old.DEALER_COMPANY, :old.DEALER_CPARTY,
      :old.UPDATED_BY, sysdate, :old.AUDIT_INDICATOR,
      :old.order_rate, :old.order_ccy_a,:old.ccy_a_amount,:old.order_ccy_b,
      :old.ccy_b_amount,:old.order_delivery_date,to_date(to_char(sysdate,'DD/MM/YYYY
      HH24:MI:SS'),'DD/MM/YYYY HH24:MI:SS'));
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_AU_DEAL_ORDERS_T" ENABLE;
