--------------------------------------------------------
--  DDL for Trigger PERASSIGNMENTBUDGETVAL_90I_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERASSIGNMENTBUDGETVAL_90I_DYT" AFTER INSERT ON "HR"."PER_ASSIGNMENT_BUDGET_VALUES_F" FOR EACH ROW DECLARE 
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
    Table:  PER_ASSIGNMENT_BUDGET_VALUES_F
    Action: Insert
    Date:   29/08/2013 22:02
    Name:   PER_ASSIGNMENT_BUDGET_VALUES_F_ARI
    Info.:  Incident Register trigger on insert to PER_ASSIGNMENT_BUDGET_VALUES_F
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
    p_statement                    => 'select '||to_char(:new.business_group_id)||' from sys.dual'
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 90,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_continuous_calc.per_assign_budget_values_f_ari(
    p_ASSIGNMENT_BUDGET_VALUE_     => :new.ASSIGNMENT_BUDGET_VALUE_ID,
    p_ASSIGNMENT_ID                => :new.ASSIGNMENT_ID,
    p_BUSINESS_GROUP_ID            => :new.BUSINESS_GROUP_ID,
    p_EFFECTIVE_END_DATE           => :new.EFFECTIVE_END_DATE,
    p_EFFECTIVE_START_DATE         => :new.EFFECTIVE_START_DATE,
    p_PROGRAM_APPLICATION_ID       => :new.PROGRAM_APPLICATION_ID,
    p_PROGRAM_ID                   => :new.PROGRAM_ID,
    p_PROGRAM_UPDATE_DATE          => :new.PROGRAM_UPDATE_DATE,
    p_REQUEST_ID                   => :new.REQUEST_ID,
    p_UNIT                         => :new.UNIT,
    p_VALUE                        => :new.VALUE,
    p_legislation_code             => l_legislation_code
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
    hr_utility.set_location('PERASSIGNMENTBUDGETVAL_90I_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERASSIGNMENTBUDGETVAL_90I_DYT" ENABLE;
