--------------------------------------------------------
--  DDL for Trigger FEM_ENTITIES_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ENTITIES_UL" 
instead of update on FEM_ENTITIES_VL
referencing new as FEM_ENTITIES_B
for each row
begin
  FEM_ENTITIES_PKG.UPDATE_ROW(
    X_ENTITY_ID => :FEM_ENTITIES_B.ENTITY_ID,
    X_VALUE_SET_ID => :FEM_ENTITIES_B.VALUE_SET_ID,
    X_DIMENSION_GROUP_ID => :FEM_ENTITIES_B.DIMENSION_GROUP_ID,
    X_ENTITY_DISPLAY_CODE => :FEM_ENTITIES_B.ENTITY_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_ENTITIES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_ENTITIES_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_ENTITIES_B.OBJECT_VERSION_NUMBER,
    X_READ_ONLY_FLAG => :FEM_ENTITIES_B.READ_ONLY_FLAG,
    X_ENTITY_NAME => :FEM_ENTITIES_B.ENTITY_NAME,
    X_DESCRIPTION => :FEM_ENTITIES_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_ENTITIES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_ENTITIES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_ENTITIES_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ENTITIES_UL" ENABLE;
