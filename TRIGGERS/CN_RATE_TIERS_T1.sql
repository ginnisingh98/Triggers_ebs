--------------------------------------------------------
--  DDL for Trigger CN_RATE_TIERS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_RATE_TIERS_T1" 
  AFTER INSERT OR DELETE OR UPDATE
  ON "CN"."CN_RATE_TIERS_ALL"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  l_rate_tier_id       cn_rate_tiers_all.rate_tier_id%TYPE;
  l_rate_schedule_id   cn_rate_tiers_all.rate_schedule_id%TYPE;
  l_event              VARCHAR2(30);
  l_name              cn_rate_schedules_all.NAME%TYPE;
  l_org_id            cn_rate_dimensions.org_id%TYPE;
BEGIN
  IF INSERTING THEN
    l_rate_tier_id     := :NEW.rate_tier_id;
    l_rate_schedule_id := :NEW.rate_schedule_id;
    l_event            := 'CHANGE_RT_TIER_INS_DEL';
  ELSIF DELETING THEN
    l_rate_tier_id     := :OLD.rate_tier_id;
    l_rate_schedule_id := :OLD.rate_schedule_id;
    l_event            := 'CHANGE_RT_TIER_INS_DEL';
  ELSIF UPDATING THEN
    l_rate_tier_id     := :OLD.rate_tier_id;
    l_rate_schedule_id := :OLD.rate_schedule_id;
    l_event            := 'CHANGE_RT_TIER';
  END IF;

  --
  -- Since there is no name associated with Rate Tiers, lets
  -- stamp the Schedule Name atleast.
  --
  SELECT name, org_id INTO l_name, l_org_id
    FROM cn_rate_schedules_all
   WHERE rate_schedule_id = l_rate_schedule_id;

  --
  -- Mark Event even if this dimension is a brand new
  -- Notifying that a Tier is added / changed in the system
  --
  cn_mark_events_pkg.mark_event_rate_tier_table(
    p_event_name                 => l_event
  , p_object_name                => l_name
  , p_object_id                  => l_rate_tier_id
  , p_dep_object_id              => l_rate_schedule_id
  , p_start_date                 => NULL
  , p_start_date_old             => NULL
  , p_end_date                   => NULL
  , p_end_date_old               => NULL
  , p_org_id                     => l_org_id
  );
END cn_rate_tiers_t1;
/
ALTER TRIGGER "APPS"."CN_RATE_TIERS_T1" ENABLE;
