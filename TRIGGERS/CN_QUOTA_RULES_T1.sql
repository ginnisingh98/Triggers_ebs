--------------------------------------------------------
--  DDL for Trigger CN_QUOTA_RULES_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_QUOTA_RULES_T1" 
  AFTER DELETE OR INSERT OR UPDATE
  ON "CN"."CN_QUOTA_RULES_ALL"
  FOR EACH ROW
DECLARE
  l_name   cn_quotas_all.NAME%TYPE;
  l_org_id cn_quotas_all.org_id%TYPE;
BEGIN
  IF INSERTING THEN
    BEGIN
      SELECT NAME, org_id INTO l_name, l_org_id
        FROM cn_quotas_all
       WHERE quota_id = :NEW.quota_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    cn_mark_events_pkg.mark_event_quota(
      p_event_name                 => 'CHANGE_QUOTA_ROLL'
    , p_object_name                => l_name
    , p_object_id                  => :NEW.quota_id
    , p_start_date                 => NULL
    , p_start_date_old             => NULL
    , p_end_date                   => NULL
    , p_end_date_old               => NULL
    , p_org_id                     => l_org_id
    );
  ELSIF DELETING THEN
    BEGIN
      SELECT NAME, org_id INTO l_name, l_org_id
        FROM cn_quotas_all
       WHERE quota_id = :OLD.quota_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    cn_mark_events_pkg.mark_event_quota(
      p_event_name                 => 'CHANGE_QUOTA_ROLL'
    , p_object_name                => l_name
    , p_object_id                  => :OLD.quota_id
    , p_start_date                 => NULL
    , p_start_date_old             => NULL
    , p_end_date                   => NULL
    , p_end_date_old               => NULL
    , p_org_id                     => l_org_id
    );
  ELSIF UPDATING THEN
    IF :OLD.revenue_class_id <> :NEW.revenue_class_id THEN
      BEGIN
        SELECT NAME, org_id INTO l_name, l_org_id
          FROM cn_quotas_all
         WHERE quota_id = :OLD.quota_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      cn_mark_events_pkg.mark_event_quota(
        p_event_name                 => 'CHANGE_QUOTA_ROLL'
      , p_object_name                => l_name
      , p_object_id                  => :OLD.quota_id
      , p_start_date                 => NULL
      , p_start_date_old             => NULL
      , p_end_date                   => NULL
      , p_end_date_old               => NULL
      , p_org_id                     => l_org_id
      );
    END IF;
  END IF;
END cn_quota_rules_t1;
/
ALTER TRIGGER "APPS"."CN_QUOTA_RULES_T1" ENABLE;
