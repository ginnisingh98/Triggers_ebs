--------------------------------------------------------
--  DDL for Trigger CN_SRP_QUOTA_ASSIGNS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_SRP_QUOTA_ASSIGNS_T1" 
  AFTER UPDATE OF target, payment_amount, performance_goal
  ON "CN"."CN_SRP_QUOTA_ASSIGNS_ALL"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  x_salesrep_name VARCHAR2(240);
  x_org_id        NUMBER;
  x_start_date    DATE;
  x_end_date      DATE;
BEGIN
  IF fnd_profile.VALUE('CN_MARK_EVENTS') = 'Y' THEN
    IF    (:NEW.target <> :OLD.target)
       OR (:NEW.payment_amount <> :OLD.payment_amount)
       OR (:NEW.performance_goal <> :OLD.performance_goal) THEN
      SELECT srp.NAME, srp.org_id INTO x_salesrep_name, x_org_id
        FROM cn_salesreps srp, cn_srp_plan_assigns_all PLAN
       WHERE srp.salesrep_id = PLAN.salesrep_id
         AND srp.org_id = PLAN.org_id
         AND PLAN.srp_plan_assign_id = :NEW.srp_plan_assign_id;

      SELECT start_date, end_date INTO x_start_date, x_end_date
        FROM cn_srp_plan_assigns_all
       WHERE srp_plan_assign_id = :NEW.srp_plan_assign_id;

      cn_mark_events_pkg.mark_event_srp_quotas(
        'CHANGE_SRP_QUOTA_CALC'
      , x_salesrep_name
      , :NEW.srp_quota_assign_id
      , NULL
      , NULL
      , x_start_date
      , NULL
      , x_end_date
      , x_org_id
      );
    END IF;
  END IF;
END cn_srp_quota_assigns_t1;
/
ALTER TRIGGER "APPS"."CN_SRP_QUOTA_ASSIGNS_T1" ENABLE;
