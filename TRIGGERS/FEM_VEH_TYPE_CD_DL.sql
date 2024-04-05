--------------------------------------------------------
--  DDL for Trigger FEM_VEH_TYPE_CD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_VEH_TYPE_CD_DL" 
instead of delete on FEM_VEH_TYPE_CD_VL
referencing old as FEM_VEH_TYPE_CD_B
for each row
begin
  FEM_VEH_TYPE_CD_PKG.DELETE_ROW(
    X_VEH_TYPE_CD_CODE => :FEM_VEH_TYPE_CD_B.VEH_TYPE_CD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_VEH_TYPE_CD_DL" ENABLE;
