--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_AD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_AD" 
After Delete
on "HR"."FF_GLOBALS_F"

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ff_del_global_pkg.Delete_User_Entity;
end if;
end ff_globals_f_brd;



/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_AD" ENABLE;
