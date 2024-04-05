--------------------------------------------------------
--  DDL for Trigger FEM_LN_ITEMS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LN_ITEMS_DL" 
instead of delete on FEM_LN_ITEMS_VL
referencing old as FEM_LN_ITEMS_B
for each row
begin
  FEM_LN_ITEMS_PKG.DELETE_ROW(
    X_LINE_ITEM_ID => :FEM_LN_ITEMS_B.LINE_ITEM_ID,
    X_VALUE_SET_ID => :FEM_LN_ITEMS_B.VALUE_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_LN_ITEMS_DL" ENABLE;
