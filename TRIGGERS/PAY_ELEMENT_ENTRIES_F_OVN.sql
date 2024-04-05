--------------------------------------------------------
--  DDL for Trigger PAY_ELEMENT_ENTRIES_F_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ELEMENT_ENTRIES_F_OVN" 
before insert or update on "HR"."PAY_ELEMENT_ENTRIES_F" for each row
begin
--  if hr_general.g_data_migrator_mode <> 'Y' then
    if inserting then
       if :NEW.object_version_number is null then
          :NEW.object_version_number := 1;
       end if;
    else
       :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
 -- end if;
end pay_element_entries_f_ovn;



/
ALTER TRIGGER "APPS"."PAY_ELEMENT_ENTRIES_F_OVN" ENABLE;
