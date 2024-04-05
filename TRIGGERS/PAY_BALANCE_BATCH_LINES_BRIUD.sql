--------------------------------------------------------
--  DDL for Trigger PAY_BALANCE_BATCH_LINES_BRIUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_BALANCE_BATCH_LINES_BRIUD" 
before insert or update or delete
on     "HR"."PAY_BALANCE_BATCH_LINES"
for    each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  if inserting or updating then
    pay_balance_upload.lock_batch_header(:new.batch_id);
  elsif deleting then
    pay_balance_upload.lock_batch_header(:old.batch_id);
  end if;
end if;
end pay_batch_lines_bruid;



/
ALTER TRIGGER "APPS"."PAY_BALANCE_BATCH_LINES_BRIUD" ENABLE;
