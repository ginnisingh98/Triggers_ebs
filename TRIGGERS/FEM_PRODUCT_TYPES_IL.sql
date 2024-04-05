--------------------------------------------------------
--  DDL for Trigger FEM_PRODUCT_TYPES_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PRODUCT_TYPES_IL" 
instead of insert on FEM_PRODUCT_TYPES_VL
referencing new as FEM_PRODUCT_TYPES_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_PRODUCT_TYPES_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_PRODUCT_TYPE_ID => :FEM_PRODUCT_TYPES_B.PRODUCT_TYPE_ID,
    X_PRODUCT_TYPE_DISPLAY_CODE => :FEM_PRODUCT_TYPES_B.PRODUCT_TYPE_DISPLAY_CODE,
    X_ENABLED_FLAG => :FEM_PRODUCT_TYPES_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_PRODUCT_TYPES_B.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :FEM_PRODUCT_TYPES_B.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_PRODUCT_TYPES_B.OBJECT_VERSION_NUMBER,
    X_PRODUCT_TYPE_NAME => :FEM_PRODUCT_TYPES_B.PRODUCT_TYPE_NAME,
    X_DESCRIPTION => :FEM_PRODUCT_TYPES_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_PRODUCT_TYPES_B.CREATION_DATE,
    X_CREATED_BY => :FEM_PRODUCT_TYPES_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_PRODUCT_TYPES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_PRODUCT_TYPES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_PRODUCT_TYPES_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PRODUCT_TYPES_IL" ENABLE;
