--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV94_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV94_IL" 
instead of insert on FEM_USER_LOV94_VL
referencing new as FEM_USER_LOV94_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_USER_LOV94_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_USER_LOV94_CODE => :FEM_USER_LOV94_B.USER_LOV94_CODE,
    X_ENABLED_FLAG => :FEM_USER_LOV94_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_LOV94_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_LOV94_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_LOV94_B.READ_ONLY_FLAG,
    X_USER_LOV94_NAME => :FEM_USER_LOV94_B.USER_LOV94_NAME,
    X_DESCRIPTION => :FEM_USER_LOV94_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_USER_LOV94_B.CREATION_DATE,
    X_CREATED_BY => :FEM_USER_LOV94_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_USER_LOV94_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_LOV94_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_LOV94_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV94_IL" ENABLE;
