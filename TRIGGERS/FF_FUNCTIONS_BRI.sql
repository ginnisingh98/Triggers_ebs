--------------------------------------------------------
--  DDL for Trigger FF_FUNCTIONS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FUNCTIONS_BRI" 
/*
  FF_FUNCTIONS Before Row Insert
  Checks that name is valid.
  Checks that alias is not the same as the function_name
*/
before insert
on "HR"."FF_FUNCTIONS"
for each row

declare
  new_name ff_functions.name%TYPE;
  new_alias ff_functions.alias_name%TYPE;
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  -- bug 153833 workaround. Remove in 7.0.14
  new_name := :NEW.name;
  new_alias := :NEW.alias_name;
  -- Check that function name is not duplicated for class = 'U' (User defined)
  ffdict.validate_function(new_name,
                            :NEW.class,
                            new_alias,
                            :NEW.BUSINESS_GROUP_ID,
                            :NEW.LEGISLATION_CODE);
end if;
end ff_functions_bri;



/
ALTER TRIGGER "APPS"."FF_FUNCTIONS_BRI" ENABLE;
