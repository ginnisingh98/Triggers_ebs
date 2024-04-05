--------------------------------------------------------
--  DDL for Trigger PAY_ZA_TEMP_BRANCH_DETAILS_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ZA_TEMP_BRANCH_DETAILS_ARD" 
after delete on           "HR"."PAY_ZA_TEMP_BRANCH_DETAILS"
begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      delete from pay_za_cdv_parameters;
      delete from pay_za_branch_cdv_details;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_ZA_TEMP_BRANCH_DETAILS_ARD" ENABLE;
