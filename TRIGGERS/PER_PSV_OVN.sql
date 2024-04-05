--------------------------------------------------------
--  DDL for Trigger PER_PSV_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_PSV_OVN" 
before insert or update on "HR"."PER_POS_STRUCTURE_VERSIONS" for each row

begin
 if hr_general.g_data_migrator_mode <> 'Y' then
  if not per_psv_shd.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.Get_Object_Version_Number
           (p_base_table_name => 'per_pos_structure_versions',
            P_BASE_KEY_COLUMN => 'pos_structure_version_id',
            P_BASE_KEY_VALUE  => :NEW.pos_structure_version_id);
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
 end if;
end per_psv_ovn;



/
ALTER TRIGGER "APPS"."PER_PSV_OVN" ENABLE;
