--------------------------------------------------------
--  DDL for Trigger AP_MAP_TYPES_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."AP_MAP_TYPES_IL" 
instead of insert on AP_MAP_TYPES_VL
referencing new as MAP
for each row
declare
  row_id rowid;
begin
  AP_MAP_TYPES_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_MAP_TYPE_CODE => :MAP.MAP_TYPE_CODE,
    X_FROM_APPLICATION_ID => :MAP.FROM_APPLICATION_ID,
    X_FROM_LOOKUP_TYPE => :MAP.FROM_LOOKUP_TYPE,
    X_TO_APPLICATION_ID => :MAP.TO_APPLICATION_ID,
    X_TO_LOOKUP_TYPE => :MAP.TO_LOOKUP_TYPE,
    X_DEFAULT_LOOKUP_CODE => :MAP.DEFAULT_LOOKUP_CODE,
    X_MEANING => :MAP.MEANING,
    X_DESCRIPTION => :MAP.DESCRIPTION,
    X_CREATION_DATE => :MAP.CREATION_DATE,
    X_CREATED_BY => :MAP.CREATED_BY,
    X_LAST_UPDATE_DATE => :MAP.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :MAP.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :MAP.LAST_UPDATE_LOGIN);
end INSERT_ROW;


/
ALTER TRIGGER "APPS"."AP_MAP_TYPES_IL" ENABLE;
