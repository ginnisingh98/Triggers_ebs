--------------------------------------------------------
--  DDL for Trigger FF_FORMULAS_F_MNT_TL_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_BRD" 

/*
  Maintain ff_formulas_f_tl data in cases
  where dml is being performed outside
  api

*/

before delete
on "HR"."FF_FORMULAS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( ff_formulas_f_pkg.return_dml_status <> true ) then

    pay_mls_triggers.fml_brd(P_FORMULA_ID    =>:OLD.formula_id);

end if;
end ff_formulas_f_mnt_tl_brd;

/
ALTER TRIGGER "APPS"."FF_FORMULAS_F_MNT_TL_BRD" ENABLE;
