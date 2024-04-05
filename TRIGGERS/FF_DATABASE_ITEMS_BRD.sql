--------------------------------------------------------
--  DDL for Trigger FF_DATABASE_ITEMS_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_DATABASE_ITEMS_BRD" 
/*
  FF_DATABASE_ITEMS Before Row Delete
  Checks whether it is legal to delete the database item by checking whether
  it is used by any existing formula.

  If the delete is legal then the FF_DATABASE_ITEMS_TL rows are deleted.
*/
before delete
on "HR"."FF_DATABASE_ITEMS"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' and
   ff_database_items_pkg.g_disable_triggers <> 'Y' then
  ffdict.delete_dbitem_check (:OLD.user_name, :OLD.user_entity_id);
  ff_database_items_pkg.delete_tl_rows(:OLD.user_name, :OLD.user_entity_id);
end if;
end ff_database_items_brd;


/
ALTER TRIGGER "APPS"."FF_DATABASE_ITEMS_BRD" ENABLE;
