--------------------------------------------------------
--  DDL for Trigger FF_RPV_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_RPV_BRI" 
/*
  FF_ROUTE_PARAMETER_VALUES Before Row Insert
  Make sure changing route parameter values doesn't invalidate any compiled
  formulae
*/
before insert
on "HR"."FF_ROUTE_PARAMETER_VALUES"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.validate_rpv(:NEW.user_entity_id);
end if;
end ff_rpv_bri;



/
ALTER TRIGGER "APPS"."FF_RPV_BRI" ENABLE;
