--------------------------------------------------------
--  DDL for Trigger PAY_USER_COLUMN_INSTANCES_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_COLUMN_INSTANCES_ARI" 
after insert on           "HR"."PAY_USER_COLUMN_INSTANCES_F"
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
      from   pay_user_rows_f ur,
             pay_user_tables ut
      where  ut.user_table_id = ur.user_table_id
      and    ur.user_row_id   = nvl(:old.user_row_id, :new.user_row_id)
      group  by ut.user_table_name;

   if l_user_table_name = 'ZA_TERMINATION_CATEGORIES' then

         select pur.row_low_range_or_name                                                      meaning,
                min(decode(puc.user_column_name, 'Lookup Code',             :new.value, null)) lookup_code,
                min(decode(puc.user_column_name, 'Termination Description', :new.value, null)) description
         into   l_meaning,
                l_lookup_code,
                l_description
         from   pay_user_tables  put,
                pay_user_rows_f  pur,
                pay_user_columns puc
         where  put.user_table_id = pur.user_table_id
         and    put.user_table_name = 'ZA_TERMINATION_CATEGORIES'
         and    puc.user_table_id = put.user_table_id
         and    :new.user_column_id = puc.user_column_id
         and    :new.user_row_id = pur.user_row_id
         group  by pur.row_low_range_or_name;

         if l_lookup_code is null and l_description is not null then

            update fnd_lookup_values
            set    description = l_description
            where  lookup_type = 'LEAV_REAS'
            and    meaning     = l_meaning;

         elsif l_lookup_code is not null then

            insert into fnd_lookup_values
            (
               lookup_type,
               language,
               lookup_code,
               meaning,
               last_update_date,
               source_lang,
               last_updated_by,
               enabled_flag,
               start_date_active,
               end_date_active,
               description,
               last_update_login,
               created_by,
               creation_date,
               security_group_id,
               view_application_id
            )
            select 'LEAV_REAS',
                   'US',
                   l_lookup_code,
                   l_meaning,
                   sysdate,
                   'US',
                   1,
                   'Y',
                   null,
                   null,
                   l_description,
                   null,
                   1,
                   sysdate,
                   0,
                   3
            from   sys.dual
            where  not exists
            (
               select 1
               from   fnd_lookup_values fcl
               where  fcl.lookup_type = 'LEAV_REAS'
               and    fcl.language = 'US'
               and
               (
                  (fcl.lookup_code = l_lookup_code)
                  or
                  (fcl.meaning     = l_meaning)
               )
            );

         end if;

      end if;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_USER_COLUMN_INSTANCES_ARI" ENABLE;
