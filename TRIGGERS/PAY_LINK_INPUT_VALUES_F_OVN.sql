--------------------------------------------------------
--  DDL for Trigger PAY_LINK_INPUT_VALUES_F_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_LINK_INPUT_VALUES_F_OVN" 
before insert or update on "HR"."PAY_LINK_INPUT_VALUES_F" for each row
begin
  if not
   pay_liv_shd.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.Get_Object_Version_Number
            (p_base_table_name => 'PAY_LINK_INPUT_VALUES_F',
             P_BASE_KEY_COLUMN => 'LINK_INPUT_VALUE_ID',
             P_BASE_KEY_VALUE  => :NEW.LINK_INPUT_VALUE_ID);
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
end pay_link_input_values_f_ovn;



/
ALTER TRIGGER "APPS"."PAY_LINK_INPUT_VALUES_F_OVN" ENABLE;
