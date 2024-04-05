--------------------------------------------------------
--  DDL for Trigger PAY_ZA_CDV_PARAM_WHO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ZA_CDV_PARAM_WHO" 
before insert or update on "HR"."PAY_ZA_CDV_PARAMETERS"
for each row
begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      if  inserting
      and :new.created_by    is null
      and :new.creation_date is null then

         :new.created_by    := fnd_global.user_id;
         :new.creation_date := sysdate;

      end if;

      :new.last_update_date  := sysdate;
      :new.last_updated_by   := fnd_global.user_id;
      :new.last_update_login := fnd_global.login_id;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_ZA_CDV_PARAM_WHO" ENABLE;
