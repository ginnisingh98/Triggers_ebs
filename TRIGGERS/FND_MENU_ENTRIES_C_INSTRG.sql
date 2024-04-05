--------------------------------------------------------
--  DDL for Trigger FND_MENU_ENTRIES_C_INSTRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_MENU_ENTRIES_C_INSTRG" 
after insert on "APPLSYS"."FND_MENU_ENTRIES"
for each row

begin
   /* Mark the new menu id */
   if (:NEW.MENU_ID is not NULL) then
     FND_FUNCTION.QUEUE_MARK(:NEW.MENU_ID);
   end if;
end;



/
ALTER TRIGGER "APPS"."FND_MENU_ENTRIES_C_INSTRG" ENABLE;
