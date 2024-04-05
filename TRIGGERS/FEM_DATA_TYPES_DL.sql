--------------------------------------------------------
--  DDL for Trigger FEM_DATA_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DATA_TYPES_DL" 
instead of delete on FEM_DATA_TYPES_VL
referencing old as FEM_DATA_TYPES_B
for each row
begin
  FEM_DATA_TYPES_PKG.DELETE_ROW(
    X_FEM_DATA_TYPE_CODE => :FEM_DATA_TYPES_B.FEM_DATA_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DATA_TYPES_DL" ENABLE;
