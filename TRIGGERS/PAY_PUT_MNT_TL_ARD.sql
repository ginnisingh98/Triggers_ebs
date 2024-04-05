--------------------------------------------------------
--  DDL for Trigger PAY_PUT_MNT_TL_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PUT_MNT_TL_ARD" 

/*
  Maintain pay_user_tables_tl data in cases
  where dml is being performed outside
  api

*/

after delete
on "HR"."PAY_USER_TABLES"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and
     pay_put_shd.return_api_dml_status <> true and
     pay_user_tables_pkg.return_dml_status <> true ) then

  pay_ptt_del.del_tl ( P_USER_TABLE_ID=> :OLD.user_table_id ) ;

end if;
end pay_put_mnt_tl_ard;


/
ALTER TRIGGER "APPS"."PAY_PUT_MNT_TL_ARD" ENABLE;
