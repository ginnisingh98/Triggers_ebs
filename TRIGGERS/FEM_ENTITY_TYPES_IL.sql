--------------------------------------------------------
--  DDL for Trigger FEM_ENTITY_TYPES_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ENTITY_TYPES_IL" 
instead of insert on FEM_ENTITY_TYPES_VL
referencing new as FEM_ENTITY_TYPES_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_ENTITY_TYPES_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_ENTITY_TYPE_CODE => :FEM_ENTITY_TYPES_B.ENTITY_TYPE_CODE,
    X_ENABLED_FLAG => :FEM_ENTITY_TYPES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_ENTITY_TYPES_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_ENTITY_TYPES_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_ENTITY_TYPES_B.OBJECT_VERSION_NUMBER,
    X_ENTITY_TYPE_NAME => :FEM_ENTITY_TYPES_B.ENTITY_TYPE_NAME,
    X_DESCRIPTION => :FEM_ENTITY_TYPES_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_ENTITY_TYPES_B.CREATION_DATE,
    X_CREATED_BY => :FEM_ENTITY_TYPES_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_ENTITY_TYPES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_ENTITY_TYPES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_ENTITY_TYPES_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ENTITY_TYPES_IL" ENABLE;
