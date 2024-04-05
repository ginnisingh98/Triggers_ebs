--------------------------------------------------------
--  DDL for Trigger FEM_PRTFBAL_TYP_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PRTFBAL_TYP_DL" 
instead of delete on FEM_PRTFBAL_TYP_VL
referencing old as FEM_PRTFBAL_TYP_B
for each row
begin
  FEM_PRTFBAL_TYP_PKG.DELETE_ROW(
    X_PORTF_BAL_TYPE_CODE => :FEM_PRTFBAL_TYP_B.PORTF_BAL_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PRTFBAL_TYP_DL" ENABLE;
