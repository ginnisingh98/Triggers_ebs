--------------------------------------------------------
--  DDL for Trigger FF_FUNCTION_CONTEXT_USAGES_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FUNCTION_CONTEXT_USAGES_OVN" 
before insert or update on "HR"."FF_FUNCTION_CONTEXT_USAGES" for each row
begin
  if not
   ff_fcu_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end ff_function_context_usages_ovn;


/
ALTER TRIGGER "APPS"."FF_FUNCTION_CONTEXT_USAGES_OVN" ENABLE;
