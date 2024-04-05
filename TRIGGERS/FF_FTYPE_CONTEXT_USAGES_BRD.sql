--------------------------------------------------------
--  DDL for Trigger FF_FTYPE_CONTEXT_USAGES_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FTYPE_CONTEXT_USAGES_BRD" 
/*
  FF_FTYPE_CONTEXT_USAGES Before Row Delete
  Make sure deleting a context usage doesn't invalidate any compiled
  formulae
*/
before delete
on "HR"."FF_FTYPE_CONTEXT_USAGES"
for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  ffdict.delete_ftcu_check(:OLD.FORMULA_TYPE_ID, :OLD.CONTEXT_ID);
end if;
end ff_ftype_context_usages_brd;



/
ALTER TRIGGER "APPS"."FF_FTYPE_CONTEXT_USAGES_BRD" ENABLE;
