--------------------------------------------------------
--  DDL for Trigger FF_USER_ENTITIES_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_USER_ENTITIES_BRU" 
/*
  The FF_USER_ENTITIES cannot be updated
*/
before update
on "HR"."FF_USER_ENTITIES"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  hr_utility.set_message (801,'FF73_CANNOT_UPDATE_DETAILS');
  hr_utility.set_message_token(801,'1','FF94_USER_ENTITY');
  hr_utility.raise_error;
end if;
end ff_user_entities_bru;

/
ALTER TRIGGER "APPS"."FF_USER_ENTITIES_BRU" ENABLE;
