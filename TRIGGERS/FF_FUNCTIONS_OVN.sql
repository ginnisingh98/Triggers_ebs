--------------------------------------------------------
--  DDL for Trigger FF_FUNCTIONS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FUNCTIONS_OVN" 
before insert or update on "HR"."FF_FUNCTIONS" for each row
begin
  if not
   ff_ffn_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end ff_functions_ovn;


/
ALTER TRIGGER "APPS"."FF_FUNCTIONS_OVN" ENABLE;
