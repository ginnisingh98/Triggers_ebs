--------------------------------------------------------
--  DDL for Trigger FND_PROG_ONSITE_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_PROG_ONSITE_INSERT" 
 AFTER INSERT ON "APPLSYS"."FND_CONCURRENT_PROGRAMS"
   FOR EACH ROW
 BEGIN
   -- Insert into fnd_conc_prog_onsite_info table
   -- Not handling any exception. Let it raise that exception.
   insert into fnd_conc_prog_onsite_info
         (Program_Application_Id, Concurrent_Program_Id,
          Last_Update_Date, Last_Updated_By,
          Creation_Date, Created_By, Last_Update_Login,
	  reset_date, On_Failure_Log_Level)
   values
         (:new.Application_Id, :new.Concurrent_Program_Id,
          :new.Last_Update_Date, :new.Last_Updated_By,
          :new.Creation_Date, :new.Created_By, :new.Last_Update_Login,
	  sysdate, 'ERROR');
 END;



/
ALTER TRIGGER "APPS"."FND_PROG_ONSITE_INSERT" ENABLE;
