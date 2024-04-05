--------------------------------------------------------
--  DDL for Trigger AP_SSE_NOTIFY_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_SSE_NOTIFY_EMPLOYEE" 
AFTER INSERT
ON  "AP"."AP_INVOICE_PAYMENTS_ALL"
FOR EACH ROW

DECLARE
  l_debug_info                  VARCHAR2(1000);

  l_sse_cc_payment_notify       VARCHAR2(1);

  l_checkNumber                 AP_CHECKS_ALL.CHECK_NUMBER%TYPE;
  l_paymentCurrency             AP_CHECKS_ALL.CURRENCY_CODE%TYPE;
  l_paymentDate                 AP_CHECKS_ALL.CHECK_DATE%TYPE;
  l_paymentMethod               AP_CHECKS_ALL.PAYMENT_METHOD_LOOKUP_CODE%TYPE := NULL;
  l_paymentProfileId            AP_CHECKS_ALL.PAYMENT_PROFILE_ID%TYPE := NULL;
  l_ext_bank_account_id         AP_CHECKS_ALL.EXTERNAL_BANK_ACCOUNT_ID%TYPE;   -- bug 2426077
  l_processing_type             IBY_PAYMENT_PROFILES.PROCESSING_TYPE%TYPE;

  l_invoice_type_lookup_code    AP_INVOICES_ALL.INVOICE_TYPE_LOOKUP_CODE%TYPE;
  l_employeeID                  PO_VENDORS.EMPLOYEE_ID%TYPE := NULL;
  l_paid_on_behalf_employee_id  AP_INVOICES_ALL.PAID_ON_BEHALF_EMPLOYEE_ID%TYPE := NULL;
  l_invoiceNumber               AP_INVOICES_ALL.INVOICE_NUM%TYPE;
  l_account                     IBY_EXT_BANK_ACCOUNTS_V.BANK_ACCOUNT_NUMBER%TYPE := NULL; --1684954
  l_bankName                    IBY_EXT_BANK_ACCOUNTS_V.BANK_NAME%TYPE := NULL; --1758619
  l_cardIssuer                  PO_VENDORS.VENDOR_NAME%TYPE;

  l_paidAmount               AP_INVOICES_ALL.PAY_CURR_INVOICE_AMOUNT%TYPE;

   l_flag                        NUMBER := 0;
   l_source			     AP_INVOICES_ALL.SOURCE%TYPE;
BEGIN


  --
  -- Check if the invoice updation is for iExpenses
  -- If not, no need to bother
  --

 BEGIN

  SELECT 1, :new.amount, source
    INTO l_flag, l_paidAmount, l_source
    FROM ap_invoices_all
   WHERE invoice_id = :NEW.invoice_id
     AND SOURCE IN ( 'SelfService', 'Both Pay', 'CREDIT CARD','XpenseXpress');

 EXCEPTION
  WHEN NO_DATA_FOUND THEN
      l_flag := 0;
 END;

  l_debug_info := ':NEW.invoice_id' || to_char(:NEW.invoice_id) ||
                  ' :new.check_id' || to_char(:new.check_id);
  IF ( l_flag = 1 )
  THEN

    -- IF(l_source <> 'XpenseXpress') THEN (sodash) Changed for Bug 9025829: EXPENSE_STATUS_CODE OF EXPENSE REPORTS NOT UPDATED
     AP_WEB_UTILITIES_PKG.UpdateExpenseStatusCode( p_invoice_id => :NEW.invoice_id );
    -- END IF;

-- The notification should be sent only if the profile option for
-- credit card payment notification is set to 'Y'.
-----------------------------------------
l_debug_info := 'Get SSE_CC_PAYMENT_NOTIFY profile option';
-----------------------------------------
fnd_profile.get('SSE_CC_PAYMENT_NOTIFY', l_sse_cc_payment_notify);

if (nvl(l_sse_cc_payment_notify,'N') = 'Y') then

  -----------------------------------------
  l_debug_info := 'Get invoice and vendor info';
  -----------------------------------------
  SELECT  AIA.invoice_type_lookup_code,
          PV.employee_id,
          AIA.paid_on_behalf_employee_id,
          AIA.invoice_num,
          PV.vendor_name
  INTO    l_invoice_type_lookup_code,
          l_employeeID,
          l_paid_on_behalf_employee_id,
          l_invoiceNumber,
          l_cardIssuer
  FROM    PO_VENDORS PV,
          AP_INVOICES_ALL AIA
  WHERE   PV.vendor_id = AIA.vendor_id
  AND     AIA.invoice_id = :new.invoice_id;

  if (nvl(l_paid_on_behalf_employee_id, -1) <> -1
      or (l_invoice_type_lookup_code = 'EXPENSE REPORT')) then

    -----------------------------------------
    l_debug_info := 'Get check info';
    -----------------------------------------
    SELECT check_number,
           currency_code,
           check_date,
           payment_profile_id,
           external_bank_account_id       -- bug 2426077
    INTO   l_checkNumber,
           l_paymentCurrency,
           l_paymentDate,
           l_paymentProfileId,
           l_ext_bank_account_id      -- bug 2426077
    FROM   AP_CHECKS_ALL
    WHERE  check_id = :new.check_id;

    -----------------------------------------
    l_debug_info := 'Get Payment Processing Type';
    -----------------------------------------
    if (l_paymentProfileId is not null) then      -- Bug 7118709(sodash)
      SELECT processing_type
      INTO   l_processing_type
      FROM   IBY_PAYMENT_PROFILES
      WHERE  payment_profile_id = l_paymentProfileId
      AND    rownum = 1;
    end if;
    -----------------------------------------
    -- The value for l_paymentMethod is set to a constant recognized by the
    -- ap_web_credit_card_wf.sendPaymentNotification procedure
    -----------------------------------------
    if ((l_processing_type = 'ELECTRONIC') AND (l_ext_bank_account_id IS NOT NULL)) then

      l_paymentMethod := 'DIRECT_DEPOSIT';

      -- Bug 1828480 Starts, Code Moved inside this IF Block to execute
      -- This statement only if the Payment Method is EFT.
      -- Added a debug info to locate if this case fails.

      -----------------------------------------
      l_debug_info := 'Get Bank Information for the Invoice and Vendor';
      -----------------------------------------

      -- Bug 1684954 fix begins

      -- bug 2426077 selecting the bank a/c details based on bank account id.
      -- bug 7342684 removed l_paymentDate between start and end date check,
      -- as l_ext_bank_account_id is used to get the a/c info.
      SELECT bank_account_number,
             bank_name||','||bank_branch_name
      INTO   l_account,
             l_bankName
      FROM   IBY_EXT_BANK_ACCOUNTS_V
      WHERE  ext_bank_account_id = l_ext_bank_account_id
      AND    rownum = 1;

      l_debug_info := 'l_account:' || l_account || ' l_bankName:' || l_bankName;
      -- Bug 1684954 fix ends

      -- Bug 1828480 ends

    else

      l_paymentMethod := 'CHECK';

    end if;

    --
    -- Sent notification to employee about payment made to credit card
    -- company in behalf of the employee
    --
    -- Bug 1312450
    -- Since invoices imported from expense report tables for employees have the
    -- paid_on_behalf_employee_id populated with -1, we need to check for that
    -- condition too
    if (nvl(l_paid_on_behalf_employee_id, -1) <> -1) then

      -----------------------------------------
      l_debug_info := 'Calling SSE workflow API...(paid_on_behalf_employee_id not null)';
      -----------------------------------------
      ap_web_credit_card_wf.sendPaymentNotification(
        p_checkNumber      => l_checkNumber,
        p_employeeId       => l_paid_on_behalf_employee_id,
        p_paymentCurrency  => l_paymentCurrency,
        p_invoiceNumber    => l_invoiceNumber,
        p_paidAmount       => :new.amount,
        p_paymentTo        => ap_web_credit_card_wf.c_paymentToCardIssuer,
        p_paymentMethod    => NULL,
        p_account          => NULL,
        p_bankName         => NULL,
        p_cardIssuer       => l_cardIssuer,
        p_paymentDate      => fnd_date.date_to_canonical(l_paymentDate));

    --
    -- Sent notification to employee for all expense payments made to
    -- the employee
    --

    elsif (l_invoice_type_lookup_code = 'EXPENSE REPORT') then

     if(:new.REVERSAL_FLAG = 'Y') then

	 ap_web_credit_card_wf.sendPaymentNotification(
         p_checkNumber      => l_checkNumber,
         p_employeeId       => l_employeeId,
         p_paymentCurrency  => l_paymentCurrency,
         p_invoiceNumber    => l_invoiceNumber,
         p_paidAmount	   => l_paidAmount,
         p_paymentTo        => ap_web_credit_card_wf.c_voidPayment,
         p_paymentMethod    => l_paymentMethod,
         p_account          => l_account,
         p_bankName         => l_bankName,
         p_cardIssuer       => NULL,
         p_paymentDate      => fnd_date.date_to_canonical(l_paymentDate) );

     else
         l_debug_info := 'Calling SSE workflow API...(invoice_type is "EXPENSE REPORT")';
         ap_web_credit_card_wf.sendPaymentNotification(
         p_checkNumber      => l_checkNumber,
         p_employeeId       => l_employeeId,
         p_paymentCurrency  => l_paymentCurrency,
         p_invoiceNumber    => l_invoiceNumber,
         p_paidAmount	   => :new.amount,
         p_paymentTo        => ap_web_credit_card_wf.c_paymentToEmployee,
         p_paymentMethod    => l_paymentMethod,
         p_account          => l_account,
         p_bankName         => l_bankName,
         p_cardIssuer       => NULL,
         p_paymentDate      => fnd_date.date_to_canonical(l_paymentDate) );

     end if;

    end if;

  end if;

end if; /* (nvl(l_sse_cc_payment_notify,'N') = 'Y') */

   l_debug_info := 'END :NEW.invoice_id' || to_char(:NEW.invoice_id) ||
                   ' :new.check_id' || to_char(:new.check_id);

END IF; -- end of IF ( l_flag = 1 )

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
ALTER TRIGGER "APPS"."AP_SSE_NOTIFY_EMPLOYEE" ENABLE;
