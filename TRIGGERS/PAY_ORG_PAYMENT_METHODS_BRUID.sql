--------------------------------------------------------
--  DDL for Trigger PAY_ORG_PAYMENT_METHODS_BRUID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ORG_PAYMENT_METHODS_BRUID" 
before insert or update on "HR"."PAY_ORG_PAYMENT_METHODS_F"
for each row
declare
trigger_fail exception;
status boolean;
payments_defined_balance number(16);
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  if inserting or updating then
    if (:new.external_account_id is not null) then
       status := hr_payments.check_account(to_char(:new.external_account_id),
                                                to_char(:new.payment_type_id));
    end if;
    status := hr_payments.check_currency(to_char(:new.payment_type_id),
                                                     :new.currency_code);
  end if;
--
end if;
end pay_org_payment_methods_bruid;


/
ALTER TRIGGER "APPS"."PAY_ORG_PAYMENT_METHODS_BRUID" ENABLE;
