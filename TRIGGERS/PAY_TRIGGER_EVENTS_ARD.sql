--------------------------------------------------------
--  DDL for Trigger PAY_TRIGGER_EVENTS_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_TRIGGER_EVENTS_ARD" 
AFTER DELETE ON "HR"."PAY_TRIGGER_EVENTS"
FOR EACH ROW

BEGIN
 if hr_general.g_data_migrator_mode <> 'Y' then
  paywsdyg_pkg.drop_trigger(
    paywsdyg_pkg.get_trigger_name(
      :old.event_id,
      :old.table_name,
      :old.triggering_action
    )
  );
 end if;
END;



/
ALTER TRIGGER "APPS"."PAY_TRIGGER_EVENTS_ARD" ENABLE;
