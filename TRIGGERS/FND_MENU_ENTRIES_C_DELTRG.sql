--------------------------------------------------------
--  DDL for Trigger FND_MENU_ENTRIES_C_DELTRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_MENU_ENTRIES_C_DELTRG" 
after delete on "APPLSYS"."FND_MENU_ENTRIES"
for each row

begin
   /* Mark the old menu id */
   if (:OLD.MENU_ID is not NULL) then
     FND_FUNCTION.QUEUE_MARK(:OLD.MENU_ID);
   end if;
end;



/
ALTER TRIGGER "APPS"."FND_MENU_ENTRIES_C_DELTRG" ENABLE;
