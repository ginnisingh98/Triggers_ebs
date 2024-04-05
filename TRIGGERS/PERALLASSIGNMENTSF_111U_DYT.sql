--------------------------------------------------------
--  DDL for Trigger PERALLASSIGNMENTSF_111U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERALLASSIGNMENTSF_111U_DYT" AFTER UPDATE ON "HR"."PER_ALL_ASSIGNMENTS_F" FOR EACH ROW DECLARE 
  /* Local variable declarations */
  l_business_group_id            NUMBER;
  l_legislation_code             VARCHAR2(30);
  l_new_asg_status_type_id       NUMBER;
  l_new_assignment_id            NUMBER;
  l_new_effective_end_date       DATE;
  l_new_organization_id          NUMBER;
  l_new_payroll_id               NUMBER;
  l_new_period_of_service_id     NUMBER;
  l_old_asg_status_type_id       NUMBER;
  l_old_organization_id          NUMBER;
  l_old_payroll_id               NUMBER;
  l_primary_flag                 VARCHAR2(30);
  l_new_grade_id                 NUMBER;
  l_old_grade_id                 NUMBER;
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
    Action: Update
    Date:   29/08/2013 22:01
    Name:   PSP_ASG_CHANGES_ARU
    Info.:  Assignment updates that affect LD encumbrances
  ================================================
*/
--
  l_mode := pay_dyn_triggers.g_dyt_mode;
  pay_dyn_triggers.g_dyt_mode := pay_dyn_triggers.g_dbms_dyt;
IF NOT (hr_general.g_data_migrator_mode <> 'Y') THEN
  RETURN;
END IF;
  /* Initialising local variables */
  l_business_group_id := :new.business_group_id;
  --
  SELECT legislation_code
  INTO   l_legislation_code
  FROM per_business_groups WHERE business_group_id = l_business_group_id; 
  --
  l_old_payroll_id := :old.payroll_id;
  --
  l_new_payroll_id := :new.payroll_id;
  --
  l_old_organization_id := :old.organization_id;
  --
  l_new_organization_id := :new.organization_id;
  --
  l_old_asg_status_type_id := :old.assignment_status_type_id;
  --
  l_new_asg_status_type_id := :new.assignment_status_type_id;
  --
  l_new_assignment_id := :new.assignment_id;
  --
  l_new_period_of_service_id := :new.period_of_service_id;
  --
  l_new_effective_end_date := :new.effective_end_date;
  --
  l_primary_flag := :new.primary_flag;
  --
  l_old_grade_id := :old.grade_id;
  --
  l_new_grade_id := :new.grade_id;
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 111,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  PSP_ENC_ASSIGNMENT_CHANGES.ASSIGNMENT_UPDATES(
    p_new_asg_status_type_id       => :new.assignment_status_type_id,
    p_new_assignment_id            => :new.assignment_id,
    p_new_effective_end_date       => :new.effective_end_date,
    p_new_grade_id                 => :new.grade_id,
    p_new_organization_id          => :new.organization_id,
    p_new_payroll_id               => :new.payroll_id,
    p_new_period_of_service_id     => :new.period_of_service_id,
    p_new_person_id                => :new.person_id,
    p_new_primary_flag             => :new.primary_flag,
    p_old_asg_status_type_id       => :old.assignment_status_type_id,
    p_old_grade_id                 => :old.grade_id,
    p_old_organization_id          => :old.organization_id,
    p_old_payroll_id               => :old.payroll_id
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
    hr_utility.set_location('PERALLASSIGNMENTSF_111U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERALLASSIGNMENTSF_111U_DYT" ENABLE;
