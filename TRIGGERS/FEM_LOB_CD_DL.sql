--------------------------------------------------------
--  DDL for Trigger FEM_LOB_CD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_LOB_CD_DL" 
instead of delete on FEM_LOB_CD_VL
referencing old as FEM_LOB_CD_B
for each row
begin
  FEM_LOB_CD_PKG.DELETE_ROW(
    X_LINE_OF_BUS_CD_CODE => :FEM_LOB_CD_B.LINE_OF_BUS_CD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_LOB_CD_DL" ENABLE;
