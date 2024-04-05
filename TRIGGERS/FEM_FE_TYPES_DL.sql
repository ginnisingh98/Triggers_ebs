--------------------------------------------------------
--  DDL for Trigger FEM_FE_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_FE_TYPES_DL" 
instead of delete on FEM_FE_TYPES_VL
referencing old as FEM_FE_TYPES_B
for each row
begin
  FEM_FE_TYPES_PKG.DELETE_ROW(
    X_FIN_ELEM_TYPE_CODE => :FEM_FE_TYPES_B.FIN_ELEM_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_FE_TYPES_DL" ENABLE;
