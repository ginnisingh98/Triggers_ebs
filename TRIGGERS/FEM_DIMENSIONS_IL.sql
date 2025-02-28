--------------------------------------------------------
--  DDL for Trigger FEM_DIMENSIONS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIMENSIONS_IL" 
instead of insert on FEM_DIMENSIONS_VL
referencing new as DIMENSION
for each row
declare
  row_id rowid;
 ---
begin
  FEM_DIMENSIONS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_DIMENSION_ID => :DIMENSION.DIMENSION_ID,
    X_OBJECT_VERSION_NUMBER => :DIMENSION.OBJECT_VERSION_NUMBER,
    X_DIMENSION_VARCHAR_LABEL => :DIMENSION.DIMENSION_VARCHAR_LABEL,
    X_DIM_OWNER_APPLICATION_ID => :DIMENSION.DIM_OWNER_APPLICATION_ID,
    X_DIMENSION_NAME => :DIMENSION.DIMENSION_NAME,
    X_DESCRIPTION => :DIMENSION.DESCRIPTION,
    X_CREATION_DATE => :DIMENSION.CREATION_DATE,
    X_CREATED_BY => :DIMENSION.CREATED_BY,
    X_LAST_UPDATE_DATE => :DIMENSION.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :DIMENSION.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :DIMENSION.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIMENSIONS_IL" ENABLE;
