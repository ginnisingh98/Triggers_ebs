--------------------------------------------------------
--  DDL for Trigger PAY_PUR_MNT_TL_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PUR_MNT_TL_BRD" 

/*
  Maintain pay_user_rows_f_tl data in cases
  where dml is being performed outside
  api

*/

before delete
on "HR"."PAY_USER_ROWS_F"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_pur_shd.return_api_dml_status <> true ) then

    pay_mls_triggers.pur_brd(P_USER_ROW_ID    =>:OLD.user_row_id);

end if;
end pay_pur_mnt_tl_brd;


/
ALTER TRIGGER "APPS"."PAY_PUR_MNT_TL_BRD" ENABLE;
