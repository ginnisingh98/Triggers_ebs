--------------------------------------------------------
--  DDL for Trigger PAY_PCT_MNT_TL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PCT_MNT_TL_ARU" 

/*
  Maintain pay_user_columns_tl data in cases
  where dml is being performed outside
  api

*/

after update
on "HR"."PAY_USER_COLUMNS"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and
   pay_puc_shd.return_api_dml_status <> true and
   pay_user_columns_pkg.return_dml_status <> true ) then

 pay_pct_upd.upd_tl(
                     P_LANGUAGE_CODE                =>userenv('LANG')
                     ,P_USER_COLUMN_ID               =>:NEW.user_column_id
                     ,P_USER_COLUMN_NAME             =>:NEW.user_column_name
 );

end if;
end pay_pct_mnt_tl_aru;


/
ALTER TRIGGER "APPS"."PAY_PCT_MNT_TL_ARU" ENABLE;
