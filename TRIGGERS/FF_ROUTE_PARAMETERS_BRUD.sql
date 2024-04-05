--------------------------------------------------------
--  DDL for Trigger FF_ROUTE_PARAMETERS_BRUD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_ROUTE_PARAMETERS_BRUD" 
/*
  FF_ROUTE_PARAMETERS Before Row Update/Delete
  Make sure changing a route parameter doesn't invalidate any compiled
  formulae
*/
before update or delete
on "HR"."FF_ROUTE_PARAMETERS"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.validate_rcu(:OLD.route_id);
end if;
end ff_route_parameters_brud;



/
ALTER TRIGGER "APPS"."FF_ROUTE_PARAMETERS_BRUD" ENABLE;
