--------------------------------------------------------
--  DDL for Trigger PERASSIGNMENTEXTRAINF_134D_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERASSIGNMENTEXTRAINF_134D_DYT" AFTER DELETE ON "HR"."PER_ASSIGNMENT_EXTRA_INFO" FOR EACH ROW DECLARE 
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
    Table:  PER_ASSIGNMENT_EXTRA_INFO
    Action: Delete
    Date:   04/01/2007 09:49
    Name:   PER_ASSIGNMENT_EXTRA_INFO_ARD
    Info.:  Continuous Calculation deletion trigger for PER_ASSIGNMENT_EXTRA_INFO
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
    p_statement                    => 'select distinct business_group_id from per_all_assignments_f where assignment_id = '||:old.assignment_id
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 134,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  pay_misc_dyt_incident_pkg.per_assignment_extra_info_ard(
    p_assignment_extra_info_id     => :old.ASSIGNMENT_EXTRA_INFO_ID,
    p_assignment_id                => :old.ASSIGNMENT_ID,
    p_business_group_id            => l_business_group_id,
    p_effective_start_date         => to_date('0001/01/01', 'YYYY/MM/DD'),
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
    hr_utility.set_location('PERASSIGNMENTEXTRAINF_134D_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;



/
ALTER TRIGGER "APPS"."PERASSIGNMENTEXTRAINF_134D_DYT" ENABLE;
