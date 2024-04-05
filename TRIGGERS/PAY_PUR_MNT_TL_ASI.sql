--------------------------------------------------------
--  DDL for Trigger PAY_PUR_MNT_TL_ASI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PUR_MNT_TL_ASI" 

/*
  Maintain pay_user_rows_f_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."PAY_USER_ROWS_F"
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y' and pay_pur_shd.return_api_dml_status <> true ) then

    pay_mls_triggers.pur_asi();

end if;
end pay_pur_mnt_tl_asi ;


/
ALTER TRIGGER "APPS"."PAY_PUR_MNT_TL_ASI" ENABLE;
