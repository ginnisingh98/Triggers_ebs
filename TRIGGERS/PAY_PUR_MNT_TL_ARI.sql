--------------------------------------------------------
--  DDL for Trigger PAY_PUR_MNT_TL_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PUR_MNT_TL_ARI" 

/*
  Maintain pay_user_rows_f_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."PAY_USER_ROWS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_pur_shd.return_api_dml_status <> true ) then

   pay_mls_triggers.pur_ari(  P_USER_ROW_ID                  =>:NEW.user_row_id
                             ,P_ROW_LOW_RANGE_OR_NAME_N      =>:NEW.row_low_range_or_name
                             ,P_ROW_LOW_RANGE_OR_NAME_O      => null
                           );

end if;
end pay_pur_mnt_tl_ari;


/
ALTER TRIGGER "APPS"."PAY_PUR_MNT_TL_ARI" ENABLE;
