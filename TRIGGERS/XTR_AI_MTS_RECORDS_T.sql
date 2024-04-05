--------------------------------------------------------
--  DDL for Trigger XTR_AI_MTS_RECORDS_T
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."XTR_AI_MTS_RECORDS_T" 
 AFTER INSERT ON "XTR"."XTR_MTS_RECORDS"
 FOR EACH ROW
 --
begin
 insert into XTR_MTS_RECORDS_HISTORY
  (script_name,transfer_details,created_on_date,
   file_name,settlement_date)
 values
  (:new.script_name,:new.transfer_details,:new.created_on_date,
   :new.file_name,:new.settlement_date);
end;
/
ALTER TRIGGER "APPS"."XTR_AI_MTS_RECORDS_T" ENABLE;
