--------------------------------------------------------
--  DDL for Trigger FEM_RES_TYPE_CD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_RES_TYPE_CD_DL" 
instead of delete on FEM_RES_TYPE_CD_VL
referencing old as FEM_RES_TYPE_CD_B
for each row
begin
  FEM_RES_TYPE_CD_PKG.DELETE_ROW(
    X_RES_TYPE_CD_CODE => :FEM_RES_TYPE_CD_B.RES_TYPE_CD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_RES_TYPE_CD_DL" ENABLE;
