--------------------------------------------------------
--  DDL for Trigger PAY_PBC_MNT_TL_ASI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PBC_MNT_TL_ASI" 

/*
  Maintain pay_balance_categories_f_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."PAY_BALANCE_CATEGORIES_F"
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_balance_category_api.return_dml_status <> true ) then


    pay_mls_triggers.pbc_asi();

end if;
end pay_pbc_mnt_tl_asi;


/
ALTER TRIGGER "APPS"."PAY_PBC_MNT_TL_ASI" ENABLE;
