--------------------------------------------------------
--  DDL for Trigger FEM_COMMIT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_COMMIT_TYPES_DL" 
instead of delete on FEM_COMMIT_TYPES_VL
referencing old as FEM_COMMIT_TYPES_B
for each row
begin
  FEM_COMMIT_TYPES_PKG.DELETE_ROW(
    X_COMMITMENT_TYPE_ID => :FEM_COMMIT_TYPES_B.COMMITMENT_TYPE_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_COMMIT_TYPES_DL" ENABLE;
