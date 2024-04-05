--------------------------------------------------------
--  DDL for Trigger CN_RATE_DIM_TIERS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_RATE_DIM_TIERS_T1" 
  AFTER INSERT OR DELETE OR UPDATE
  ON "CN"."CN_RATE_DIM_TIERS_ALL"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  l_name              cn_rate_dimensions.NAME%TYPE;
  l_rate_dimension_id cn_rate_dim_tiers.rate_dim_tier_id%TYPE;
  l_event             VARCHAR2(30);
  l_org_id            cn_rate_dimensions.org_id%TYPE;
BEGIN
  IF INSERTING THEN
    l_rate_dimension_id  := :NEW.rate_dimension_id;
    l_event              := 'CHANGE_RT_TIER_INS_DEL';
  ELSIF DELETING THEN
    l_rate_dimension_id  := :OLD.rate_dimension_id;
    l_event              := 'CHANGE_RT_TIER_INS_DEL';
  ELSIF UPDATING THEN
    l_rate_dimension_id  := :OLD.rate_dimension_id;
    l_event              := 'CHANGE_RT_TIER';
  END IF;

  -- Get Dimension Name
  --
  --
  SELECT NAME, org_id INTO l_name, l_org_id
    FROM cn_rate_dimensions_all
   WHERE rate_dimension_id = l_rate_dimension_id;

  --Mark Event even if this dimension is a brand new
  --Notifying that a dimension is added to the system
  --
  cn_mark_events_pkg.mark_event_rate_table(
    p_event_name                 => l_event
  , p_object_name                => l_name
  , p_object_id                  => l_rate_dimension_id
  , p_start_date                 => NULL
  , p_start_date_old             => NULL
  , p_end_date                   => NULL
  , p_end_date_old               => NULL
  , p_org_id                     => l_org_id
  );
END cn_rate_dim_tiers_t1;
/
ALTER TRIGGER "APPS"."CN_RATE_DIM_TIERS_T1" ENABLE;
