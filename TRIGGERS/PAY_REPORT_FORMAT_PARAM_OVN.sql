--------------------------------------------------------
--  DDL for Trigger PAY_REPORT_FORMAT_PARAM_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_REPORT_FORMAT_PARAM_OVN" 
before insert or update on "HR"."PAY_REPORT_FORMAT_PARAMETERS" for each row
begin
  if not
   pay_rfp_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end PAY_REPORT_FORMAT_PARAM_ovn;


/
ALTER TRIGGER "APPS"."PAY_REPORT_FORMAT_PARAM_OVN" ENABLE;
