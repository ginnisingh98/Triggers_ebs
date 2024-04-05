--------------------------------------------------------
--  DDL for Trigger PAY_TAXABILITY_RULES_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_TAXABILITY_RULES_ARU" 
   AFTER UPDATE
      ON "HR"."PAY_TAXABILITY_RULES"
      FOR EACH ROW
BEGIN
  if hr_general.g_data_migrator_mode <> 'Y' then

   hr_utility.set_location('pay_taxability_rules_aru',1);
   hr_utility.trace('calling pay_taxability_rules_aru');

   /* Check the tax_type of the deleted row - if the
      tax_type is in CSDI,EIC,FIT,FUTA,GDI,MEDICARE,NW_FIT,SS
      then the balances have to be trashed in pay_person_latest_balances
      and pay_assignmenent_latest_balances */

     if (nvl(:OLD.status,'S')  <> :NEW.status) then

     pay_us_taxability_rules_pkg.get_balance_type(:NEW.tax_type,
                                                  :NEW.tax_category,
                                                  :NEW.taxability_rules_date_id,
                                                  :NEW.legislation_code,
                                                  :NEW.classification_id);

      hr_utility.trace('after calling pay_taxability_rules_aru');
      hr_utility.set_location('pay_taxability_rules_aru',2);

     end if; /* compare value in status column */

  end if;
END pay_taxability_rules_aru;



/
ALTER TRIGGER "APPS"."PAY_TAXABILITY_RULES_ARU" ENABLE;
