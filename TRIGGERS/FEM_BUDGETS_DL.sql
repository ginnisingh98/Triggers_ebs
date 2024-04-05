--------------------------------------------------------
--  DDL for Trigger FEM_BUDGETS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BUDGETS_DL" 
instead of delete on FEM_BUDGETS_VL
referencing old as FEM_BUDGETS_B
for each row
begin
  FEM_BUDGETS_PKG.DELETE_ROW(
    X_BUDGET_ID => :FEM_BUDGETS_B.BUDGET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BUDGETS_DL" ENABLE;
