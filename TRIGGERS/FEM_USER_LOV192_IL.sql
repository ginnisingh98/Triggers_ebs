--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV192_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV192_IL" 
instead of insert on FEM_USER_LOV192_VL
referencing new as FEM_USER_LOV192_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_USER_LOV192_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_USER_LOV192_CODE => :FEM_USER_LOV192_B.USER_LOV192_CODE,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_LOV192_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_LOV192_B.READ_ONLY_FLAG,
    X_ENABLED_FLAG => :FEM_USER_LOV192_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_LOV192_B.PERSONAL_FLAG,
    X_USER_LOV192_NAME => :FEM_USER_LOV192_B.USER_LOV192_NAME,
    X_DESCRIPTION => :FEM_USER_LOV192_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_USER_LOV192_B.CREATION_DATE,
    X_CREATED_BY => :FEM_USER_LOV192_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_USER_LOV192_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_LOV192_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_LOV192_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV192_IL" ENABLE;
