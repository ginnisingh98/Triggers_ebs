--------------------------------------------------------
--  DDL for Trigger PERPAYPROPOSALS_116U_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERPAYPROPOSALS_116U_DYT" AFTER UPDATE ON "HR"."PER_PAY_PROPOSALS" FOR EACH ROW DECLARE 
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
    Action: Update
    Date:   29/08/2013 22:02
    Name:   PER_PAY_PROPOSALS_ARU
    Info.:  Incident Register trigger on update of PER_PAY_PROPOSALS
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
    p_statement                    => 'select '||:new.business_group_id||' from sys.dual'
  ); 
  --
  l_legislation_code := pay_core_utils.get_legislation_code(
    p_bg_id                        => l_business_group_id
  ); 
  --
  /* Is the trigger in an enabled functional area */
  IF paywsfgt_pkg.trigger_is_not_enabled(
    p_event_id          => 116,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  PAY_CONTINUOUS_CALC.PER_PAY_PROPOSALS_aru(
    p_business_group_id            => l_business_group_id,
    p_effective_date               => :new.change_date,
    p_legislation_code             => l_legislation_code,
    p_new_APPROVED                 => :new.APPROVED,
    p_new_ASSIGNMENT_ID            => :new.ASSIGNMENT_ID,
    p_new_ATTRIBUTE1               => :new.ATTRIBUTE1,
    p_new_ATTRIBUTE10              => :new.ATTRIBUTE10,
    p_new_ATTRIBUTE11              => :new.ATTRIBUTE11,
    p_new_ATTRIBUTE12              => :new.ATTRIBUTE12,
    p_new_ATTRIBUTE13              => :new.ATTRIBUTE13,
    p_new_ATTRIBUTE14              => :new.ATTRIBUTE14,
    p_new_ATTRIBUTE15              => :new.ATTRIBUTE15,
    p_new_ATTRIBUTE16              => :new.ATTRIBUTE16,
    p_new_ATTRIBUTE17              => :new.ATTRIBUTE17,
    p_new_ATTRIBUTE18              => :new.ATTRIBUTE18,
    p_new_ATTRIBUTE19              => :new.ATTRIBUTE19,
    p_new_ATTRIBUTE2               => :new.ATTRIBUTE2,
    p_new_ATTRIBUTE20              => :new.ATTRIBUTE20,
    p_new_ATTRIBUTE3               => :new.ATTRIBUTE3,
    p_new_ATTRIBUTE4               => :new.ATTRIBUTE4,
    p_new_ATTRIBUTE5               => :new.ATTRIBUTE5,
    p_new_ATTRIBUTE6               => :new.ATTRIBUTE6,
    p_new_ATTRIBUTE7               => :new.ATTRIBUTE7,
    p_new_ATTRIBUTE8               => :new.ATTRIBUTE8,
    p_new_ATTRIBUTE9               => :new.ATTRIBUTE9,
    p_new_ATTRIBUTE_CATEGORY       => :new.ATTRIBUTE_CATEGORY,
    p_new_BUSINESS_GROUP_ID        => :new.BUSINESS_GROUP_ID,
    p_new_CHANGE_DATE              => :new.CHANGE_DATE,
    p_new_EVENT_ID                 => :new.EVENT_ID,
    p_new_FORCED_RANKING           => :new.FORCED_RANKING,
    p_new_LAST_CHANGE_DATE         => :new.LAST_CHANGE_DATE,
    p_new_MULTIPLE_COMPONENTS      => :new.MULTIPLE_COMPONENTS,
    p_new_NEXT_PERF_REVIEW_DATE    => :new.NEXT_PERF_REVIEW_DATE,
    p_new_NEXT_SAL_REVIEW_DATE     => :new.NEXT_SAL_REVIEW_DATE,
    p_new_PAY_PROPOSAL_ID          => :new.PAY_PROPOSAL_ID,
    p_new_PERFORMANCE_RATING       => :new.PERFORMANCE_RATING,
    p_new_PERFORMANCE_REVIEW_ID    => :new.PERFORMANCE_REVIEW_ID,
    p_new_PROPOSAL_REASON          => :new.PROPOSAL_REASON,
    p_new_PROPOSED_SALARY          => :new.PROPOSED_SALARY,
    p_new_PROPOSED_SALARY_N        => :new.PROPOSED_SALARY_N,
    p_new_REVIEW_DATE              => :new.REVIEW_DATE,
    p_old_APPROVED                 => :old.APPROVED,
    p_old_ASSIGNMENT_ID            => :old.ASSIGNMENT_ID,
    p_old_ATTRIBUTE1               => :old.ATTRIBUTE1,
    p_old_ATTRIBUTE10              => :old.ATTRIBUTE10,
    p_old_ATTRIBUTE11              => :old.ATTRIBUTE11,
    p_old_ATTRIBUTE12              => :old.ATTRIBUTE12,
    p_old_ATTRIBUTE13              => :old.ATTRIBUTE13,
    p_old_ATTRIBUTE14              => :old.ATTRIBUTE14,
    p_old_ATTRIBUTE15              => :old.ATTRIBUTE15,
    p_old_ATTRIBUTE16              => :old.ATTRIBUTE16,
    p_old_ATTRIBUTE17              => :old.ATTRIBUTE17,
    p_old_ATTRIBUTE18              => :old.ATTRIBUTE18,
    p_old_ATTRIBUTE19              => :old.ATTRIBUTE19,
    p_old_ATTRIBUTE2               => :old.ATTRIBUTE2,
    p_old_ATTRIBUTE20              => :old.ATTRIBUTE20,
    p_old_ATTRIBUTE3               => :old.ATTRIBUTE3,
    p_old_ATTRIBUTE4               => :old.ATTRIBUTE4,
    p_old_ATTRIBUTE5               => :old.ATTRIBUTE5,
    p_old_ATTRIBUTE6               => :old.ATTRIBUTE6,
    p_old_ATTRIBUTE7               => :old.ATTRIBUTE7,
    p_old_ATTRIBUTE8               => :old.ATTRIBUTE8,
    p_old_ATTRIBUTE9               => :old.ATTRIBUTE9,
    p_old_ATTRIBUTE_CATEGORY       => :old.ATTRIBUTE_CATEGORY,
    p_old_BUSINESS_GROUP_ID        => :old.BUSINESS_GROUP_ID,
    p_old_CHANGE_DATE              => :old.CHANGE_DATE,
    p_old_EVENT_ID                 => :old.EVENT_ID,
    p_old_FORCED_RANKING           => :old.FORCED_RANKING,
    p_old_LAST_CHANGE_DATE         => :old.LAST_CHANGE_DATE,
    p_old_MULTIPLE_COMPONENTS      => :old.MULTIPLE_COMPONENTS,
    p_old_NEXT_PERF_REVIEW_DATE    => :old.NEXT_PERF_REVIEW_DATE,
    p_old_NEXT_SAL_REVIEW_DATE     => :old.NEXT_SAL_REVIEW_DATE,
    p_old_PAY_PROPOSAL_ID          => :old.PAY_PROPOSAL_ID,
    p_old_PERFORMANCE_RATING       => :old.PERFORMANCE_RATING,
    p_old_PERFORMANCE_REVIEW_ID    => :old.PERFORMANCE_REVIEW_ID,
    p_old_PROPOSAL_REASON          => :old.PROPOSAL_REASON,
    p_old_PROPOSED_SALARY          => :old.PROPOSED_SALARY,
    p_old_PROPOSED_SALARY_N        => :old.PROPOSED_SALARY_N,
    p_old_REVIEW_DATE              => :old.REVIEW_DATE
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
    hr_utility.set_location('PERPAYPROPOSALS_116U_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERPAYPROPOSALS_116U_DYT" ENABLE;
