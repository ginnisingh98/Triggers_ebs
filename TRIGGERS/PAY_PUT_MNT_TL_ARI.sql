--------------------------------------------------------
--  DDL for Trigger PAY_PUT_MNT_TL_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PUT_MNT_TL_ARI" 

/*
  Maintain pay_user_tables_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."PAY_USER_TABLES"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_put_shd.return_api_dml_status <> true
     and pay_user_tables_pkg.return_dml_status <> true) then

 pay_ptt_ins.ins_tl(     P_LANGUAGE_CODE        =>userenv('LANG')
                        ,P_USER_TABLE_ID        =>:NEW.user_table_id
                        ,P_USER_TABLE_NAME      =>:NEW.user_table_name
                        ,P_USER_ROW_TITLE       =>:NEW.user_row_title );

end if;
end pay_put_mnt_tl_ari;


/
ALTER TRIGGER "APPS"."PAY_PUT_MNT_TL_ARI" ENABLE;
