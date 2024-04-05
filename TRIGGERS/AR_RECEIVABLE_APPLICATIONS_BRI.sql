--------------------------------------------------------
--  DDL for Trigger AR_RECEIVABLE_APPLICATIONS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AR_RECEIVABLE_APPLICATIONS_BRI" 
BEFORE INSERT ON "AR"."AR_RECEIVABLE_APPLICATIONS_ALL" FOR EACH ROW

BEGIN
    arp_receivable_applications.PopulateCashReceiptHistoryId( :new.cash_receipt_id, :new.cash_receipt_history_id );
EXCEPTION
    WHEN OTHERS THEN
        arp_standard.debug( 'Exception:ar_receivable_applications_bri');
        arp_standard.debug( 'new.cash_receipt_id:'||:new.cash_receipt_id );
        arp_standard.debug( 'new.cash_receipt_history_id:'||:new.cash_receipt_history_id );
        RAISE;
END;



/
ALTER TRIGGER "APPS"."AR_RECEIVABLE_APPLICATIONS_BRI" ENABLE;
