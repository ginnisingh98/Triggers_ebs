--------------------------------------------------------
--  DDL for Trigger XTR_BI_ROLLOVER_TRANSACTIONS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_BI_ROLLOVER_TRANSACTIONS_T" 
 BEFORE INSERT on "XTR"."XTR_ROLLOVER_TRANSACTIONS"
 FOR EACH ROW
declare
 date_created 	date;
 l_action_type 	varchar2(50);
 l_amount 	number;
 l_currency	VARCHAR2(15);
 l_org_flag 	varchar2(1);
--
begin
 --
 l_currency :=:NEW.CURRENCY;
 date_created := sysdate;
 l_org_flag := 'Y';
 l_action_type := NULL;
 --
 --:NEW.CREATED_BY := substr(USER,1,10);
 :NEW.CREATED_ON := SYSDATE;
 :NEW.INTEREST_FREQ := nvl(:NEW.INTEREST_FREQ,'M');
 :NEW.PI_AMOUNT_RECEIVED := nvl(:NEW.PI_AMOUNT_RECEIVED,0);
 if  nvl(:NEW.deal_type,'^') ='ONC'  and :NEW.PRINCIPAL_AMOUNT_TYPE is NOT NULL then
   l_action_type := 'NEW_CALL_CONTRACT';
   l_amount :=:NEW.PRINCIPAL_ADJUST;
 elsif  nvl(:NEW.deal_type,'^') = 'ONC' and :NEW.PRINCIPAL_AMOUNT_TYPE is NULL then
   l_action_type :='CALL_PRINCIPAL_REPAYMENT_RENEG';
   l_amount := nvl(:NEW.REPAY_AMOUNT,:NEW.BALANCE_OUT);
 end if;

 -- Bug 6161318 starts
 if :NEW.deal_subtype = 'INVEST' and l_action_type = 'NEW_CALL_CONTRACT' then
   l_amount := l_amount * (-1);
 end if;

  if :NEW.deal_subtype = 'FUND' and l_action_type = 'CALL_PRINCIPAL_REPAYMENT_RENEG' then
   l_amount := l_amount * (-1);
 end if;
 -- Bug 6161318 ends

 if l_action_type is not null and nvl(:NEW.QUICK_INPUT,'N') <>'Y' then
  -- Execute Stored procedure DEAL_ACTIONS
  XTR_MISC_P.DEAL_ACTIONS
   (:NEW.deal_type,:NEW.deal_number,:NEW.transaction_number,l_action_type,
    :NEW.cparty_code,:NEW.client_code,date_created,
    :NEW.company_code,:NEW.status_code,null,
    :NEW.deal_subtype,l_currency,:NEW.cparty_advice,
    :NEW.client_advice,l_amount,l_org_flag );
 end if;
end;
/
ALTER TRIGGER "APPS"."XTR_BI_ROLLOVER_TRANSACTIONS_T" ENABLE;
