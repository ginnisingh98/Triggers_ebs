--------------------------------------------------------
--  DDL for Trigger PAY_USER_COLUMN_INSTANCE_F_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_COLUMN_INSTANCE_F_OVN" 
before insert or update on "HR"."PAY_USER_COLUMN_INSTANCES_F" for each row
begin
  if not
   pay_uci_shd.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.Get_Object_Version_Number
            (p_base_table_name => 'PAY_USER_COLUMN_INSTANCES_F',
             P_BASE_KEY_COLUMN => 'USER_COLUMN_INSTANCE_ID',
             P_BASE_KEY_VALUE  => :NEW.USER_COLUMN_INSTANCE_ID);
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
end PAY_USER_COLUMN_INSTANCE_F_ovn;



/
ALTER TRIGGER "APPS"."PAY_USER_COLUMN_INSTANCE_F_OVN" ENABLE;
