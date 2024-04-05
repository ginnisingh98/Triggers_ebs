--------------------------------------------------------
--  DDL for Trigger FEM_CALENDARS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_CALENDARS_DL" 
instead of delete on FEM_CALENDARS_VL
referencing old as CALENDAR
for each row
begin
  FEM_CALENDARS_PKG.DELETE_ROW(
    X_CALENDAR_ID => :CALENDAR.CALENDAR_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_CALENDARS_DL" ENABLE;
