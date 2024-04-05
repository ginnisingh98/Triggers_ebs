--------------------------------------------------------
--  DDL for Trigger FEM_TAB_COLUMNS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_TAB_COLUMNS_DL" 
instead of delete on FEM_TAB_COLUMNS_VL
referencing old as FEM_TAB_COLUMNS_B
for each row
begin
  FEM_TAB_COLUMNS_PKG.DELETE_ROW(
    X_TABLE_NAME => :FEM_TAB_COLUMNS_B.TABLE_NAME,
    X_COLUMN_NAME => :FEM_TAB_COLUMNS_B.COLUMN_NAME);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_TAB_COLUMNS_DL" ENABLE;
