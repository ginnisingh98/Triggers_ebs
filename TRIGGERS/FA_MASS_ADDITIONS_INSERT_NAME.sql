--------------------------------------------------------
--  DDL for Trigger FA_MASS_ADDITIONS_INSERT_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FA_MASS_ADDITIONS_INSERT_NAME" 
before insert
on "FA"."FA_MASS_ADDITIONS" for each row
declare
  h_dist_id  number;
  h_massadd_dist_id number;
  h_rows	number;
  h_units_perc  number;
  h_units	number;
  h_deprn_expense_ccid number;
  h_location_id number;
  h_employee_id number;

 CURSOR dist_lines is
	select unit_percentage,
	       deprn_expense_ccid,
	       location_id,
	       employee_id
          from fa_distribution_defaults d, fa_distribution_sets s
         where s.name=:new.dist_name
           and s.dist_set_id=d.dist_set_id;
begin
  if (nvl(:new.split_code,'')='SC') or (:new.dist_name is null)
	or (:new.mass_addition_id is null)
       -- commented out for bugfix 1702783
       -- or (:new.transaction_type_code in ('FUTURE ADD','FUTURE ADJ','FUTURE CAP'))
  then
     return;
  end if;

 select count(*)
   into h_rows
   from fa_distribution_defaults d, fa_distribution_sets s
  where s.name=:new.dist_name
    and s.dist_set_id=d.dist_set_id;

 OPEN dist_lines;
 for record_num In 1..h_rows Loop
 FETCH  dist_lines into
      h_units_perc,
      h_deprn_expense_ccid,
      h_location_id,
      h_employee_id;
  if (dist_lines%NOTFOUND) then return; end if;

 -- Bug 2097087 : Round to 4 decimals instead of 2.
    -- h_units := round(:new.fixed_assets_units * (h_units_perc / 100),2);
       h_units := :new.fixed_assets_units * (h_units_perc / 100);

  insert into fa_massadd_distributions (
	massadd_dist_id, mass_addition_id,
	units, deprn_expense_ccid, location_id, employee_id)
  values (
        fa_massadd_distributions_s.nextval,
       :new.mass_addition_id,
	h_units,
	h_deprn_expense_ccid,
	h_location_id,
	h_employee_id);
 end loop;
end fa_mass_additions_insert_name;

/
ALTER TRIGGER "APPS"."FA_MASS_ADDITIONS_INSERT_NAME" ENABLE;
