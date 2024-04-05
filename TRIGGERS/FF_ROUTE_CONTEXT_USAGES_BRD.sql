--------------------------------------------------------
--  DDL for Trigger FF_ROUTE_CONTEXT_USAGES_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_ROUTE_CONTEXT_USAGES_BRD" 
/*
  FF_ROUTE_CONTEXT_USAGES Before Row Delete
  Make sure deleting a context usage doesn't invalidate any compiled
  formulae
*/
before delete
on "HR"."FF_ROUTE_CONTEXT_USAGES"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.validate_rcu(:OLD.route_id);
end if;
end ff_route_context_usages_brd;



/
ALTER TRIGGER "APPS"."FF_ROUTE_CONTEXT_USAGES_BRD" ENABLE;
