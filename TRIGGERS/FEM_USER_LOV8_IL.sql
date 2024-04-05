--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV8_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV8_IL" 
instead of insert on FEM_USER_LOV8_VL
referencing new as FEM_USER_LOV8_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_USER_LOV8_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_USER_LOV8_CODE => :FEM_USER_LOV8_B.USER_LOV8_CODE,
    X_ENABLED_FLAG => :FEM_USER_LOV8_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_LOV8_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_LOV8_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_LOV8_B.READ_ONLY_FLAG,
    X_USER_LOV8_NAME => :FEM_USER_LOV8_B.USER_LOV8_NAME,
    X_DESCRIPTION => :FEM_USER_LOV8_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_USER_LOV8_B.CREATION_DATE,
    X_CREATED_BY => :FEM_USER_LOV8_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_USER_LOV8_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_LOV8_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_LOV8_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV8_IL" ENABLE;
