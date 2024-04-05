--------------------------------------------------------
--  DDL for Trigger OIE_UPDATE_EXP_STATUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."OIE_UPDATE_EXP_STATUS" 
AFTER UPDATE of payment_status_flag
ON  "AP"."AP_INVOICES_ALL"
FOR EACH ROW
  WHEN (new.source in ('SelfService', 'Both Pay', 'CREDIT CARD') and new.payment_status_flag <> old.payment_status_flag) DECLARE
l_source		      AP_INVOICES_ALL.SOURCE%TYPE;
l_flag                        NUMBER := 0;
l_debug_info                  VARCHAR2(1000);
BEGIN

l_debug_info := ':NEW.invoice_id' || to_char(:NEW.invoice_id);

AP_WEB_UTILITIES_PKG.UpdateExpenseStatusCode( p_invoice_id => :NEW.invoice_id, p_pay_status_flag =>  nvl(:NEW.payment_status_flag,'N'));


EXCEPTION
  WHEN OTHERS THEN
    FND_MESSAGE.SET_NAME('SQLAP','AP_DEBUG');
    FND_MESSAGE.SET_TOKEN('ERROR',SQLERRM);
    FND_MESSAGE.SET_TOKEN('CALLING_SEQUENCE', 'After Insert trigger');
    FND_MESSAGE.SET_TOKEN('PARAMETERS','Not Applicable');
    FND_MESSAGE.SET_TOKEN('DEBUG_INFO',l_debug_info);
    RAISE_APPLICATION_ERROR(-20010, fnd_message.get);

END;

/
ALTER TRIGGER "APPS"."OIE_UPDATE_EXP_STATUS" ENABLE;
