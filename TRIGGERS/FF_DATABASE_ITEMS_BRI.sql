--------------------------------------------------------
--  DDL for Trigger FF_DATABASE_ITEMS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_DATABASE_ITEMS_BRI" 
/*
  FF_DATABASE_ITEMS Before Row Insert
  Checks that new items have legal names
*/
before insert
on "HR"."FF_DATABASE_ITEMS"
for each row
declare
  new_user_name ff_database_items.user_name%TYPE;
begin
if hr_general.g_data_migrator_mode <> 'Y' and
   ff_database_items_pkg.g_disable_triggers <> 'Y' then
  -- bug 153833 workaround. Remove in 7.0.14
  new_user_name := :NEW.user_name;
  ffdict.validate_dbitem (new_user_name, :NEW.user_entity_id);
end if;
end ff_database_items_bri;


/
ALTER TRIGGER "APPS"."FF_DATABASE_ITEMS_BRI" ENABLE;
