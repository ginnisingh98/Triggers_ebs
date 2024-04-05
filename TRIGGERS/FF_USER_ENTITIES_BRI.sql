--------------------------------------------------------
--  DDL for Trigger FF_USER_ENTITIES_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_USER_ENTITIES_BRI" 
/*
  FF_USER_ENTITIES Before Row Insert
  Checks that new items have legal names
*/
before insert
on "HR"."FF_USER_ENTITIES"
for each row
declare
  new_user_entity_name ff_user_entities.user_entity_name%TYPE;
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  -- bug 153833 workaround. Remove in 7.0.14
  new_user_entity_name := :NEW.user_entity_name;
  ffdict.validate_user_entity (new_user_entity_name,
                               :NEW.business_group_id,
                               :NEW.legislation_code);
end if;
end ff_user_entities_bri;

/
ALTER TRIGGER "APPS"."FF_USER_ENTITIES_BRI" ENABLE;
