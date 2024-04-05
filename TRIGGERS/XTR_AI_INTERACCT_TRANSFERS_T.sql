--------------------------------------------------------
--  DDL for Trigger XTR_AI_INTERACCT_TRANSFERS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AI_INTERACCT_TRANSFERS_T" 
	 AFTER INSERT on "XTR"."XTR_INTERACCT_TRANSFERS"
	 FOR EACH ROW
declare
   l_sys_date DATE;
begin
   --Insert row into XTR_CONFIRMATION_DETAILS table
   l_sys_date :=trunc(sysdate);
   XTR_MISC_P.DEAL_ACTIONS (:NEW.deal_type,
                               0,
                               :NEW.transaction_number,
                               'INTERACCOUNT_TRANSFER',
                               :NEW.COMPANY_CODE,
                               null,
                               l_sys_date,
                               :NEW.COMPANY_CODE,
                               :NEW.STATUS_CODE,
                               null,
                               :NEW.DEAL_SUBTYPE,
                               :NEW.CURRENCY,
                               null,
                               null,
                               :NEW.TRANSFER_AMOUNT,
                               'Y');

end;
/
ALTER TRIGGER "APPS"."XTR_AI_INTERACCT_TRANSFERS_T" ENABLE;
