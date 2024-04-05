--------------------------------------------------------
--  DDL for Trigger PAY_PUR_MNT_TL_ASD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PUR_MNT_TL_ASD" 

/*
  Maintain pay_user_rows_f_tl data in cases
  where dml is being performed outside
  api

*/

after delete
on "HR"."PAY_USER_ROWS_F"
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_pur_shd.return_api_dml_status <> true ) then

    pay_mls_triggers.pur_asd();

end if;
end pay_pur_mnt_tl_asd;


/
ALTER TRIGGER "APPS"."PAY_PUR_MNT_TL_ASD" ENABLE;
