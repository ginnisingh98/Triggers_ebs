--------------------------------------------------------
--  DDL for Trigger FF_FUNCTIONS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FUNCTIONS_BRU" 
/*
  Check the updated function details
*/
before update
on "HR"."FF_FUNCTIONS"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
   if (:NEW.alias_name is not null or :OLD.alias_name is not null) then
    if ((:NEW.name = :OLD.alias_name) or
        (:NEW.name = :NEW.alias_name) or
        (:NEW.alias_name = :OLD.name)) then
      -- Trap giving the same name for alias and function
    hr_utility.set_message(802,'FF52_NAME_ALREADY_USED');
    hr_utility.set_message_token('1',:NEW.name||','||:NEW.alias_name);
    hr_utility.set_message_token(802,'2','FF95_FUNCTION');
    hr_utility.raise_error;
    end if;
  end if;
end if;
end ff_functions_bru;



/
ALTER TRIGGER "APPS"."FF_FUNCTIONS_BRU" ENABLE;
