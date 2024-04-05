--------------------------------------------------------
--  DDL for Trigger PAY_USER_COLUMNS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_COLUMNS_OVN" 
before insert or update on "HR"."PAY_USER_COLUMNS" for each row
begin
  if not
    pay_puc_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end PAY_USER_COLUMNS_ovn;



/
ALTER TRIGGER "APPS"."PAY_USER_COLUMNS_OVN" ENABLE;
