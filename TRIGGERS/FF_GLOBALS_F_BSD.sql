--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_BSD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_BSD" 
Before Delete on "HR"."FF_GLOBALS_F"
Begin
if hr_general.g_data_migrator_mode <> 'Y' then
ff_del_global_pkg.Clear_Count;
end if;
End;

/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_BSD" ENABLE;
