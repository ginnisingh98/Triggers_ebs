--------------------------------------------------------
--  DDL for Trigger PAY_USER_ROWS_F_ARD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_ROWS_F_ARD" 
after delete on           "HR"."PAY_USER_ROWS_F"
for each row
declare

   -- Local variables
   l_user_table_name varchar2(80);

begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      select user_table_name
      into   l_user_table_name
      from   pay_user_tables
      where  user_table_id = :old.user_table_id;

      if l_user_table_name = 'ZA_RSC_TABLE' then

         -- Delete the corresponding value from fnd_lookup_values
         delete from fnd_lookup_values
         where  lookup_type = 'ZA_RSC_REGIONS'
         and    meaning     = :old.row_low_range_or_name;

      end if;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_USER_ROWS_F_ARD" ENABLE;
