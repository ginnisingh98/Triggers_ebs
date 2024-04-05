--------------------------------------------------------
--  DDL for Trigger PSP_ORGANIZATION_ACCOUNTS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PSP_ORGANIZATION_ACCOUNTS_OVN" 
before insert or update on "PSP"."PSP_ORGANIZATION_ACCOUNTS" for each row
begin
  if not
  psp_poa_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end psp_organization_accounts_ovn;


/
ALTER TRIGGER "APPS"."PSP_ORGANIZATION_ACCOUNTS_OVN" ENABLE;
