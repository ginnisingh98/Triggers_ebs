--------------------------------------------------------
--  DDL for Trigger FF_FORMULAS_F_MNT_TL_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_ARI" 
/*
  Maintain ff_formulas_f_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."FF_FORMULAS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( ff_formulas_f_pkg.return_dml_status <> true ) then

   pay_mls_triggers.fml_ari(   P_FORMULA_ID           =>:NEW.formula_id
                              ,P_FORMULA_NAME_O       => null
                              ,P_FORMULA_NAME_N       =>:NEW.formula_name
                              ,P_DESCRIPTION_O        => null
                              ,P_DESCRIPTION_N        =>:NEW.description
                                 );

end if;
end ff_formulas_f_mnt_tl_ari;

/
ALTER TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_ARI" ENABLE;
