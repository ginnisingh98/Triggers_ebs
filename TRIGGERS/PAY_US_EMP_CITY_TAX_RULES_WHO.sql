--------------------------------------------------------
--  DDL for Trigger PAY_US_EMP_CITY_TAX_RULES_WHO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_US_EMP_CITY_TAX_RULES_WHO" 
before insert or update on "HR"."PAY_US_EMP_CITY_TAX_RULES_F"
for each row
declare
 l_sysdate DATE := sysdate;
begin
  -- Trigger generated by hrcretrg2.sql at 2007/01/04 13:26:47.
 if hr_general.g_data_migrator_mode <> 'Y' then 
  if inserting and 
      :new.created_by    is null and 
      :new.creation_date is null then
    :new.created_by      := fnd_global.user_id;
    :new.creation_date   := l_sysdate;
  end if;
  :new.last_update_date  := l_sysdate;
  :new.last_updated_by   := fnd_global.user_id;
  :new.last_update_login := fnd_global.login_id;
 end if;
end;


/
ALTER TRIGGER "APPS"."PAY_US_EMP_CITY_TAX_RULES_WHO" ENABLE;
