--------------------------------------------------------
--  DDL for Trigger FEM_PROPTYPES_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PROPTYPES_UL" 
instead of update on FEM_PROPTYPES_VL
referencing new as FEM_PROPTYPES_B
for each row
begin
  FEM_PROPTYPES_PKG.UPDATE_ROW(
    X_PROPERTY_TYPE_CODE => :FEM_PROPTYPES_B.PROPERTY_TYPE_CODE,
    X_ENABLED_FLAG => :FEM_PROPTYPES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_PROPTYPES_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_PROPTYPES_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_PROPTYPES_B.OBJECT_VERSION_NUMBER,
    X_PROPERTY_TYPE_NAME => :FEM_PROPTYPES_B.PROPERTY_TYPE_NAME,
    X_DESCRIPTION => :FEM_PROPTYPES_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_PROPTYPES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_PROPTYPES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_PROPTYPES_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PROPTYPES_UL" ENABLE;
