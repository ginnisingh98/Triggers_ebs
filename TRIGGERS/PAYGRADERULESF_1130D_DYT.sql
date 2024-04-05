--------------------------------------------------------
--  DDL for Trigger PAYGRADERULESF_1130D_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAYGRADERULESF_1130D_DYT" AFTER DELETE ON "HR"."PAY_GRADE_RULES_F" FOR EACH ROW DECLARE 
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
    Table:  PAY_GRADE_RULES_F
    Action: Delete
    Date:   29/08/2013 22:02
    Name:   PAY_GRADE_RULES_F_ARD
    Info.:  Continuous Calculation trigger on delete of Grade Rules
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
    p_event_id          => 1130,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  PAY_CONTINUOUS_CALC.PAY_GRADE_RULES_F_ard(
    p_business_group_id            => l_business_group_id,
    p_legislation_code             => l_legislation_code,
    p_new_effective_end_date       => :new.effective_end_date,
    p_new_effective_start_date     => :new.effective_start_date,
    p_old_effective_end_date       => :old.effective_end_date,
    p_old_effective_start_date     => :old.effective_start_date,
    p_old_grade_rule_id            => :old.grade_rule_id
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
    hr_utility.set_location('PAYGRADERULESF_1130D_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PAYGRADERULESF_1130D_DYT" ENABLE;
