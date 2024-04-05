--------------------------------------------------------
--  DDL for Trigger CN_TRX_FACTORS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_TRX_FACTORS_T1" 
  AFTER UPDATE
  ON "CN"."CN_TRX_FACTORS_ALL"
  FOR EACH ROW
DECLARE
  l_name   cn_quotas_all.NAME%TYPE;
  l_org_id cn_quotas_all.org_id%TYPE;
BEGIN
  IF :OLD.event_factor <> :NEW.event_factor THEN
    BEGIN
      SELECT q.NAME, q.org_id INTO l_name, l_org_id
        FROM cn_quotas_all q
       WHERE q.quota_id = :OLD.quota_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;

    cn_mark_events_pkg.mark_event_trx_factor(
      p_event_name                 => 'CHANGE_QUOTA_POP'
    , p_object_name                => l_name
    , p_object_id                  => :OLD.quota_id
    , p_start_date                 => NULL
    , p_start_date_old             => NULL
    , p_end_date                   => NULL
    , p_end_date_old               => NULL
    , p_org_id                     => l_org_id
    );
  END IF;
END cn_trx_factors_t1;
/
ALTER TRIGGER "APPS"."CN_TRX_FACTORS_T1" ENABLE;
