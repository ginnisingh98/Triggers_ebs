--------------------------------------------------------
--  DDL for Trigger CN_RT_QUOTA_ASGNS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_RT_QUOTA_ASGNS_T1" 
  AFTER DELETE OR INSERT OR UPDATE
  ON "CN"."CN_RT_QUOTA_ASGNS_ALL"
  FOR EACH ROW
DECLARE
  l_name   cn_quotas_all.NAME%TYPE;
  l_org_id cn_quotas_all.org_id%TYPE;
BEGIN
  IF INSERTING THEN
    BEGIN
      SELECT q.NAME, q.org_id INTO l_name, l_org_id
        FROM cn_quotas_all q
       WHERE q.quota_id = :NEW.quota_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    cn_mark_events_pkg.mark_event_rt_quota(
      p_event_name                 => 'CHANGE_QUOTA_CALC'
    , p_object_name                => l_name
    , p_object_id                  => :NEW.quota_id
    , p_start_date                 => NULL
    , p_start_date_old             => :NEW.start_date
    , p_end_date                   => NULL
    , p_end_date_old               => :NEW.end_date
    , p_org_id                     => l_org_id
    );
  ELSIF DELETING THEN
    BEGIN
      SELECT q.NAME, q.org_id INTO l_name, l_org_id
        FROM cn_quotas_all q
       WHERE q.quota_id = :OLD.quota_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    cn_mark_events_pkg.mark_event_rt_quota(
      p_event_name                 => 'CHANGE_QUOTA_CALC'
    , p_object_name                => l_name
    , p_object_id                  => :OLD.quota_id
    , p_start_date                 => NULL
    , p_start_date_old             => :OLD.start_date
    , p_end_date                   => NULL
    , p_end_date_old               => :OLD.end_date
    , p_org_id                     => l_org_id
    );
  ELSIF UPDATING THEN
    IF    TRUNC(:OLD.start_date) <> TRUNC(:NEW.start_date)
       OR TRUNC(NVL(:OLD.end_date, fnd_api.g_miss_date)) <>
                                                      TRUNC(NVL(:NEW.end_date, fnd_api.g_miss_date)) THEN
      BEGIN
        SELECT q.NAME, q.org_id INTO l_name, l_org_id
          FROM cn_quotas_all q
         WHERE q.quota_id = :OLD.quota_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      cn_mark_events_pkg.mark_event_rt_quota(
        p_event_name                 => 'CHANGE_QUOTA_RT_DATE'
      , p_object_name                => l_name
      , p_object_id                  => :OLD.quota_id
      , p_start_date                 => :NEW.start_date
      , p_start_date_old             => :OLD.start_date
      , p_end_date                   => :NEW.end_date
      , p_end_date_old               => :OLD.end_date
      , p_org_id                     => l_org_id
      );
    END IF;

    IF :OLD.rate_schedule_id <> :NEW.rate_schedule_id THEN
      cn_mark_events_pkg.mark_event_rt_quota(
        p_event_name                 => 'CHANGE_QUOTA_CALC'
      , p_object_name                => l_name
      , p_object_id                  => :OLD.quota_id
      , p_start_date                 => NULL
      , p_start_date_old             => :OLD.start_date
      , p_end_date                   => NULL
      , p_end_date_old               => :OLD.end_date
      , p_org_id                     => :OLD.org_id
      );
    END IF;
  END IF;
END cn_rt_quota_asgns_t1;
/
ALTER TRIGGER "APPS"."CN_RT_QUOTA_ASGNS_T1" ENABLE;
