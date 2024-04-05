--------------------------------------------------------
--  DDL for Trigger PAYPERSONALPAYMENTMETH_49U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAYPERSONALPAYMENTMETH_49U_DYT" AFTER UPDATE ON "HR"."PAY_PERSONAL_PAYMENT_METHODS_F" FOR EACH ROW DECLARE 
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
    Table:  PAY_PERSONAL_PAYMENT_METHODS_F
    Action: Update
    Date:   29/08/2013 22:02
    Name:   PAY_PERSONAL_PAYMENT_METHODS_F_ARU
    Info.:  Continuous Calculation trigger on update of personal payment method
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
    p_statement                    => 'select paf.business_group_id from per_assignments_f paf where assignment_id = '||:old.assignment_id||' and to_date('''||to_char(:old.effective_start_date, 'DD-MON-YYYY')||''',''DD-MON-YYYY'') between paf.effective_start_date and paf.effective_end_date'
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 49,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
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
    hr_utility.set_location('PAYPERSONALPAYMENTMETH_49U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PAYPERSONALPAYMENTMETH_49U_DYT" ENABLE;
