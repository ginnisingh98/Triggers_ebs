--------------------------------------------------------
--  DDL for Trigger PER_VAC_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_VAC_OVN" 
before insert or update on "HR"."PER_ALL_VACANCIES" for each row
begin
 if hr_general.g_data_migrator_mode <> 'Y' then
   if not per_vac_shd.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.Get_Object_Version_Number
           (p_base_table_name => 'per_all_vacancies',
            P_BASE_KEY_COLUMN => 'vacancy_id',
            P_BASE_KEY_VALUE  => :NEW.vacancy_id);
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
end per_vac_ovn;


/
ALTER TRIGGER "APPS"."PER_VAC_OVN" ENABLE;
