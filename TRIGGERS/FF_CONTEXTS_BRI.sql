--------------------------------------------------------
--  DDL for Trigger FF_CONTEXTS_BRI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_CONTEXTS_BRI" 
/*
  FF_CONTEXTS Before Row Insert
  Validates context name. Assigns a dummy value (1) for the context
  level.
*/
before insert
on "HR"."FF_CONTEXTS"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
   ff_load_contexts_pkg.validate_name
   (p_context_name => :NEW.context_name
   ,p_data_type    => :NEW.data_type
   );
   :NEW.context_level := 1;
end if;
end ff_contexts_bri;

/
ALTER TRIGGER "APPS"."FF_CONTEXTS_BRI" ENABLE;
