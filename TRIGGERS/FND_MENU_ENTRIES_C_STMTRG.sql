--------------------------------------------------------
--  DDL for Trigger FND_MENU_ENTRIES_C_STMTRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FND_MENU_ENTRIES_C_STMTRG" 
after insert or update or delete on "APPLSYS"."FND_MENU_ENTRIES"

begin
/* $Header: fndsctrg.sql 115.6 2001/12/21 15:07:57 pkm ship      $ */
   FND_FUNCTION.ADD_QUEUED_MARKS;
end;



/
ALTER TRIGGER "APPS"."FND_MENU_ENTRIES_C_STMTRG" ENABLE;
