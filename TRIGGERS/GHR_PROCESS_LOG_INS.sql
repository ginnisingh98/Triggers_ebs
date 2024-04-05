--------------------------------------------------------
--  DDL for Trigger GHR_PROCESS_LOG_INS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."GHR_PROCESS_LOG_INS" BEFORE INSERT ON "HR"."GHR_PROCESS_LOG"
FOR EACH ROW

begin
  if :new.PROGRAM_NAME is not null then
      :new.PROGRAM_NAME := ltrim(:new.PROGRAM_NAME);
  end if;
end;



/
ALTER TRIGGER "APPS"."GHR_PROCESS_LOG_INS" ENABLE;
