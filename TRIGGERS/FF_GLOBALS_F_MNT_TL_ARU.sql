--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_MNT_TL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_MNT_TL_ARU" 

/*
  Maintain ff_globals_f_tl data in cases
  where dml is being performed outside
  api

*/

after update
on "HR"."FF_GLOBALS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and ff_globals_f_pkg.return_dml_status <> true ) then

   ff_fgt_upd.upd_tl(  P_LANGUAGE_CODE        =>userenv('LANG')
                       ,P_GLOBAL_ID            =>:OLD.global_id
                       ,P_GLOBAL_NAME          =>:NEW.global_name
                       ,P_GLOBAL_DESCRIPTION   =>:NEW.global_description
                                 );

end if;
end ff_globals_f_mnt_tl_aru;


/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_MNT_TL_ARU" ENABLE;
