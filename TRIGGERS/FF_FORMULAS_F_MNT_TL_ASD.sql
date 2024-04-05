--------------------------------------------------------
--  DDL for Trigger FF_FORMULAS_F_MNT_TL_ASD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_ASD" 

/*
  Maintain ff_formulas_f_tl data in cases
  where dml is being performed outside
  api

*/

after delete
on "HR"."FF_FORMULAS_F"
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( ff_formulas_f_pkg.return_dml_status <> true ) then

    pay_mls_triggers.fml_asd();

end if;
end ff_formulas_f_mnt_tl_asd;

/
ALTER TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_ASD" ENABLE;
