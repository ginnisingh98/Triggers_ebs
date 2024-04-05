--------------------------------------------------------
--  DDL for Trigger PAY_LEGISLATION_RULES_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_LEGISLATION_RULES_INSERT" 
BEFORE insert or update of rule_type
ON "HR"."PAY_LEGISLATION_RULES"
FOR EACH ROW
DECLARE
 invalid_leg_rule EXCEPTION;
BEGIN
if hr_general.g_data_migrator_mode <> 'Y' then
if (pay_legislation_rules_pkg.check_leg_rule(:new.rule_type)=false)
then
 raise invalid_leg_rule;
end if;
end if;

END;




/
ALTER TRIGGER "APPS"."PAY_LEGISLATION_RULES_INSERT" ENABLE;
