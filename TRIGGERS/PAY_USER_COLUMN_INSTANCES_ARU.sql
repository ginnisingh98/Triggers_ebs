--------------------------------------------------------
--  DDL for Trigger PAY_USER_COLUMN_INSTANCES_ARU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_COLUMN_INSTANCES_ARU" 
after update on           "HR"."PAY_USER_COLUMN_INSTANCES_F"
for each row
declare

   -- Local variables
   l_user_table_name varchar2(80);
   l_start_range     varchar2(80);
   l_end_range       varchar2(80);
   l_bank_name       varchar2(80);
   l_meaning         varchar2(80) default null;
   l_lookup_code     varchar2(40) default null;
   l_description     varchar2(80) default null;

begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      -- Get the user table name in order to make sure that the trigger
      -- fires for the correct user table
      select ut.user_table_name
      into   l_user_table_name
      from   pay_user_tables ut,
             pay_user_rows_f ur
      where  ut.user_table_id = ur.user_table_id
      and    ur.user_row_id   = nvl(:old.user_row_id, :new.user_row_id)
      group  by ut.user_table_name;

      if l_user_table_name = 'ZA_TERMINATION_CATEGORIES' then

         select pur.row_low_range_or_name                                                      meaning,
                min(decode(puc.user_column_name, 'Lookup Code', :new.value, null))             lookup_code,
                min(decode(puc.user_column_name, 'Termination Description', :new.value, null)) description
         into   l_meaning,
                l_lookup_code,
                l_description
         from   pay_user_rows_f  pur,
                pay_user_tables  put,
                pay_user_columns puc
         where  put.user_table_id   = pur.user_table_id
         and    put.user_table_name = 'ZA_TERMINATION_CATEGORIES'
         and    puc.user_table_id   = put.user_table_id
         and    :new.user_column_id = puc.user_column_id
         and    :new.user_row_id    = pur.user_row_id
         group  by pur.row_low_range_or_name;

         if l_lookup_code is not null then

            update fnd_lookup_values hrl
            set    hrl.lookup_code = l_lookup_code
            where  hrl.lookup_type = 'LEAV_REAS'
            and    hrl.meaning     = l_meaning;

         elsif l_description is not null then

            update fnd_lookup_values hrl
            set    hrl.description = l_description
            where  hrl.lookup_type = 'LEAV_REAS'
            and    hrl.meaning     = l_meaning;

         end if;

      end if;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_USER_COLUMN_INSTANCES_ARU" ENABLE;
