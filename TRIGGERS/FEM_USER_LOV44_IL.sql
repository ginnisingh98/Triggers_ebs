--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV44_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV44_IL" 
instead of insert on FEM_USER_LOV44_VL
referencing new as FEM_USER_LOV44_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_USER_LOV44_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_USER_LOV44_CODE => :FEM_USER_LOV44_B.USER_LOV44_CODE,
    X_ENABLED_FLAG => :FEM_USER_LOV44_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_LOV44_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_LOV44_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_LOV44_B.READ_ONLY_FLAG,
    X_USER_LOV44_NAME => :FEM_USER_LOV44_B.USER_LOV44_NAME,
    X_DESCRIPTION => :FEM_USER_LOV44_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_USER_LOV44_B.CREATION_DATE,
    X_CREATED_BY => :FEM_USER_LOV44_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_USER_LOV44_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_LOV44_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_LOV44_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV44_IL" ENABLE;
