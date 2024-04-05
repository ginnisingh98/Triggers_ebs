--------------------------------------------------------
--  DDL for Trigger PAY_USER_ROWS_F_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_ROWS_F_ARU" 
after update on           "HR"."PAY_USER_ROWS_F"
for each row
declare

   -- Local variables
   l_user_table_name varchar2(80);

begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      select ut.user_table_name
      into   l_user_table_name
      from   pay_user_tables ut
      where  ut.user_table_id = :old.user_table_id;

      if l_user_table_name = 'ZA_RSC_TABLE' then

         -- Update fnd_lookup_values */
         update fnd_lookup_values
         set    lookup_code      = :new.row_low_range_or_name,
                meaning          = :new.row_low_range_or_name,
                last_update_date = sysdate ,
                description      = :new.row_low_range_or_name
         where  lookup_type      = 'ZA_RSC_REGIONS'
         and
         (
            (lookup_code = :old.row_low_range_or_name)
            or
            (meaning     = :old.row_low_range_or_name)
         );

      end if;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_USER_ROWS_F_ARU" ENABLE;
