--------------------------------------------------------
--  DDL for Trigger PAY_RUN_RESULTS_BRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."PAY_RUN_RESULTS_BRD" 
   before delete
   on     "HR"."PAY_RUN_RESULTS"
   for each row

begin
if hr_general.g_data_migrator_mode <> 'Y' then
   hr_utility.set_location('pay_run_results_brd',1);
   delete from pay_run_result_values RRV
   where  RRV.run_result_id = :OLD.run_result_id;
   hr_utility.set_location('pay_run_results_brd',2);
end if;
end pay_run_results_brd;



/
ALTER TRIGGER "APPS"."PAY_RUN_RESULTS_BRD" ENABLE;
