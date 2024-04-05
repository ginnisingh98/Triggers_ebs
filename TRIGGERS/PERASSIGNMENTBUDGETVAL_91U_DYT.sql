--------------------------------------------------------
--  DDL for Trigger PERASSIGNMENTBUDGETVAL_91U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERASSIGNMENTBUDGETVAL_91U_DYT" AFTER UPDATE ON "HR"."PER_ASSIGNMENT_BUDGET_VALUES_F" FOR EACH ROW DECLARE 
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
    Action: Update
    Date:   29/08/2013 22:02
    Name:   PER_ASSIGNMENT_BUDGET_VALUES_F_ARU
    Info.:  Incident Register trigger on update of PER_ASSIGNMENT_BUDGET_VALUES_F
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
    p_event_id          => 91,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_continuous_calc.per_assign_budget_values_f_aru(
    p_business_group_id            => l_business_group_id,
    p_effective_date               => :new.effective_start_date,
    p_legislation_code             => l_legislation_code,
    p_new_ASSIGNMENT_BUDGET_VALUE_ => :new.ASSIGNMENT_BUDGET_VALUE_ID,
    p_new_ASSIGNMENT_ID            => :new.ASSIGNMENT_ID,
    p_new_BUSINESS_GROUP_ID        => :new.BUSINESS_GROUP_ID,
    p_new_EFFECTIVE_END_DATE       => :new.EFFECTIVE_END_DATE,
    p_new_EFFECTIVE_START_DATE     => :new.EFFECTIVE_START_DATE,
    p_new_PROGRAM_APPLICATION_ID   => :new.PROGRAM_APPLICATION_ID,
    p_new_PROGRAM_ID               => :new.PROGRAM_ID,
    p_new_PROGRAM_UPDATE_DATE      => :new.PROGRAM_UPDATE_DATE,
    p_new_REQUEST_ID               => :new.REQUEST_ID,
    p_new_UNIT                     => :new.UNIT,
    p_new_VALUE                    => :new.VALUE,
    p_old_ASSIGNMENT_BUDGET_VALUE_ => :old.ASSIGNMENT_BUDGET_VALUE_ID,
    p_old_ASSIGNMENT_ID            => :old.ASSIGNMENT_ID,
    p_old_BUSINESS_GROUP_ID        => :old.BUSINESS_GROUP_ID,
    p_old_EFFECTIVE_END_DATE       => :old.EFFECTIVE_END_DATE,
    p_old_EFFECTIVE_START_DATE     => :old.EFFECTIVE_START_DATE,
    p_old_PROGRAM_APPLICATION_ID   => :old.PROGRAM_APPLICATION_ID,
    p_old_PROGRAM_ID               => :old.PROGRAM_ID,
    p_old_PROGRAM_UPDATE_DATE      => :old.PROGRAM_UPDATE_DATE,
    p_old_REQUEST_ID               => :old.REQUEST_ID,
    p_old_UNIT                     => :old.UNIT,
    p_old_VALUE                    => :old.VALUE
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
    hr_utility.set_location('PERASSIGNMENTBUDGETVAL_91U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERASSIGNMENTBUDGETVAL_91U_DYT" ENABLE;
