--------------------------------------------------------
--  DDL for Trigger PAY_USER_ROWS_F_ARI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_USER_ROWS_F_ARI" 
after insert on           "HR"."PAY_USER_ROWS_F"
for each row
declare

   -- Local variables
   l_user_table_name varchar2(80);

begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      select user_table_name
      into   l_user_table_name
      from   pay_user_tables
      where  user_table_id = :new.user_table_id;

      if l_user_table_name = 'ZA_RSC_TABLE' then

         -- Insert the new value in fnd_lookup_values
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
         select 'ZA_RSC_REGIONS',
                'US',
                :new.row_low_range_or_name,
                :new.row_low_range_or_name,
                sysdate,
                'US',
                1,
                'Y',
                null,
                null,
                :new.row_low_range_or_name,
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
            where  lookup_type = 'ZA_RSC_REGIONS'
            and
            (
               (lookup_code = :new.row_low_range_or_name)
               or
               (meaning     = :new.row_low_range_or_name)
            )
         );

      end if;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_USER_ROWS_F_ARI" ENABLE;
