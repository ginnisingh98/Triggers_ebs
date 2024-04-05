--------------------------------------------------------
--  DDL for Trigger FF_RPV_BRUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_RPV_BRUD" 
/*
  FF_ROUTE_PARAMETER_VALUES Before Row Update/Insert
  Make sure changing route parameter values doesn't invalidate any compiled
  formulae
*/
before update or delete
on "HR"."FF_ROUTE_PARAMETER_VALUES"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.validate_rpv(:OLD.user_entity_id);
end if;
end ff_rpv_brui;



/
ALTER TRIGGER "APPS"."FF_RPV_BRUD" ENABLE;
