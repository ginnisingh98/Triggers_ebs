--------------------------------------------------------
--  DDL for Trigger PAY_ZA_TEMP_BRANCH_DETAILS_ASI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_ZA_TEMP_BRANCH_DETAILS_ASI" 
after insert on           "HR"."PAY_ZA_TEMP_BRANCH_DETAILS"
declare

   -- This is a statement level trigger on PAY_ZA_TEMP_BRANCH_DETAILS
   -- needed since we cannot use a row level trigger to perform the
   -- bank name update in PAY_ZA_BRANCH_CDV_DETAILS because it would
   -- severely affect performance

   -- Local Variables
   l_start_range varchar2(80);
   l_end_range   varchar2(80);
   l_bank_name   varchar2(80);

   -- Cursor to retrieve the latest ranges and bank names from the
   -- ZA_CDV_BANK_NAMES

   cursor c_get_bank_names is
      select lpad(ur.row_low_range_or_name, 6, 0),
             ur.row_high_range,
             ci.value
      from   pay_user_column_instances_f ci,
             pay_user_rows_f             ur,
             pay_user_columns            uc,
             pay_user_tables             ut
      where  ut.user_table_name  = 'ZA_CDV_BANK_NAMES'
      and    uc.user_column_name = 'Bank Name'
      and    ut.user_table_id    = uc.user_table_id
      and    ut.user_table_id    = ur.user_table_id
      and    uc.user_column_id   = ci.user_column_id
      and    ur.user_row_id      = ci.user_row_id
      order  by 1 || 2;

begin

   if hr_general.g_data_migrator_mode <> 'Y' then

      -- The next section will perform the bank name update on the table
      open  c_get_bank_names;
      fetch c_get_bank_names into l_start_range, l_end_range, l_bank_name;

      loop

         -- This loop will perform the bank name update on table
         -- PAY_ZA_BRANCH_CDV_DETAILS
         exit when c_get_bank_names%notfound;

         update pay_za_branch_cdv_details
         set    bank_name    = l_bank_name
         where  branch_code >= l_start_range
         and    branch_code <= l_end_range;

         fetch c_get_bank_names into l_start_range, l_end_range, l_bank_name;

      end loop;

      close c_get_bank_names;

   end if;

end;


/
ALTER TRIGGER "APPS"."PAY_ZA_TEMP_BRANCH_DETAILS_ASI" ENABLE;
