--------------------------------------------------------
--  DDL for Trigger FEM_FUNC_DIM_SETS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FUNC_DIM_SETS_DL" 
instead of delete on FEM_FUNC_DIM_SETS_VL
referencing old as FEM_FUNC_DIM_SETS_B
for each row
begin
  FEM_FUNC_DIM_SETS_PKG.DELETE_ROW(
    X_FUNC_DIM_SET_ID => :FEM_FUNC_DIM_SETS_B.FUNC_DIM_SET_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FUNC_DIM_SETS_DL" ENABLE;
