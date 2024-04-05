--------------------------------------------------------
--  DDL for Trigger PAY_ELEMENT_SETS_MNT_TL_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ELEMENT_SETS_MNT_TL_ARI" 

/*
  Maintain pay_element_sets_tl data in cases
  where dml is being performed outside
  api

*/

after insert
on "HR"."PAY_ELEMENT_SETS"
for each row
declare
begin
--For sustaining dual maintenance---
if(PAY_ADHOC_UTILS_PKG.chk_post_r11i = 'Y') then
if ( hr_general.g_data_migrator_mode <> 'Y') and
   ( pay_element_sets_pkg.return_dml_status <> true ) then

pay_est_ins.ins_tl(P_LANGUAGE_CODE =>userenv('LANG'),
                           P_ELEMENT_SET_ID => :NEW.element_set_id,
			   P_ELEMENT_SET_NAME => :NEW.element_set_name);

end if;
end if;
end pay_element_sets_mnt_tl_ari;

/
ALTER TRIGGER "APPS"."PAY_ELEMENT_SETS_MNT_TL_ARI" ENABLE;
