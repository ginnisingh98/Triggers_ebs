--------------------------------------------------------
--  DDL for Trigger PER_EVENTS_OVN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PER_EVENTS_OVN" 
before insert or update on "HR"."PER_EVENTS" for each row

begin
  if not
    per_evt_shd.return_api_dml_status then
    if inserting then
      :NEW.object_version_number := 1;
    else
      :NEW.object_version_number := :OLD.object_version_number + 1;
    end if;
  end if;
end per_events_ovn;


/
ALTER TRIGGER "APPS"."PER_EVENTS_OVN" ENABLE;
