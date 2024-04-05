--------------------------------------------------------
--  DDL for Trigger FF_ARCHIVE_ITEMS_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_ARCHIVE_ITEMS_BRU" 
before insert or update on "HR"."FF_ARCHIVE_ITEMS" for each row
begin
 if hr_general.g_data_migrator_mode <> 'Y' then
  if inserting then
    :NEW.object_version_number := 1;
  else
    :NEW.object_version_number := :OLD.object_version_number + 1;
  end if;
 end if;
end FF_ARCHIVE_ITEMS_BRU;


/
ALTER TRIGGER "APPS"."FF_ARCHIVE_ITEMS_BRU" ENABLE;
