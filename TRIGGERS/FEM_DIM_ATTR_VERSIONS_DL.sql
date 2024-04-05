--------------------------------------------------------
--  DDL for Trigger FEM_DIM_ATTR_VERSIONS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIM_ATTR_VERSIONS_DL" 
instead of delete on FEM_DIM_ATTR_VERSIONS_VL
referencing old as DIM_ATTR_VERSION
for each row
begin
  FEM_DIM_ATTR_VERSIONS_PKG.DELETE_ROW(
    X_VERSION_ID => :DIM_ATTR_VERSION.VERSION_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIM_ATTR_VERSIONS_DL" ENABLE;
