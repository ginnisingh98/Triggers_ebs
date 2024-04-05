--------------------------------------------------------
--  DDL for Trigger PAY_PBC_MNT_TL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PBC_MNT_TL_ARU" 

/*
  Maintain pay_balance_categories_f_tl data in cases
  where dml is being performed outside
  api

*/

after update
on "HR"."PAY_BALANCE_CATEGORIES_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_balance_category_api.return_dml_status <> true ) then

   pay_tbc_upd.upd_tl(   P_LANGUAGE_CODE                =>userenv('LANG')
                        ,P_BALANCE_CATEGORY_ID          =>:NEW.balance_category_id
                        ,P_USER_CATEGORY_NAME           =>:NEW.user_category_name
                                 );

end if;
end pay_pbc_mnt_tl_aru;


/
ALTER TRIGGER "APPS"."PAY_PBC_MNT_TL_ARU" ENABLE;
