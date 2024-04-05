--------------------------------------------------------
--  DDL for Trigger PAY_PERSONAL_PAY_METHODS_BRUI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PERSONAL_PAY_METHODS_BRUI" 
before insert or update or delete on "HR"."PAY_PERSONAL_PAYMENT_METHODS_F"
for each row

declare
status boolean;
begin
if hr_general.g_data_migrator_mode <> 'Y' then
if inserting or updating then
    status :=  hr_payments.check_amt(to_char(:new.percentage),
                                             to_char(:new.amount));
    status := hr_payments.mt_checks(to_char(:new.org_payment_method_id),
                          fnd_date.date_to_canonical(:new.effective_start_date),
                          to_char(:new.external_account_id));
--    status := hr_payments.unique_priority(to_char(:new.priority),
--                            fnd_date.date_to_canonical(:new.effective_start_date),
--                            fnd_date.date_to_canonical(:new.effective_end_date),
--                            to_char(:new.assignment_id));
  end if;
  if deleting then
    status := hr_payments.check_pp(to_char(:old.personal_payment_method_id),
                                fnd_date.date_to_canonical(:new.effective_end_date));
  end if;
end if;
end hr_payments_brui;



/
ALTER TRIGGER "APPS"."PAY_PERSONAL_PAY_METHODS_BRUI" ENABLE;
