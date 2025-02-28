--------------------------------------------------------
--  DDL for Trigger FEM_USER_DIM7_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_DIM7_UL" 
instead of update on FEM_USER_DIM7_VL
referencing new as FEM_USER_DIM7_B
for each row
begin
  FEM_USER_DIM7_PKG.UPDATE_ROW(
    X_USER_DIM7_ID => :FEM_USER_DIM7_B.USER_DIM7_ID,
    X_VALUE_SET_ID => :FEM_USER_DIM7_B.VALUE_SET_ID,
    X_USER_DIM7_DISPLAY_CODE => :FEM_USER_DIM7_B.USER_DIM7_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_USER_DIM7_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_USER_DIM7_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_USER_DIM7_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_USER_DIM7_B.READ_ONLY_FLAG,
    X_DIMENSION_GROUP_ID => :FEM_USER_DIM7_B.DIMENSION_GROUP_ID,
    X_USER_DIM7_NAME => :FEM_USER_DIM7_B.USER_DIM7_NAME,
    X_DESCRIPTION => :FEM_USER_DIM7_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_USER_DIM7_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_USER_DIM7_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_USER_DIM7_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_DIM7_UL" ENABLE;
