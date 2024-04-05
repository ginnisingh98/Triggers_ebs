--------------------------------------------------------
--  DDL for Trigger PERPAYPROPOSALS_118D_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERPAYPROPOSALS_118D_DYT" AFTER DELETE ON "HR"."PER_PAY_PROPOSALS" FOR EACH ROW DECLARE 
  /* Local variable declarations */
  l_business_group_id            NUMBER;
  l_legislation_code             VARCHAR2(10);
  l_mode  varchar2(80);

--
BEGIN
/*
  ================================================
  This is a dynamically generated database trigger
  ================================================
            ** DO NOT CHANGE MANUALLY **          
  ------------------------------------------------
    Table:  PER_PAY_PROPOSALS
    Action: Delete
    Date:   29/08/2013 22:02
    Name:   PER_PAY_PROPOSALS_ARD
    Info.:  Incident Register trigger on deletion of pay proposals
  ================================================
*/
--
  l_mode := pay_dyn_triggers.g_dyt_mode;
  pay_dyn_triggers.g_dyt_mode := pay_dyn_triggers.g_dbms_dyt;
IF NOT (hr_general.g_data_migrator_mode <> 'Y') THEN
  RETURN;
END IF;
  /* Initialising local variables */
  l_business_group_id := pay_core_utils.get_business_group(
    p_statement                    => 'select '||:old.business_group_id||' from sys.dual'
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 118,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_continuous_calc.per_pay_proposals_ard(
    p_assignment_id                => :old.assignment_id,
    p_business_group_id            => l_business_group_id,
    p_effective_start_date         => :old.change_date,
    p_legislation_code             => l_legislation_code,
    p_pay_proposal_id              => :old.pay_proposal_id
  );
  --
  /* Legislation specific component calls */
  --
  /* Business group specific component calls */
  --
  /* Payroll specific component calls */
  --
  pay_dyn_triggers.g_dyt_mode := l_mode;
EXCEPTION
  WHEN OTHERS THEN
    hr_utility.set_location('PERPAYPROPOSALS_118D_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERPAYPROPOSALS_118D_DYT" ENABLE;
