--------------------------------------------------------
--  DDL for Trigger FEM_DEPOSIT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DEPOSIT_TYPES_DL" 
instead of delete on FEM_DEPOSIT_TYPES_VL
referencing old as FEM_DEPOSIT_TYPES_B
for each row
begin
  FEM_DEPOSIT_TYPES_PKG.DELETE_ROW(
    X_DEPOSIT_TYPE_CODE => :FEM_DEPOSIT_TYPES_B.DEPOSIT_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DEPOSIT_TYPES_DL" ENABLE;
