--------------------------------------------------------
--  DDL for Trigger CN_SRP_PERIOD_QUOTAS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_SRP_PERIOD_QUOTAS_T1" 
  AFTER UPDATE OF target_amount, period_payment, performance_goal_ptd
  ON "CN"."CN_SRP_PERIOD_QUOTAS_ALL"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  l_salesrep_name VARCHAR2(240);
  l_org_id        NUMBER;
  l_start_date    DATE;
  l_end_date      DATE;
BEGIN
  IF fnd_profile.VALUE('CN_MARK_EVENTS') = 'Y' THEN
    IF    (:NEW.target_amount <> :OLD.target_amount)
       OR (:NEW.period_payment <> :OLD.period_payment)
       OR (:NEW.performance_goal_ptd <> :OLD.performance_goal_ptd) THEN
      SELECT r.name, r.org_id, p.start_date, p.end_date
        INTO l_salesrep_name, l_org_id, l_start_date, l_end_date
        FROM cn_salesreps r, cn_srp_plan_assigns_all p
       WHERE r.salesrep_id = :NEW.salesrep_id
         AND p.srp_plan_assign_id = :NEW.srp_plan_assign_id;

      cn_mark_events_pkg.mark_event_srp_period_quota(
        'CHANGE_SRP_QUOTA_CALC'
      , l_salesrep_name
      , :NEW.srp_period_quota_id
      , :NEW.salesrep_id
      , :NEW.period_id
      , :NEW.quota_id
      , NULL
      , l_start_date
      , NULL
      , l_end_date
      , l_org_id
      );
    END IF;
  END IF;
END cn_srp_quota_assigns_t1;
/
ALTER TRIGGER "APPS"."CN_SRP_PERIOD_QUOTAS_T1" ENABLE;
