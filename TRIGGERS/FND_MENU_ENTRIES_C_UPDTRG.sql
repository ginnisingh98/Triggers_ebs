--------------------------------------------------------
--  DDL for Trigger FND_MENU_ENTRIES_C_UPDTRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_MENU_ENTRIES_C_UPDTRG" 
after update on "APPLSYS"."FND_MENU_ENTRIES"
for each row

declare
   last_mark NUMBER;
begin
   last_mark := NULL;

   /* If all the important columns are unchanged, then do nothing */
   if (    (:NEW.MENU_ID = :OLD.MENU_ID)
       AND (:NEW.ENTRY_SEQUENCE = :OLD.ENTRY_SEQUENCE)
       AND (:NEW.grant_flag = :OLD.grant_flag)
       AND (    (:NEW.SUB_MENU_ID = :OLD.SUB_MENU_ID)
            OR ((:NEW.SUB_MENU_ID is NULL) and (:OLD.SUB_MENU_ID is NULL)))
       AND (    (:NEW.FUNCTION_ID = :OLD.FUNCTION_ID)
            OR ((:NEW.FUNCTION_ID is NULL) and (:OLD.FUNCTION_ID is NULL))))
   then
     return;
   end if;

   /* Mark the new menu id */
   if (:NEW.MENU_ID is not NULL) then
     FND_FUNCTION.QUEUE_MARK(:NEW.MENU_ID);
     last_mark := :NEW.MENU_ID;
   end if;

   /* Mark the old menu id */
   if (:OLD.MENU_ID is not NULL) then
     /* Dont mark the same menu id twice */
     if (last_mark is NULL) or (last_mark <> :OLD.MENU_ID) then
       FND_FUNCTION.QUEUE_MARK(:OLD.MENU_ID);
     end if;
   end if;
end;



/
ALTER TRIGGER "APPS"."FND_MENU_ENTRIES_C_UPDTRG" ENABLE;
