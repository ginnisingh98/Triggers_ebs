--------------------------------------------------------
--  DDL for Trigger PAY_BALANCE_TYPES_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_BALANCE_TYPES_OVN" 
before insert or update on "HR"."PAY_BALANCE_TYPES" for each row
begin
  if not
   pay_blt_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end PAY_BALANCE_TYPES_ovn;

/
ALTER TRIGGER "APPS"."PAY_BALANCE_TYPES_OVN" ENABLE;
