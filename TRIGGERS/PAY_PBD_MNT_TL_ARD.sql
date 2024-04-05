--------------------------------------------------------
--  DDL for Trigger PAY_PBD_MNT_TL_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_PBD_MNT_TL_ARD" 

/*
  Maintain pay_balance_dimensions_tl data in cases
  where dml is being performed outside
  api

*/

after delete
on "HR"."PAY_BALANCE_DIMENSIONS"
for each row
declare
begin
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( pay_balance_dimension_api.return_dml_status <> true ) then

    pay_bdt_del.del_tl(P_BALANCE_DIMENSION_ID => :OLD.balance_dimension_id ) ;

end if;
end pay_pbd_mnt_tl_ard;


/
ALTER TRIGGER "APPS"."PAY_PBD_MNT_TL_ARD" ENABLE;
