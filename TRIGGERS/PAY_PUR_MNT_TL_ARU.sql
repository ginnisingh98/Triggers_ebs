--------------------------------------------------------
--  DDL for Trigger PAY_PUR_MNT_TL_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PUR_MNT_TL_ARU" 

/*
  Maintain pay_user_rows_f_tl data in cases
  where dml is being performed outside
  api

*/

after update
on "HR"."PAY_USER_ROWS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_pur_shd.return_api_dml_status <> true ) then

   pay_urt_upd.upd_tl(  P_LANGUAGE_CODE                =>userenv('LANG')
                       ,P_USER_ROW_ID                  =>:NEW.user_row_id
                       ,P_ROW_LOW_RANGE_OR_NAME        =>:NEW.row_low_range_or_name
                                 );

end if;
end pay_pur_mnt_tl_aru;


/
ALTER TRIGGER "APPS"."PAY_PUR_MNT_TL_ARU" ENABLE;
