--------------------------------------------------------
--  DDL for Trigger FA_MASS_ADDITIONS_INSERT_DIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_MASS_ADDITIONS_INSERT_DIST" 
before insert
on "FA"."FA_MASS_ADDITIONS" for each row
declare
  h_massadd_dist_id  number;
begin
  if (nvl(:new.split_code,'')='SC') or (:new.dist_name is not null)
	or (:new.mass_addition_id is null)
       -- commented out for bugfix 1702783
       -- or (:new.transaction_type_code in ('FUTURE ADD','FUTURE ADJ','FUTURE CAP'))
  then
     null;
  else
  insert into fa_massadd_distributions (
	massadd_dist_id, mass_addition_id,
	units, deprn_expense_ccid, location_id, employee_id)
  values (
        fa_massadd_distributions_s.nextval,
 	:new.mass_addition_id,
	:new.fixed_assets_units, :new.expense_code_combination_id,
	:new.location_id, :new.assigned_to);

	/* NULL these three values in fa_mass_additions */
	:new.expense_code_combination_id := NULL;
	:new.location_id := NULL;
	:new.assigned_to := NULL;
 end if;
end fa_mass_additions_insert_dist;

/
ALTER TRIGGER "APPS"."FA_MASS_ADDITIONS_INSERT_DIST" ENABLE;
