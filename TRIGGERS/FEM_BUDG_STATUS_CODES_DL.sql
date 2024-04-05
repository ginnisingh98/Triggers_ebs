--------------------------------------------------------
--  DDL for Trigger FEM_BUDG_STATUS_CODES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BUDG_STATUS_CODES_DL" 
instead of delete on FEM_BUDG_STATUS_CODES_VL
referencing old as FEM_BUDG_STATUS_CODES_B
for each row
begin
  FEM_BUDG_STATUS_CODES_PKG.DELETE_ROW(
    X_BUDGET_STATUS_CODE => :FEM_BUDG_STATUS_CODES_B.BUDGET_STATUS_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BUDG_STATUS_CODES_DL" ENABLE;
