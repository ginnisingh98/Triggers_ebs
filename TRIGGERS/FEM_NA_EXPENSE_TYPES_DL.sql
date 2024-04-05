--------------------------------------------------------
--  DDL for Trigger FEM_NA_EXPENSE_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_NA_EXPENSE_TYPES_DL" 
instead of delete on FEM_NA_EXPENSE_TYPES_VL
referencing old as FEM_NA_EXPENSE_TYPES_B
for each row
begin
  FEM_NA_EXPENSE_TYPES_PKG.DELETE_ROW(
    X_NA_EXPENSE_TYPE_CODE => :FEM_NA_EXPENSE_TYPES_B.NA_EXPENSE_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_NA_EXPENSE_TYPES_DL" ENABLE;
