--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_TL_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_TL_BRU" 
/*
  FF_GLOBALS_F Before Row Update
  Only allow global to be updated if not used in a verified formula
*/
before update
on "HR"."FF_GLOBALS_F_TL"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  --
  -- Update the corresponding FF_DATABASE_ITEMS_TL row.
  --
  ffdict.update_global_dbitem(p_global_id    => :OLD.global_id
                             ,p_new_name     => :NEW.global_name
                             ,p_description  => :NEW.global_description
                             ,p_source_lang  => :NEW.source_lang
                             ,p_language     => :NEW.language);
end if;
end ff_globals_f_tl_bru;

/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_TL_BRU" ENABLE;
