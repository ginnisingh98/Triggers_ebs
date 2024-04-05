--------------------------------------------------------
--  DDL for Trigger FF_DATABASE_ITEMS_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_DATABASE_ITEMS_ARI" 
/*
  FF_DATABASE_ITEMS After Row Insert
  Create the FF_DATABASE_ITEM_TL rows.
*/
after insert
on "HR"."FF_DATABASE_ITEMS"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' and
   ff_database_items_pkg.g_disable_triggers <> 'Y' then
 ff_database_items_pkg.insert_tl_rows
 (X_USER_NAME            => :NEW.user_name
 ,X_USER_ENTITY_ID       => :NEW.user_entity_id
 ,X_LANGUAGE             => USERENV('LANG')
 ,X_TRANSLATED_USER_NAME => :NEW.user_name
 ,X_DESCRIPTION          => :NEW.description
 );
end if;
end ff_database_items_ari;


/
ALTER TRIGGER "APPS"."FF_DATABASE_ITEMS_ARI" ENABLE;
