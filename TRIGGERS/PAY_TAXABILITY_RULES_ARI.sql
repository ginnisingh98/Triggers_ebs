--------------------------------------------------------
--  DDL for Trigger PAY_TAXABILITY_RULES_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_TAXABILITY_RULES_ARI" 
   AFTER INSERT
      ON "HR"."PAY_TAXABILITY_RULES"
     FOR EACH ROW
BEGIN
  if hr_general.g_data_migrator_mode <> 'Y' then

   hr_utility.set_location('pay_taxability_rules_ari',1);

   /* Check the tax_type of the inserted row - if the
      tax_type is in CSDI,EIC,FIT,FUTA,GDI,MEDICARE,NW_FIT,SS
      then the balances have to be trashed in pay_person_latest_balances
      and pay_assignmenent_latest_balances */



     pay_us_taxability_rules_pkg.get_balance_type(:NEW.tax_type,
                                                  :NEW.tax_category,
                                                  :NEW.taxability_rules_date_id,
                                                  :NEW.legislation_code,
                                                  :NEW.classification_id);

   hr_utility.set_location('pay_taxability_rules_ari',2);

  end if;
END pay_taxability_rules_ari;



/
ALTER TRIGGER "APPS"."PAY_TAXABILITY_RULES_ARI" ENABLE;
