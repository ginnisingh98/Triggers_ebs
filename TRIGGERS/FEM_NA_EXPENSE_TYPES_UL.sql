--------------------------------------------------------
--  DDL for Trigger FEM_NA_EXPENSE_TYPES_UL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_NA_EXPENSE_TYPES_UL" 
instead of update on FEM_NA_EXPENSE_TYPES_VL
referencing new as FEM_NA_EXPENSE_TYPES_B
for each row
begin
  FEM_NA_EXPENSE_TYPES_PKG.UPDATE_ROW(
    X_NA_EXPENSE_TYPE_CODE => :FEM_NA_EXPENSE_TYPES_B.NA_EXPENSE_TYPE_CODE,
    X_ENABLED_FLAG => :FEM_NA_EXPENSE_TYPES_B.ENABLED_FLAG,
    X_READ_ONLY_FLAG => :FEM_NA_EXPENSE_TYPES_B.READ_ONLY_FLAG,
    X_PERSONAL_FLAG => :FEM_NA_EXPENSE_TYPES_B.PERSONAL_FLAG,
    X_NA_EXPENSE_TYPE_NAME => :FEM_NA_EXPENSE_TYPES_B.NA_EXPENSE_TYPE_NAME,
    X_DESCRIPTION => :FEM_NA_EXPENSE_TYPES_B.DESCRIPTION,
    X_LAST_UPDATE_DATE => :FEM_NA_EXPENSE_TYPES_B.LAST_UPDATE_DATE,
    X_LAST_UPDATED_BY => :FEM_NA_EXPENSE_TYPES_B.LAST_UPDATED_BY,
    X_LAST_UPDATE_LOGIN => :FEM_NA_EXPENSE_TYPES_B.LAST_UPDATE_LOGIN);
 ---
end UPDATE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_NA_EXPENSE_TYPES_UL" ENABLE;
