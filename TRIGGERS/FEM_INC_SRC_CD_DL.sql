--------------------------------------------------------
--  DDL for Trigger FEM_INC_SRC_CD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_INC_SRC_CD_DL" 
instead of delete on FEM_INC_SRC_CD_VL
referencing old as FEM_INC_SRC_CD_B
for each row
begin
  FEM_INC_SRC_CD_PKG.DELETE_ROW(
    X_INC_SRC_CD_CODE => :FEM_INC_SRC_CD_B.INC_SRC_CD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_INC_SRC_CD_DL" ENABLE;
