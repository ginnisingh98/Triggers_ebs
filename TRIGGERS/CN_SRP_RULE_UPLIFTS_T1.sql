--------------------------------------------------------
--  DDL for Trigger CN_SRP_RULE_UPLIFTS_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."CN_SRP_RULE_UPLIFTS_T1" 
  AFTER UPDATE OF payment_factor, quota_factor
  ON "CN"."CN_SRP_RULE_UPLIFTS_ALL"
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  x_salesrep_name VARCHAR2(240);
  x_org_id        NUMBER;
  x_start_date    DATE;
  x_end_date      DATE;
BEGIN
  IF fnd_profile.VALUE('CN_MARK_EVENTS') = 'Y' THEN
    IF (:NEW.payment_factor <> :OLD.payment_factor) OR(:NEW.quota_factor <> :OLD.quota_factor) THEN
      SELECT srp.NAME, srp.org_id INTO x_salesrep_name, x_org_id
        FROM cn_salesreps srp, cn_srp_plan_assigns_all PLAN, cn_srp_quota_rules_all rule
       WHERE rule.srp_quota_rule_id = :NEW.srp_quota_rule_id
         AND PLAN.srp_plan_assign_id = rule.srp_plan_assign_id
         AND srp.salesrep_id = PLAN.salesrep_id
         AND srp.org_id = PLAN.org_id;

      SELECT start_date, end_date INTO x_start_date, x_end_date
        FROM cn_quota_rule_uplifts_all
       WHERE quota_rule_uplift_id = :OLD.quota_rule_uplift_id;

      cn_mark_events_pkg.mark_event_srp_uplifts(
        'CHANGE_SRP_QUOTA_POP'
      , x_salesrep_name
      , :NEW.srp_quota_rule_id
      , :NEW.quota_rule_uplift_id
      , NULL
      , x_start_date
      , NULL
      , x_end_date
      , x_org_id
      );
    END IF;
  END IF;
END cn_srp_rule_uplifts_t1;
/
ALTER TRIGGER "APPS"."CN_SRP_RULE_UPLIFTS_T1" ENABLE;
