--------------------------------------------------------
--  DDL for Trigger PERCONTACTRELATIONSH_2130I_DYT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PERCONTACTRELATIONSH_2130I_DYT" AFTER INSERT ON "HR"."PER_CONTACT_RELATIONSHIPS" FOR EACH ROW DECLARE 
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
    Table:  PER_CONTACT_RELATIONSHIPS
    Action: Insert
    Date:   30/08/2013 11:37
    Name:   PER_CONTACT_RELATIONSHIPS_ARI
    Info.:  Continuous Calcuation trigger on update of PER_CONTACT_RELATIONSHIPS
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
    p_event_id          => 2130,
    p_legislation_code  => l_legislation_code,
    p_business_group_id => l_business_group_id,
    p_payroll_id        => NULL
  ) THEN
    RETURN;
  END IF;
  --
  /* Global component calls */
  PAY_CONTINUOUS_CALC.PER_CONTACT_RELATIONSHIPS_ARI(
    p_business_group_id            => l_business_group_id,
    p_contact_relationship_id      => :new.contact_relationship_id,
    p_effective_start_date         => :new.date_start,
    p_legislation_code             => l_legislation_code,
    p_person_id                    => :new.person_id
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
    hr_utility.set_location('PERCONTACTRELATIONSH_2130I_DYT',ABS(SQLCODE));
    pay_dyn_triggers.g_dyt_mode := l_mode;
    RAISE;
  --
END;


/
ALTER TRIGGER "APPS"."PERCONTACTRELATIONSH_2130I_DYT" ENABLE;
