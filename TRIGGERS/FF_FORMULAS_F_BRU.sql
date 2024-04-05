--------------------------------------------------------
--  DDL for Trigger FF_FORMULAS_F_BRU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FF_FORMULAS_F_BRU" 
before update on "HR"."FF_FORMULAS_F" for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
  :new.last_update_date := sysdate;
end if;
end ff_formulas_f_bru;


/
ALTER TRIGGER "APPS"."FF_FORMULAS_F_BRU" ENABLE;
