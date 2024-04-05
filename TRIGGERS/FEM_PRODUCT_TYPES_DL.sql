--------------------------------------------------------
--  DDL for Trigger FEM_PRODUCT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PRODUCT_TYPES_DL" 
instead of delete on FEM_PRODUCT_TYPES_VL
referencing old as FEM_PRODUCT_TYPES_B
for each row
begin
  FEM_PRODUCT_TYPES_PKG.DELETE_ROW(
    X_PRODUCT_TYPE_ID => :FEM_PRODUCT_TYPES_B.PRODUCT_TYPE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PRODUCT_TYPES_DL" ENABLE;
