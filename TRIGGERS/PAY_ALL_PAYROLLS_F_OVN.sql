--------------------------------------------------------
--  DDL for Trigger PAY_ALL_PAYROLLS_F_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ALL_PAYROLLS_F_OVN" 
before insert or update on "HR"."PAY_ALL_PAYROLLS_F" for each row
begin
  if not
   pay_payroll_api.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.Get_Object_Version_Number
            (p_base_table_name => 'PAY_ALL_PAYROLLS_F',
             P_BASE_KEY_COLUMN => 'PAYROLL_ID',
             P_BASE_KEY_VALUE  => :NEW.PAYROLL_ID);
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
end PAY_ALL_PAYROLLS_F_OVN;



/
ALTER TRIGGER "APPS"."PAY_ALL_PAYROLLS_F_OVN" ENABLE;
