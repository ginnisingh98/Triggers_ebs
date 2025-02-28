--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV23_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV23_IL" 
instead of insert on FEM_USER_LOV23_VL
referencing new as FEM_USER_LOV23_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_USER_LOV23_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_USER_LOV23_CODE => :FEM_USER_LOV23_B.USER_LOV23_CODE,
    X_ENABLED_FLAG => :FEM_USER_LOV23_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_LOV23_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_LOV23_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_LOV23_B.READ_ONLY_FLAG,
    X_USER_LOV23_NAME => :FEM_USER_LOV23_B.USER_LOV23_NAME,
    X_DESCRIPTION => :FEM_USER_LOV23_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_USER_LOV23_B.CREATION_DATE,
    X_CREATED_BY => :FEM_USER_LOV23_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_USER_LOV23_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_LOV23_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_LOV23_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV23_IL" ENABLE;
