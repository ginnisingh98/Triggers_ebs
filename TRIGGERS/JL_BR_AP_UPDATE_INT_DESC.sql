--------------------------------------------------------
--  DDL for Trigger JL_BR_AP_UPDATE_INT_DESC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."JL_BR_AP_UPDATE_INT_DESC" 
                          BEFORE INSERT ON "AP"."AP_INVOICE_RELATIONSHIPS"
                          FOR EACH ROW

DECLARE
  v_country_code varchar2(500);

BEGIN
   ---------------------------------------------------
   -- Get the country code.
   ---------------------------------------------------
   fnd_profile.get('JGZZ_COUNTRY_CODE', v_country_code);

   IF (v_country_code = 'BR') THEN
      -- *******************************************************
      -- Update AP_INVOICES - Description for Interest invoices
      -- *******************************************************
      JL_BR_INTEREST_HANDLING.JL_BR_CHANGE_INT_DES(:new.related_invoice_id,
                                                   :new.original_invoice_id,
                                                   :new.original_payment_num);
   END IF;

EXCEPTION
   WHEN others THEN
      NULL;
END JL_BR_AP_UPDATE_INT_DESC;



/
ALTER TRIGGER "APPS"."JL_BR_AP_UPDATE_INT_DESC" ENABLE;
