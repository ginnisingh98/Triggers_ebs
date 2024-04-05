--------------------------------------------------------
--  DDL for Trigger FF_CONTEXTS_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_CONTEXTS_BRD" 
/*
  FF_CONTEXTS Before Row Delete
  Checks whether it is legal to delete the context by checking whether
  it is used by any existing formulae. Other relationships are enforced
  by DB constraints
*/
before delete
on "HR"."FF_CONTEXTS"
for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
  -- if context used in a formula, fail
  -- Pass null bus grp and leg code so all formulae are considered
  if (ffdict.is_used_in_formula(:OLD.context_name, null,null)) then
    hr_utility.set_message(802,'FF75_ITEM_USED_IN_FORMULA');
    hr_utility.set_message_token('1',:OLD.context_name);
    hr_utility.raise_error;
  end if;
  -- All other context usages picked up by referential constraints
end if;
end ff_contexts_brd;

/
ALTER TRIGGER "APPS"."FF_CONTEXTS_BRD" ENABLE;
