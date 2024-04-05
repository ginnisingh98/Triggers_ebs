--------------------------------------------------------
--  DDL for Trigger FF_CONTEXTS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_CONTEXTS_BRU" 
/*
  The FF_CONTEXTS table cannot be updated due to the horrendous validation
  required. Must do a delete and then re-insert
*/
before update
on "HR"."FF_CONTEXTS"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  hr_utility.set_message (801,'FF73_CANNOT_UPDATE_DETAILS');
  hr_utility.set_message_token(801,'1','FF92_CONTEXT');
  hr_utility.raise_error;
end if;
end ff_contexts_bru;

/
ALTER TRIGGER "APPS"."FF_CONTEXTS_BRU" ENABLE;
