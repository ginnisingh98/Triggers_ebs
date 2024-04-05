--------------------------------------------------------
--  DDL for Trigger FF_FTYPE_CONTEXT_USAGES_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FTYPE_CONTEXT_USAGES_BRU" 
/*
  FF_FTYPE_CONTEXT_USAGES Before Row Update
  Make sure updating a context usage doesn't invalidate any compiled
  formulae
*/
before update
on "HR"."FF_FTYPE_CONTEXT_USAGES"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  if (:NEW.FORMULA_TYPE_ID <> :OLD.FORMULA_TYPE_ID) then
    hr_utility.set_message(802,'Cannot update FORMULA_TYPE_ID');
    hr_utility.raise_error;
  end if;
  -- Check whether it is OK to remove the old context usage
  ffdict.delete_ftcu_check(:OLD.FORMULA_TYPE_ID, :OLD.CONTEXT_ID);
  -- It is always OK to add a context, so the NEW value should be OK
end if;
end ff_ftype_context_usages_bru;



/
ALTER TRIGGER "APPS"."FF_FTYPE_CONTEXT_USAGES_BRU" ENABLE;
