--------------------------------------------------------
--  DDL for Trigger PAY_USER_TABLES_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_TABLES_OVN" 
before insert or update on "HR"."PAY_USER_TABLES" for each row
begin
  if not
    pay_put_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end PAY_USER_TABLES_ovn;



/
ALTER TRIGGER "APPS"."PAY_USER_TABLES_OVN" ENABLE;
