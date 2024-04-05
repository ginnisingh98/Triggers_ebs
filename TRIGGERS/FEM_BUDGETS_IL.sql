--------------------------------------------------------
--  DDL for Trigger FEM_BUDGETS_IL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BUDGETS_IL" 
instead of insert on FEM_BUDGETS_VL
referencing new as FEM_BUDGETS_B
for each row
declare
  row_id rowid;
 ---
begin
  FEM_BUDGETS_PKG.INSERT_ROW(
    X_ROWID => ROW_ID,
    X_BUDGET_ID => :FEM_BUDGETS_B.BUDGET_ID,
    X_BUDGET_DISPLAY_CODE => :FEM_BUDGETS_B.BUDGET_DISPLAY_CODE,
    X_READ_ONLY_FLAG => :FEM_BUDGETS_B.READ_ONLY_FLAG,
    X_ENABLED_FLAG => :FEM_BUDGETS_B.ENABLED_FLAG,
    X_PERSONAL_FLAG => :FEM_BUDGETS_B.PERSONAL_FLAG,
    X_OBJECT_VERSION_NUMBER => :FEM_BUDGETS_B.OBJECT_VERSION_NUMBER,
    X_BUDGET_NAME => :FEM_BUDGETS_B.BUDGET_NAME,
    X_DESCRIPTION => :FEM_BUDGETS_B.DESCRIPTION,
    X_CREATION_DATE => :FEM_BUDGETS_B.CREATION_DATE,
    X_CREATED_BY => :FEM_BUDGETS_B.CREATED_BY,
    X_LAST_UPDATE_DATE => :FEM_BUDGETS_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_BUDGETS_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_BUDGETS_B.LAST_UPDATE_LOGIN);
 ---
end INSERT_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BUDGETS_IL" ENABLE;
