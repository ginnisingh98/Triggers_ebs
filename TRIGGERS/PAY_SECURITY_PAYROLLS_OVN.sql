--------------------------------------------------------
--  DDL for Trigger PAY_SECURITY_PAYROLLS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_SECURITY_PAYROLLS_OVN" 
before insert or update on "HR"."PAY_SECURITY_PAYROLLS" for each row
begin
  if not
   pay_spr_shd.return_api_dml_status
then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end pay_security_payrolls_ovn;



/
ALTER TRIGGER "APPS"."PAY_SECURITY_PAYROLLS_OVN" ENABLE;
