--------------------------------------------------------
--  DDL for Trigger FEM_UOM_CODES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_UOM_CODES_DL" 
instead of delete on FEM_UOM_CODES_VL
referencing old as FEM_UOM_CODES_B
for each row
begin
  FEM_UOM_CODES_PKG.DELETE_ROW(
    X_UOM_CODE => :FEM_UOM_CODES_B.UOM_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_UOM_CODES_DL" ENABLE;
