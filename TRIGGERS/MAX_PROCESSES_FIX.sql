--------------------------------------------------------
--  DDL for Trigger MAX_PROCESSES_FIX
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."MAX_PROCESSES_FIX" 
  BEFORE UPDATE ON "APPLSYS"."FND_CONCURRENT_QUEUE_SIZE"
  FOR EACH ROW
	BEGIN
	  :new.max_processes := :new.min_processes;
	END;


/
ALTER TRIGGER "APPS"."MAX_PROCESSES_FIX" ENABLE;
