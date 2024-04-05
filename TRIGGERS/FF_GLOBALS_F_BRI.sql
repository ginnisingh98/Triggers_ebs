--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_BRI" 
/*
  FF_GLOBALS_F Before Row Insert
  Checks that new items have legal names
*/
before insert
on "HR"."FF_GLOBALS_F"
for each row
declare
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.create_global_dbitem(:NEW.global_name,
                              :NEW.data_type,
                              :NEW.global_id,
                              :NEW.business_group_id,
                              :NEW.legislation_code,
                              :NEW.created_by,
                              :NEW.creation_date);
end if;
end ff_globals_f_bri;

/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_BRI" ENABLE;
