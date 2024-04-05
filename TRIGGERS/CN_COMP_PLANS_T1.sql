--------------------------------------------------------
--  DDL for Trigger CN_COMP_PLANS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_COMP_PLANS_T1" 
  AFTER UPDATE
  ON "CN"."CN_COMP_PLANS_ALL"
  FOR EACH ROW
BEGIN
  IF UPDATING THEN
    IF :OLD.allow_rev_class_overlap <> :NEW.allow_rev_class_overlap THEN
      cn_mark_events_pkg.mark_event_comp_plan(
        p_event_name                 => 'CHANGE_COMP_PLAN_OVERLAP'
      , p_object_name                => :OLD.NAME
      , p_object_id                  => :OLD.comp_plan_id
      , p_start_date                 => NULL
      , p_start_date_old             => :OLD.start_date
      , p_end_date                   => NULL
      , p_end_date_old               => :OLD.end_date
      , p_org_id                     => :OLD.org_id
      );
    END IF;
  END IF;
END cn_comp_plans_t1;
/
ALTER TRIGGER "APPS"."CN_COMP_PLANS_T1" ENABLE;
