--------------------------------------------------------
--  DDL for Trigger XTR_AD_INTERACCT_TRANSFERS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AD_INTERACCT_TRANSFERS_T" 
	 AFTER DELETE on "XTR"."XTR_INTERACCT_TRANSFERS"
	 FOR EACH ROW
begin
   --Delete row from XTR_CONFIRMATION_DETAILS table

      DELETE from XTR_CONFIRMATION_DETAILS
      WHERE deal_type = 'IAC'
       and transaction_no = :OLD.TRANSACTION_NUMBER;

end;
/
ALTER TRIGGER "APPS"."XTR_AD_INTERACCT_TRANSFERS_T" ENABLE;
