--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_BRD" 
Before Delete on "HR"."FF_GLOBALS_F"
for each row
Begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ff_del_global_pkg.Add_Global(:OLD.global_id);
end if;
End;

/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_BRD" ENABLE;
