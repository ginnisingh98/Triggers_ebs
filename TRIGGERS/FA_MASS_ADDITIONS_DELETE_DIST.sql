--------------------------------------------------------
--  DDL for Trigger FA_MASS_ADDITIONS_DELETE_DIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_MASS_ADDITIONS_DELETE_DIST" 
before delete
on "FA"."FA_MASS_ADDITIONS" for each row
begin
  delete from fa_massadd_distributions
  where mass_addition_id = :old.mass_addition_id;
end fa_mass_Additions_delete_dist;

/
ALTER TRIGGER "APPS"."FA_MASS_ADDITIONS_DELETE_DIST" ENABLE;
