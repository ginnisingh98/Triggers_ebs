--------------------------------------------------------
--  DDL for Trigger FEM_TABLES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_TABLES_DL" 
instead of delete on FEM_TABLES_VL
referencing old as FEM_TABLES_B
for each row
begin
  FEM_TABLES_PKG.DELETE_ROW(
    X_TABLE_NAME => :FEM_TABLES_B.TABLE_NAME);
 ---
end DELETE_ROW;
 ---

/
ALTER TRIGGER "APPS"."FEM_TABLES_DL" ENABLE;
