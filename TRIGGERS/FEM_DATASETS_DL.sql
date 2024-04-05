--------------------------------------------------------
--  DDL for Trigger FEM_DATASETS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DATASETS_DL" 
instead of delete on FEM_DATASETS_VL
referencing old as FEM_DATASETS_B
for each row
begin
  FEM_DATASETS_PKG.DELETE_ROW(
    X_DATASET_CODE => :FEM_DATASETS_B.DATASET_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DATASETS_DL" ENABLE;
