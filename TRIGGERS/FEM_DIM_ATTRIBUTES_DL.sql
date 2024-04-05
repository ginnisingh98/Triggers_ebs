--------------------------------------------------------
--  DDL for Trigger FEM_DIM_ATTRIBUTES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIM_ATTRIBUTES_DL" 
instead of delete on FEM_DIM_ATTRIBUTES_VL
referencing old as ATTRIBUTE
for each row
begin
  FEM_DIM_ATTRIBUTES_PKG.DELETE_ROW(
    X_ATTRIBUTE_ID => :ATTRIBUTE.ATTRIBUTE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIM_ATTRIBUTES_DL" ENABLE;
