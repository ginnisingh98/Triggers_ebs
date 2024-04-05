--------------------------------------------------------
--  DDL for Trigger FA_MASS_ADDITIONS_UPDATE_DIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_MASS_ADDITIONS_UPDATE_DIST" 
before update of fixed_assets_units, expense_code_combination_id,
	location_id, assigned_to,mass_addition_id
on "FA"."FA_MASS_ADDITIONS" for each row
declare
  h_count       number;
begin
 if (nvl(:new.sum_units,'') = 'YES')
 then
   null;
 else
  select count(*) into h_count
    from fa_massadd_distributions
    where mass_addition_id = :new.mass_addition_id;
  if (h_count = 1) and (:old.mass_addition_id is not null)
  then
  /*   commented out the following for bug #977311.
       The following updates fa_massadd_distributions with wrong units
       when unit is changed. When units are changed, user is forced
       to re-distribute units thru assignment winodw in the form
       therefore update here is not necessary */
 /* if :new.fixed_assets_units is not null
    then
     update fa_massadd_distributions
       set units = :new.fixed_assets_units
     where mass_addition_id = :new.mass_addition_id;
    end if; */

    if :new.expense_code_combination_id is not null
    then
     update fa_massadd_distributions
        set deprn_expense_ccid = :new.expense_code_combination_id
     where mass_addition_id = :new.mass_addition_id;
	 /* NULL this value in fa_mass_additions */
	 :new.expense_code_combination_id := NULL;
    end if;
    if :new.location_id is not null
    then
      update fa_massadd_distributions
         set location_id = :new.location_id
      where mass_addition_id = :new.mass_addition_id;
	  /* NULL this value in fa_mass_additions */
	  :new.location_id := NULL;
    end if;
    if :new.assigned_to is not null
    then
      update fa_massadd_distributions
         set employee_id = :new.assigned_to
      where mass_addition_id = :new.mass_addition_id;
	  /* NULL this value in fa_mass_additions */
	  :new.assigned_to := NULL;
    end if;
  elsif h_count=0  and :old.mass_addition_id is null
			/* No massadd row-so insert now  */
  then
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
  end if;  /* h_count   */
 end if;  /* sum_units   */
end fa_mass_additions_update_dist;

/
ALTER TRIGGER "APPS"."FA_MASS_ADDITIONS_UPDATE_DIST" ENABLE;
