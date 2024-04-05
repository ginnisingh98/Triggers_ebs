--------------------------------------------------------
--  DDL for Trigger FF_ROUTE_PARAMETERS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_ROUTE_PARAMETERS_BRI" 
/*
  FF_ROUTE_PARAMETERS Before Row Insert/Delete
  Make changing route parameters doesn't invalidate any compiled
  formulae
*/
before insert
on "HR"."FF_ROUTE_PARAMETERS"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.validate_rcu (:NEW.route_id);
end if;
end ff_route_parameters_bri;



/
ALTER TRIGGER "APPS"."FF_ROUTE_PARAMETERS_BRI" ENABLE;
