--------------------------------------------------------
--  DDL for Trigger FF_USER_ENTITIES_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_USER_ENTITIES_BRD" 
/*
  Set up user entity details for entity being deleted for reference in
  DB item deletion validation without hitting mutating table problem
*/
before delete
on "HR"."FF_USER_ENTITIES"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.set_ue_details (:OLD.user_entity_id,
                         :OLD.business_group_id,
                         :OLD.legislation_code);
end if;
end ff_user_entities_brd;

/
ALTER TRIGGER "APPS"."FF_USER_ENTITIES_BRD" ENABLE;
