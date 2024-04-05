--------------------------------------------------------
--  DDL for Trigger CN_REPOSITORIES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_REPOSITORIES_T1" 
  AFTER UPDATE OF srp_rollup_flag, rev_class_hierarchy_id
  ON "CN"."CN_REPOSITORIES_ALL"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  l_name cn_head_hierarchies.NAME%TYPE;
BEGIN
  IF :NEW.rev_class_hierarchy_id <> :OLD.rev_class_hierarchy_id THEN
    IF :NEW.rev_class_hierarchy_id IS NOT NULL THEN
      SELECT NAME INTO l_name
        FROM cn_head_hierarchies_all_tl
       WHERE head_hierarchy_id = :NEW.rev_class_hierarchy_id
         AND org_id = :OLD.org_id
         AND LANGUAGE = USERENV('LANG');
    END IF;

    cn_mark_events_pkg.mark_event_sys_para(
      'CHANGE_SYS_PARA_RC'
    , l_name
    , :NEW.rev_class_hierarchy_id
    , :OLD.rev_class_hierarchy_id
    , :OLD.period_set_id
    , :OLD.period_type_id
    , NULL
    , NULL
    , NULL
    , NULL
    , :OLD.org_id
    );
  END IF;

  IF :NEW.srp_rollup_flag <> :OLD.srp_rollup_flag THEN
    cn_mark_events_pkg.mark_event_sys_para(
      'CHANGE_SYS_PARA_SRP'
    , 'SRP_ROLLUP_FLAG'
    , NULL
    , NULL
    , :OLD.period_set_id
    , :OLD.period_type_id
    , NULL
    , NULL
    , NULL
    , NULL
    , :OLD.org_id
    );
  END IF;
END cn_repositories_t1;
/
ALTER TRIGGER "APPS"."CN_REPOSITORIES_T1" ENABLE;
