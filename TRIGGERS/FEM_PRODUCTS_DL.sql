--------------------------------------------------------
--  DDL for Trigger FEM_PRODUCTS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PRODUCTS_DL" 
instead of delete on FEM_PRODUCTS_VL
referencing old as FEM_PRODUCTS_B
for each row
begin
  FEM_PRODUCTS_PKG.DELETE_ROW(
    X_PRODUCT_ID => :FEM_PRODUCTS_B.PRODUCT_ID,
    X_VALUE_SET_ID => :FEM_PRODUCTS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PRODUCTS_DL" ENABLE;
