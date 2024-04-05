--------------------------------------------------------
--  DDL for Trigger PAY_PERSONAL_PAYMENT_METHO_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PERSONAL_PAYMENT_METHO_OVN" 
before insert or update on "HR"."PAY_PERSONAL_PAYMENT_METHODS_F" for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  if not pay_ppm_shd.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.get_object_version_number
            (p_base_table_name => 'PAY_PERSONAL_PAYMENT_METHODS_F',
             P_BASE_KEY_COLUMN => 'PERSONAL_PAYMENT_METHOD_ID',
             P_BASE_KEY_VALUE  => :NEW.personal_payment_method_id);
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
end pay_personal_payment_metho_ovn;



/
ALTER TRIGGER "APPS"."PAY_PERSONAL_PAYMENT_METHO_OVN" ENABLE;
