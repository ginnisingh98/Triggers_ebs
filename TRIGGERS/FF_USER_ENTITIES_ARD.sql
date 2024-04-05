--------------------------------------------------------
--  DDL for Trigger FF_USER_ENTITIES_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_USER_ENTITIES_ARD" 
/*
  Clear user entity details for entity deleted
*/
after delete
on "HR"."FF_USER_ENTITIES"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.clear_ue_details;
  delete from ff_database_items_tl
  where user_entity_id = :OLD.user_entity_id
  ;
end if;
end ff_user_entities_ard;

/
ALTER TRIGGER "APPS"."FF_USER_ENTITIES_ARD" ENABLE;
