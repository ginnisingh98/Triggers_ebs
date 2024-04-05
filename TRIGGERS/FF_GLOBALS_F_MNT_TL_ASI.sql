--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_MNT_TL_ASI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_MNT_TL_ASI" 

/*
  Maintain ff_globals_f_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."FF_GLOBALS_F"
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and ff_globals_f_pkg.return_dml_status <> true ) then

    pay_mls_triggers.glb_asi();

end if;
end ff_globals_f_mnt_tl_asi;


/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_MNT_TL_ASI" ENABLE;
