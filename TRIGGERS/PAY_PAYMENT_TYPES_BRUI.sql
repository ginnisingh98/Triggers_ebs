--------------------------------------------------------
--  DDL for Trigger PAY_PAYMENT_TYPES_BRUI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PAYMENT_TYPES_BRUI" 
before insert or update on "HR"."PAY_PAYMENT_TYPES"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  hr_payments.ppt_brui(:new.allow_as_default,
                       :new.category,
                       :new.pre_validation_required,
                       :new.validation_days,
                       :new.validation_value);
end if;
end pay_payment_types_brui;



/
ALTER TRIGGER "APPS"."PAY_PAYMENT_TYPES_BRUI" ENABLE;
