--------------------------------------------------------
--  DDL for Trigger FEM_DIM_ATTRIBUTES_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIM_ATTRIBUTES_IL" 
instead of insert on FEM_DIM_ATTRIBUTES_VL
referencing new as ATTRIBUTE
for each row
declare
  row_id rowid;
 ---
begin
  FEM_DIM_ATTRIBUTES_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_ATTRIBUTE_ID => :ATTRIBUTE.ATTRIBUTE_ID,
    X_ATTRIBUTE_VARCHAR_LABEL => :ATTRIBUTE.ATTRIBUTE_VARCHAR_LABEL,
    X_DIMENSION_ID => :ATTRIBUTE.DIMENSION_ID,
    X_ATTRIBUTE_DIMENSION_ID => :ATTRIBUTE.ATTRIBUTE_DIMENSION_ID,
    X_ATTRIBUTE_VALUE_COLUMN_NAME => :ATTRIBUTE.ATTRIBUTE_VALUE_COLUMN_NAME,
    X_ATTRIBUTE_DATA_TYPE_CODE => :ATTRIBUTE.ATTRIBUTE_DATA_TYPE_CODE,
    X_ALLOW_MULTIPLE_ASSIGNMENT_FL => :ATTRIBUTE.ALLOW_MULTIPLE_ASSIGNMENT_FLAG,
    X_ATTRIBUTE_ORDER_TYPE_CODE => :ATTRIBUTE.ATTRIBUTE_ORDER_TYPE_CODE,
    X_ATTRIBUTE_REQUIRED_FLAG => :ATTRIBUTE.ATTRIBUTE_REQUIRED_FLAG,
    X_USE_INHERITANCE_FLAG => :ATTRIBUTE.USE_INHERITANCE_FLAG,
    X_QUERYABLE_FOR_REPORTING_FLAG => :ATTRIBUTE.QUERYABLE_FOR_REPORTING_FLAG,
    X_ALLOW_MULTIPLE_VERSIONS_FLAG => :ATTRIBUTE.ALLOW_MULTIPLE_VERSIONS_FLAG,
    X_ASSIGNMENT_IS_READ_ONLY_FLAG => :ATTRIBUTE.ASSIGNMENT_IS_READ_ONLY_FLAG,
    X_PERSONAL_FLAG => :ATTRIBUTE.PERSONAL_FLAG,
    X_READ_ONLY_FLAG => :ATTRIBUTE.READ_ONLY_FLAG,
    X_OBJECT_VERSION_NUMBER => :ATTRIBUTE.OBJECT_VERSION_NUMBER,
    X_USER_ASSIGN_ALLOWED_FLAG => :ATTRIBUTE.USER_ASSIGN_ALLOWED_FLAG,
    X_ATTRIBUTE_NAME => :ATTRIBUTE.ATTRIBUTE_NAME,
    X_DESCRIPTION => :ATTRIBUTE.DESCRIPTION,
    X_CREATION_DATE => :ATTRIBUTE.CREATION_DATE,
    X_CREATED_BY => :ATTRIBUTE.CREATED_BY,
    X_LAST_UPDATE_DATE => :ATTRIBUTE.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :ATTRIBUTE.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :ATTRIBUTE.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIM_ATTRIBUTES_IL" ENABLE;
