--------------------------------------------------------
--  DDL for Trigger FEM_BRANCHES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BRANCHES_DL" 
instead of delete on FEM_BRANCHES_VL
referencing old as FEM_BRANCHES_B
for each row
begin
  FEM_BRANCHES_PKG.DELETE_ROW(
    X_BRANCH_CODE => :FEM_BRANCHES_B.BRANCH_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BRANCHES_DL" ENABLE;
