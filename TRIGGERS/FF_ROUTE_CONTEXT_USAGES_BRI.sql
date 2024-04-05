--------------------------------------------------------
--  DDL for Trigger FF_ROUTE_CONTEXT_USAGES_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_ROUTE_CONTEXT_USAGES_BRI" 
/*
  FF_ROUTE_CONTEXT_USAGES Before Row Insert
  Make sure adding a new context usages doesn't invalidate any compiled
  formulae
*/
before insert
on "HR"."FF_ROUTE_CONTEXT_USAGES"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.validate_rcu (:NEW.route_id);
end if;
end ff_route_context_usages_bri;



/
ALTER TRIGGER "APPS"."FF_ROUTE_CONTEXT_USAGES_BRI" ENABLE;
