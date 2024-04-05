--------------------------------------------------------
--  DDL for Trigger HR_TRAN_STEP_UPDATE_PERSON_ID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."HR_TRAN_STEP_UPDATE_PERSON_ID" 
before insert or update on "HR"."HR_API_TRANSACTION_STEPS" for each row

begin

  SELECT iav.number_value
  INTO :NEW.update_person_id
  FROM wf_item_attribute_values iav
  WHERE iav.item_type = :NEW.item_type
  AND iav.item_key = :NEW.item_key
  AND iav.name  = 'CURRENT_PERSON_ID';

exception
  when others then
    :NEW.update_person_id := -1;

end per_events_ovn;



/
ALTER TRIGGER "APPS"."HR_TRAN_STEP_UPDATE_PERSON_ID" ENABLE;
