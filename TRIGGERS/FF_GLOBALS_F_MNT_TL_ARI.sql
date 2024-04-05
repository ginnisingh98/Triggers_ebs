--------------------------------------------------------
--  DDL for Trigger FF_GLOBALS_F_MNT_TL_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_GLOBALS_F_MNT_TL_ARI" 

/*
  Maintain ff_globals_f_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."FF_GLOBALS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and ff_globals_f_pkg.return_dml_status <> true ) then

   pay_mls_triggers.glb_ari(  P_GLOBAL_ID             =>:NEW.global_id
                                  ,P_GLOBAL_DESCRIPTION_O  => null
                                  ,P_GLOBAL_DESCRIPTION_N  =>:NEW.global_description
                                  ,P_GLOBAL_NAME_O         => null
                                  ,P_GLOBAL_NAME_N         =>:NEW.global_name
                                 );

end if;
end ff_globals_f_mnt_tl_ari;


/
ALTER TRIGGER "APPS"."FF_GLOBALS_F_MNT_TL_ARI" ENABLE;
