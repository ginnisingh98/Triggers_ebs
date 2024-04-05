--------------------------------------------------------
--  DDL for Trigger PAY_ELEMENT_SETS_MNT_TL_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ELEMENT_SETS_MNT_TL_ARD" 

/*
  Maintain pay_element_sets_tl data in cases
  where dml is being performed outside
  api

*/

after delete
on "HR"."PAY_ELEMENT_SETS"
for each row
declare
begin
--For sustaining dual maintenance---
if(PAY_ADHOC_UTILS_PKG.chk_post_r11i = 'Y') then
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( pay_element_sets_pkg.return_dml_status <> true ) then

 pay_est_del.del_tl(P_ELEMENT_SET_ID => :NEW.element_set_id);

end if;
end if;
end pay_element_sets_mnt_tl_ard;

/
ALTER TRIGGER "APPS"."PAY_ELEMENT_SETS_MNT_TL_ARD" ENABLE;
