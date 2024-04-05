--------------------------------------------------------
--  DDL for Trigger FEM_STOCK_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_STOCK_TYPES_DL" 
instead of delete on FEM_STOCK_TYPES_VL
referencing old as FEM_STOCK_TYPES_B
for each row
begin
  FEM_STOCK_TYPES_PKG.DELETE_ROW(
    X_STOCK_TYPE_CODE => :FEM_STOCK_TYPES_B.STOCK_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_STOCK_TYPES_DL" ENABLE;
