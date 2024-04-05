--------------------------------------------------------
--  DDL for Trigger PAY_BATCH_CONTROL_TOTALS_BRUID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_BATCH_CONTROL_TOTALS_BRUID" 
before insert or update or delete
on "HR"."PAY_BATCH_CONTROL_TOTALS"
for each row

begin
if (hr_general.g_data_migrator_mode <> 'Y' and payplnk.g_payplnk_call = false) then
  hr_batch_lock_pkg.batch_header_lock(:old.batch_id,:new.batch_id);
end if;
end pay_batch_control_totals;


/
ALTER TRIGGER "APPS"."PAY_BATCH_CONTROL_TOTALS_BRUID" ENABLE;
