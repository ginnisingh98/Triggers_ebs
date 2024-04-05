--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_BRU" 
/*
  FF_GLOBALS_F Before Row Update
  Only allow global to be updated if not used in a verified formula
*/
before update
on "HR"."FF_GLOBALS_F"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  -- disallow update of any significant column (which would require change
  -- to third party records in FF dictionary)
  if :OLD.global_name <> :NEW.global_name or
     :OLD.data_type <> :NEW.data_type or
     :OLD.global_id <> :NEW.global_id
  then
    hr_utility.set_message(801,'FF73_CANNOT_UPDATE_DETAILS');
    hr_utility.set_message_token('1',:OLD.global_name);
    hr_utility.set_message_token(801,'2','FF90_GLOBAL_NAME');
    hr_utility.raise_error;
  end if;
end if;
end ff_globals_f_bru;

/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_BRU" ENABLE;
