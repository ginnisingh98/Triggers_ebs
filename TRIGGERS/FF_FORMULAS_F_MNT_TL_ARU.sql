--------------------------------------------------------
--  DDL for Trigger FF_FORMULAS_F_MNT_TL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_ARU" 

/*
  Maintain ff_formulas_f_tl data in cases
  where dml is being performed outside
  api

*/

after update
on "HR"."FF_FORMULAS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( ff_formulas_f_pkg.return_dml_status <> true ) then

   ff_fft_upd.upd_tl(  P_LANGUAGE_CODE  =>userenv('LANG')
                      ,P_FORMULA_ID     =>:NEW.formula_id
                      ,P_FORMULA_NAME   =>:New.formula_name
                      ,P_DESCRIPTION    =>:NEW.description
                                 );

end if;
end ff_formulas_f_mnt_tl_aru;

/
ALTER TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_ARU" ENABLE;
