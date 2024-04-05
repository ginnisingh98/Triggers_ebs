--------------------------------------------------------
--  DDL for Trigger PAY_TIME_DEFINITIONS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_TIME_DEFINITIONS_OVN" 
before insert or update on "HR"."PAY_TIME_DEFINITIONS" for each row
begin
  if not
   pay_tdf_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end PAY_TIME_DEFINITIONS_ovn;


/
ALTER TRIGGER "APPS"."PAY_TIME_DEFINITIONS_OVN" ENABLE;
