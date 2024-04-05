--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_OVN" 
before insert or update on "HR"."FF_GLOBALS_F" for each row
begin
  if not
   ff_fgl_shd.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.Get_Object_Version_Number
            (p_base_table_name => 'FF_GLOBALS_F',
             P_BASE_KEY_COLUMN => 'GLOBAL_ID',
             P_BASE_KEY_VALUE  => :NEW.GLOBAL_ID);
      exception
        when others then
          if (sqlcode = -4091) then
            :NEW.object_version_number := 1;
          else
            raise;
          end if;
      end;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end FF_GLOBALS_F_OVN;


/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_OVN" ENABLE;
