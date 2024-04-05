--------------------------------------------------------
--  DDL for Trigger CN_QUOTA_RULE_UPLIFTS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_QUOTA_RULE_UPLIFTS_T1" 
  AFTER DELETE OR INSERT OR UPDATE
  ON "CN"."CN_QUOTA_RULE_UPLIFTS_ALL"
  FOR EACH ROW
DECLARE
  l_name     cn_quotas_all.NAME%TYPE;
  l_quota_id cn_quotas_all.quota_id%TYPE;
  l_org_id   cn_quotas_all.org_id%TYPE;
BEGIN
  IF INSERTING THEN
    BEGIN
      SELECT q.NAME, q.quota_id, q.org_id INTO l_name, l_quota_id, l_org_id
        FROM cn_quotas_all q, cn_quota_rules_all qr
       WHERE q.quota_id = qr.quota_id AND qr.quota_rule_id = :NEW.quota_rule_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    -- modified by rjin 11/10/1999, should pass start_date/end_date
    cn_mark_events_pkg.mark_event_quota(
      p_event_name                 => 'CHANGE_QUOTA_POP'
    , p_object_name                => l_name
    , p_object_id                  => l_quota_id
    , p_start_date                 => NULL
    , p_start_date_old             => :NEW.start_date
    , p_end_date                   => NULL
    , p_end_date_old               => :NEW.end_date
    , p_org_id                     => l_org_id
    );
  ELSIF DELETING THEN
    BEGIN
      SELECT q.NAME, q.quota_id, q.org_id INTO l_name, l_quota_id, l_org_id
        FROM cn_quotas_all q, cn_quota_rules_all qr
       WHERE q.quota_id = qr.quota_id AND qr.quota_rule_id = :OLD.quota_rule_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    cn_mark_events_pkg.mark_event_quota(
      p_event_name                 => 'CHANGE_QUOTA_POP'
    , p_object_name                => l_name
    , p_object_id                  => l_quota_id
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
        SELECT q.NAME, q.quota_id, q.org_id INTO l_name, l_quota_id, l_org_id
          FROM cn_quotas_all q, cn_quota_rules_all qr
         WHERE q.quota_id = qr.quota_id AND qr.quota_rule_id = :OLD.quota_rule_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      cn_mark_events_pkg.mark_event_quota(
        p_event_name                 => 'CHANGE_QUOTA_UPLIFT_DATE'
      , p_object_name                => l_name
      , p_object_id                  => l_quota_id
      , p_start_date                 => :NEW.start_date
      , p_start_date_old             => :OLD.start_date
      , p_end_date                   => :NEW.end_date
      , p_end_date_old               => :OLD.end_date
      , p_org_id                     => l_org_id
      );
    END IF;
  END IF;
END cn_quota_rule_uplifts_t1;
/
ALTER TRIGGER "APPS"."CN_QUOTA_RULE_UPLIFTS_T1" ENABLE;
