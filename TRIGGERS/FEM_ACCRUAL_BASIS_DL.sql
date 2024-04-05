--------------------------------------------------------
--  DDL for Trigger FEM_ACCRUAL_BASIS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_ACCRUAL_BASIS_DL" 
instead of delete on FEM_ACCRUAL_BASIS_VL
referencing old as FEM_ACCRUAL_BASIS_B
for each row
begin
  FEM_ACCRUAL_BASIS_PKG.DELETE_ROW(
    X_ACCRUAL_BASIS_ID => :FEM_ACCRUAL_BASIS_B.ACCRUAL_BASIS_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_ACCRUAL_BASIS_DL" ENABLE;
