--------------------------------------------------------
--  DDL for Trigger PAY_PBC_MNT_TL_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PBC_MNT_TL_BRD" 

/*
  Maintain pay_balance_categories_f_tl data in cases
  where dml is being performed outside
  api

*/

before delete
on "HR"."PAY_BALANCE_CATEGORIES_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_balance_category_api.return_dml_status <> true ) then

    pay_mls_triggers.pbc_brd(P_BALANCE_CATEGORY_ID    =>:OLD.balance_category_id);

end if;
end pay_pbc_mnt_tl_brd;


/
ALTER TRIGGER "APPS"."PAY_PBC_MNT_TL_BRD" ENABLE;
