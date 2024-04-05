--------------------------------------------------------
--  DDL for Trigger FEM_BAL_SHEET_MODELS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BAL_SHEET_MODELS_DL" 
instead of delete on FEM_BAL_SHEET_MODELS_VL
referencing old as FEM_BAL_SHEET_MODELS_B
for each row
begin
  FEM_BAL_SHEET_MODELS_PKG.DELETE_ROW(
    X_BAL_SHEET_MODEL_CODE => :FEM_BAL_SHEET_MODELS_B.BAL_SHEET_MODEL_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BAL_SHEET_MODELS_DL" ENABLE;
