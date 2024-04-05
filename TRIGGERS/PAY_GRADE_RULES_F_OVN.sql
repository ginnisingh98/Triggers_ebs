--------------------------------------------------------
--  DDL for Trigger PAY_GRADE_RULES_F_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_GRADE_RULES_F_OVN" 
before insert or update on "HR"."PAY_GRADE_RULES_F" for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  if not pay_grr_shd.return_api_dml_status then
    if inserting then
      begin
        :NEW.object_version_number :=
          dt_api.Get_Object_Version_Number
            (P_BASE_TABLE_NAME => 'PAY_GRADE_RULES_F',
             P_BASE_KEY_COLUMN => 'GRADE_RULE_ID',
             P_BASE_KEY_VALUE  => :NEW.grade_rule_id);
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
end pay_grade_rules_f_ovn;



/
ALTER TRIGGER "APPS"."PAY_GRADE_RULES_F_OVN" ENABLE;
