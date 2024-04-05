--------------------------------------------------------
--  DDL for Trigger CN_RULESETS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_RULESETS_T1" 
  AFTER UPDATE OF ruleset_status, start_date, end_date
  ON "CN"."CN_RULESETS_ALL_B"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  l_ruleset_name cn_rulesets.NAME%TYPE;
  l_org_id       cn_rulesets.org_id%TYPE;
BEGIN
  -- Fixed by Kumar.
  -- Added the where with the org ID in it.
  SELECT NAME, org_id INTO l_ruleset_name, l_org_id
    FROM cn_rulesets_all_tl
   WHERE ruleset_id = :NEW.ruleset_id AND org_id = :NEW.org_id AND LANGUAGE = USERENV('LANG');

  IF (:NEW.ruleset_status <> :OLD.ruleset_status) THEN
    cn_mark_events_pkg.mark_event_cls_rule(
      'CHANGE_CLS_RULES'
    , l_ruleset_name
    , :NEW.ruleset_id
    , NULL
    , :OLD.start_date
    , NULL
    , :OLD.end_date
    , :OLD.org_id
    );
  END IF;

  IF    (:NEW.start_date <> :OLD.start_date)
     OR (:OLD.end_date IS NULL AND :NEW.end_date IS NOT NULL)
     OR (:OLD.end_date IS NOT NULL AND :NEW.end_date IS NULL)
     OR (:OLD.end_date IS NOT NULL AND :NEW.end_date IS NOT NULL AND :OLD.end_date <> :NEW.end_date) THEN
    IF :NEW.ruleset_status = :OLD.ruleset_status AND :NEW.ruleset_status = 'GENERATED' THEN
      cn_mark_events_pkg.mark_event_cls_rule(
        'CHANGE_CLS_RULES_DATE'
      , l_ruleset_name
      , :NEW.ruleset_id
      , :NEW.start_date
      , :OLD.start_date
      , :NEW.end_date
      , :OLD.end_date
      , :OLD.org_id
      );
    END IF;
  END IF;
END cn_rulesets_t1;
/
ALTER TRIGGER "APPS"."CN_RULESETS_T1" ENABLE;
