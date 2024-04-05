--------------------------------------------------------
--  DDL for Trigger FEM_BOND_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_BOND_TYPES_DL" 
instead of delete on FEM_BOND_TYPES_VL
referencing old as FEM_BOND_TYPES_B
for each row
begin
  FEM_BOND_TYPES_PKG.DELETE_ROW(
    X_BOND_TYPE_CODE => :FEM_BOND_TYPES_B.BOND_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_BOND_TYPES_DL" ENABLE;
