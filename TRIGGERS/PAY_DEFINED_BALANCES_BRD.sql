--------------------------------------------------------
--  DDL for Trigger PAY_DEFINED_BALANCES_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_DEFINED_BALANCES_BRD" 
   before delete
   on     "HR"."PAY_DEFINED_BALANCES"
   for each row
begin
if hr_general.g_data_migrator_mode <> 'Y' then
--
   --  delete the FF User Entity, this cascades to delete the database item
   --  and the user where clause filler.
   hr_utility.set_location('pay_defined_balances_brd',1);
   delete from ff_user_entities UE
   where UE.creator_type in ('B', 'RB')
   and   UE.creator_id = :OLD.defined_balance_id;
--
   hr_utility.set_location('pay_defined_balances_brd',2);
end if;
end pay_defined_balances_brd;



/
ALTER TRIGGER "APPS"."PAY_DEFINED_BALANCES_BRD" ENABLE;
