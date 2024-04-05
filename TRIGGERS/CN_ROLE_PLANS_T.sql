--------------------------------------------------------
--  DDL for Trigger CN_ROLE_PLANS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_ROLE_PLANS_T" 
  BEFORE INSERT OR DELETE OR UPDATE OF role_id, comp_plan_id, start_date, end_date
  ON "CN"."CN_ROLE_PLANS_ALL"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  l_role_name cn_roles.NAME%TYPE;
  l_org_id    cn_role_plans.org_id%TYPE;
BEGIN
  -- for deleting and inserting, pass in the start_date and end_date
  -- as old_start_date and old_end_date

  IF DELETING THEN
    l_role_name  := cn_api.get_role_name(:OLD.role_id);
    cn_mark_events_pkg.mark_event_role_plans(
      'CHANGE_SRP_ROLE_PLAN'     -- event name
    , l_role_name                -- object name
    , :OLD.role_id               -- object id
    , NULL                       -- start date
    , :OLD.start_date            -- start date old
    , NULL                       -- end date
    , :OLD.end_date              -- end date old
    , :OLD.org_id
    );
  ELSIF INSERTING THEN
    l_role_name  := cn_api.get_role_name(:NEW.role_id);
    cn_mark_events_pkg.mark_event_role_plans(
      'CHANGE_SRP_ROLE_PLAN'  -- event name
    , l_role_name             -- object name
    , :NEW.role_id            -- object id
    , NULL                    -- start date
    , :NEW.start_date         -- start date old
    , NULL                    -- end date
    , :NEW.end_date           -- end date old
    , :NEW.org_id
    );
  ELSE
    -- If update role_id, comp_plan_id  then mark event CHANGE_SRP_ROLE_PLAN
    -- If update start_date or end_date then mark event CHANGE_SRP_ROLE_PLAN_DATE
    IF (:NEW.role_id <> :OLD.role_id) OR(:NEW.comp_plan_id <> :OLD.comp_plan_id) THEN
      l_role_name  := cn_api.get_role_name(:OLD.role_id);
      cn_mark_events_pkg.mark_event_role_plans(
        'CHANGE_SRP_ROLE_PLAN'  -- event name
      , l_role_name             -- object name
      , :OLD.role_id            -- object id
      , :NEW.start_date         -- start date
      , :OLD.start_date         -- start date old
      , :NEW.end_date           -- end date
      , :OLD.end_date           -- end date old
      , :NEW.org_id
      );
    END IF;

    IF    (:NEW.start_date <> :OLD.start_date)
       OR (:NEW.end_date <> :OLD.end_date)
       OR (:NEW.end_date IS NOT NULL AND :OLD.end_date IS NULL)
       OR (:NEW.end_date IS NULL AND :OLD.end_date IS NOT NULL) THEN
      --         dbms_output.put_line('[cn_role_plans_t] fire for updating' ||
      --            ' event:CHANGE_SRP_ROLE_PLAN_DATE');
      l_role_name  := cn_api.get_role_name(:OLD.role_id);
      cn_mark_events_pkg.mark_event_role_plans(
        'CHANGE_SRP_ROLE_PLAN_DATE'   -- event name
      , l_role_name                   -- object name
      , :OLD.role_id                  -- object id
      , :NEW.start_date               -- start date
      , :OLD.start_date               -- start date old
      , :NEW.end_date                 -- end date
      , :OLD.end_date                 -- end date old
      , :NEW.org_id
      );
    END IF;
  END IF;
END cn_role_plans_t;
/
ALTER TRIGGER "APPS"."CN_ROLE_PLANS_T" ENABLE;
