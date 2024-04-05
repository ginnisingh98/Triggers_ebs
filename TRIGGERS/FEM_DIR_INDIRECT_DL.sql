--------------------------------------------------------
--  DDL for Trigger FEM_DIR_INDIRECT_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DIR_INDIRECT_DL" 
instead of delete on FEM_DIR_INDIRECT_VL
referencing old as FEM_DIR_INDIRECT_B
for each row
begin
  FEM_DIR_INDIRECT_PKG.DELETE_ROW(
    X_DIRECT_IND_ID => :FEM_DIR_INDIRECT_B.DIRECT_IND_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DIR_INDIRECT_DL" ENABLE;
