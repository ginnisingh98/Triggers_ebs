--------------------------------------------------------
--  DDL for Trigger PERSPINALPOINTPLACEME_130U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERSPINALPOINTPLACEME_130U_DYT" AFTER UPDATE ON "HR"."PER_SPINAL_POINT_PLACEMENTS_F" FOR EACH ROW DECLARE 
  /* Local variable declarations */
  l_business_group_id            NUMBER;
  l_legislation_code             VARCHAR2(30);
  l_new_assignment_id            NUMBER;
  l_new_effective_end_date       DATE;
  l_new_effective_start_date     DATE;
  l_old_effective_end_date       DATE;
  l_mode  varchar2(80);

--
BEGIN
/*
  ================================================
  This is a dynamically generated database trigger
  ================================================
            ** DO NOT CHANGE MANUALLY **          
  ------------------------------------------------
    Table:  PER_SPINAL_POINT_PLACEMENTS_F
    Action: Update
    Date:   30/08/2013 11:37
    Name:   PSP_GRADE_STEP_UPDATE
    Info.:  PSP trigger to track grade step changes
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
  l_new_assignment_id := :new.assignment_id;
  --
  l_new_effective_start_date := :new.effective_start_date;
  --
  l_new_effective_end_date := :new.effective_end_date;
  --
  l_old_effective_end_date := :old.effective_end_date;
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 130,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  psp_enc_assignment_changes.asig_grade_point_update(
    p_assignment_id                => :new.assignment_id,
    p_new_effective_end_date       => :new.effective_end_date,
    p_new_effective_start_date     => :new.effective_start_date,
    p_old_effective_end_date       => :old.effective_end_date
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
    hr_utility.set_location('PERSPINALPOINTPLACEME_130U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERSPINALPOINTPLACEME_130U_DYT" ENABLE;
