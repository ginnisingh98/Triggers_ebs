--------------------------------------------------------
--  DDL for Trigger FND_PROG_ONSITE_DELETE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_PROG_ONSITE_DELETE" 
 AFTER DELETE ON "APPLSYS"."FND_CONCURRENT_PROGRAMS"
   FOR EACH ROW
 BEGIN
    -- Delete row in fnd_conc_prog_onsite_info table
    delete from fnd_conc_prog_onsite_info
     where Program_Application_Id = :old.Application_Id
       and Concurrent_Program_Id = :old.Concurrent_Program_Id;

--    Exception
--      When others then
--        null;
 END;



/
ALTER TRIGGER "APPS"."FND_PROG_ONSITE_DELETE" ENABLE;
