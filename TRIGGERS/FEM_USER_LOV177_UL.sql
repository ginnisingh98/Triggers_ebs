--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV177_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV177_UL" 
instead of update on FEM_USER_LOV177_VL
referencing new as FEM_USER_LOV177_B
for each row
begin
  FEM_USER_LOV177_PKG.UPDATE_ROW(
    X_USER_LOV177_CODE => :FEM_USER_LOV177_B.USER_LOV177_CODE,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_LOV177_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_LOV177_B.READ_ONLY_FLAG,
    X_ENABLED_FLAG => :FEM_USER_LOV177_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_LOV177_B.PERSONAL_FLAG,
    X_USER_LOV177_NAME => :FEM_USER_LOV177_B.USER_LOV177_NAME,
    X_DESCRIPTION => :FEM_USER_LOV177_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_USER_LOV177_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_LOV177_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_LOV177_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV177_UL" ENABLE;
