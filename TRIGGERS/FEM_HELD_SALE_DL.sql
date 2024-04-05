--------------------------------------------------------
--  DDL for Trigger FEM_HELD_SALE_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_HELD_SALE_DL" 
instead of delete on FEM_HELD_SALE_VL
referencing old as FEM_HELD_SALE_B
for each row
begin
  FEM_HELD_SALE_PKG.DELETE_ROW(
    X_HELD_FOR_SALE_ID => :FEM_HELD_SALE_B.HELD_FOR_SALE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_HELD_SALE_DL" ENABLE;
