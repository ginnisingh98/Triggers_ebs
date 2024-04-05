--------------------------------------------------------
--  DDL for Trigger AP_MAP_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_MAP_TYPES_DL" 
instead of delete on AP_MAP_TYPES_VL
referencing old as MAP
for each row
begin
  AP_MAP_TYPES_PKG.DELETE_ROW(
    X_MAP_TYPE_CODE => :MAP.MAP_TYPE_CODE);
end DELETE_ROW;


/
ALTER TRIGGER "APPS"."AP_MAP_TYPES_DL" ENABLE;
