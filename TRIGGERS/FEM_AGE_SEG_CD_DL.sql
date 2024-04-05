--------------------------------------------------------
--  DDL for Trigger FEM_AGE_SEG_CD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_AGE_SEG_CD_DL" 
instead of delete on FEM_AGE_SEG_CD_VL
referencing old as FEM_AGE_SEG_CD_B
for each row
begin
  FEM_AGE_SEG_CD_PKG.DELETE_ROW(
    X_AGE_SEG_CD_CODE => :FEM_AGE_SEG_CD_B.AGE_SEG_CD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_AGE_SEG_CD_DL" ENABLE;
