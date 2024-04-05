--------------------------------------------------------
--  DDL for Trigger PAY_PCT_MNT_TL_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PCT_MNT_TL_ARD" 

/*
  Maintain pay_user_columns_tl data in cases
  where dml is being performed outside
  api

*/

after delete
on "HR"."PAY_USER_COLUMNS"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and
   pay_puc_shd.return_api_dml_status <> true and
   pay_user_columns_pkg.return_dml_status <> true ) then

pay_pct_del.del_tl(P_USER_COLUMN_ID               =>:OLD.user_column_id );

end if;
end pay_pct_mnt_tl_ard;


/
ALTER TRIGGER "APPS"."PAY_PCT_MNT_TL_ARD" ENABLE;
