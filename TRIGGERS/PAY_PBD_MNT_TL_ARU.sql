--------------------------------------------------------
--  DDL for Trigger PAY_PBD_MNT_TL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PBD_MNT_TL_ARU" 

/*
  Maintain pay_balance_dimensions_tl data in cases
  where dml is being performed outside
  api

*/

after update
on "HR"."PAY_BALANCE_DIMENSIONS"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( pay_balance_dimension_api.return_dml_status <> true ) then

 pay_bdt_upd.upd_tl (  P_LANGUAGE_CODE                => userenv('LANG')
                      ,P_BALANCE_DIMENSION_ID         =>:NEW.balance_dimension_id
                      ,P_DIMENSION_NAME               =>:NEW.dimension_name
                      ,P_DATABASE_ITEM_SUFFIX         =>:NEW.database_item_suffix
                      ,P_DESCRIPTION                  =>:NEW.description );

end if;
end pay_pbd_mnt_tl_aru;


/
ALTER TRIGGER "APPS"."PAY_PBD_MNT_TL_ARU" ENABLE;
