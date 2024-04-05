--------------------------------------------------------
--  DDL for Trigger PERALLASSIGNMENTSF_110D_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERALLASSIGNMENTSF_110D_DYT" AFTER DELETE ON "HR"."PER_ALL_ASSIGNMENTS_F" FOR EACH ROW DECLARE 
  /* Local variable declarations */
  l_business_group_id            NUMBER;
  l_legislation_code             VARCHAR2(30);
  l_new_assignment_id            NUMBER;
  l_old_assignment_id            NUMBER;
  l_old_payroll_id               NUMBER;
  l_old_effective_start_date     DATE;
  l_old_person_id                NUMBER;
  l_mode  varchar2(80);

--
BEGIN
/*
  ================================================
  This is a dynamically generated database trigger
  ================================================
            ** DO NOT CHANGE MANUALLY **          
  ------------------------------------------------
    Table:  PER_ALL_ASSIGNMENTS_F
    Action: Delete
    Date:   29/08/2013 22:01
    Name:   PSP_ASG_CHANGES_ARD
    Info.:  Assignments deletion that effects LD Encumbrances
  ================================================
*/
--
  l_mode := pay_dyn_triggers.g_dyt_mode;
  pay_dyn_triggers.g_dyt_mode := pay_dyn_triggers.g_dbms_dyt;
IF NOT (hr_general.g_data_migrator_mode <> 'Y') THEN
  RETURN;
END IF;
  /* Initialising local variables */
  l_business_group_id := :old.business_group_id;
  --
  SELECT legislation_code
  INTO   l_legislation_code
  FROM per_business_groups WHERE business_group_id = l_business_group_id; 
  --
  l_new_assignment_id := :new.assignment_id;
  --
  l_old_assignment_id := :old.assignment_id;
  --
  l_old_payroll_id := :old.payroll_id;
  --
  l_old_effective_start_date := :old.effective_start_date;
  --
  l_old_person_id := :old.person_id;
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 110,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  PSP_ENC_ASSIGNMENT_CHANGES.ASSIGNMENT_DELETES(
    p_new_assignment_id            => :new.assignment_id,
    p_old_assignment_id            => :old.assignment_id,
    p_old_effective_start_date     => :old.effective_start_date,
    p_old_payroll_id               => :old.payroll_id,
    p_old_person_id                => :old.person_id
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
    hr_utility.set_location('PERALLASSIGNMENTSF_110D_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERALLASSIGNMENTSF_110D_DYT" ENABLE;
