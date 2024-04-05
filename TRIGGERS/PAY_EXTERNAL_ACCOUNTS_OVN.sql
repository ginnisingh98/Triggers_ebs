--------------------------------------------------------
--  DDL for Trigger PAY_EXTERNAL_ACCOUNTS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_EXTERNAL_ACCOUNTS_OVN" 
before insert or update on "HR"."PAY_EXTERNAL_ACCOUNTS" for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  if not pay_exa_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end if;
end pay_external_accounts_ovn;



/
ALTER TRIGGER "APPS"."PAY_EXTERNAL_ACCOUNTS_OVN" ENABLE;
