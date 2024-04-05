--------------------------------------------------------
--  DDL for Trigger FF_DATABASE_ITEMS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_DATABASE_ITEMS_BRU" 
/*
  Only allow DB item to be updated if not used in a verified formula
*/
before update
on "HR"."FF_DATABASE_ITEMS"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' and
   ff_database_items_pkg.g_disable_triggers <> 'Y' then
  ffdict.delete_dbitem_check (:OLD.user_name, :OLD.user_entity_id);
end if;
end ff_database_items_bru;


/
ALTER TRIGGER "APPS"."FF_DATABASE_ITEMS_BRU" ENABLE;
