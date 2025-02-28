--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV108_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV108_IL" 
instead of insert on FEM_USER_LOV108_VL
referencing new as FEM_USER_LOV108_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_USER_LOV108_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_USER_LOV108_CODE => :FEM_USER_LOV108_B.USER_LOV108_CODE,
    X_ENABLED_FLAG => :FEM_USER_LOV108_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_LOV108_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_LOV108_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_LOV108_B.READ_ONLY_FLAG,
    X_USER_LOV108_NAME => :FEM_USER_LOV108_B.USER_LOV108_NAME,
    X_DESCRIPTION => :FEM_USER_LOV108_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_USER_LOV108_B.CREATION_DATE,
    X_CREATED_BY => :FEM_USER_LOV108_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_USER_LOV108_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_LOV108_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_LOV108_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV108_IL" ENABLE;
