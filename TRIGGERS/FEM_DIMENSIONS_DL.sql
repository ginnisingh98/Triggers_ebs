--------------------------------------------------------
--  DDL for Trigger FEM_DIMENSIONS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIMENSIONS_DL" 
instead of delete on FEM_DIMENSIONS_VL
referencing old as DIMENSION
for each row
begin
  FEM_DIMENSIONS_PKG.DELETE_ROW(
    X_DIMENSION_ID => :DIMENSION.DIMENSION_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIMENSIONS_DL" ENABLE;
