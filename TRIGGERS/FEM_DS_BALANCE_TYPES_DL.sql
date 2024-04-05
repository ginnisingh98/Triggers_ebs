--------------------------------------------------------
--  DDL for Trigger FEM_DS_BALANCE_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_DS_BALANCE_TYPES_DL" 
instead of delete on FEM_DS_BALANCE_TYPES_VL
referencing old as FEM_DS_BALANCE_TYPES_B
for each row
begin
  FEM_DS_BALANCE_TYPES_PKG.DELETE_ROW(
    X_DS_BALANCE_TYPE_CODE => :FEM_DS_BALANCE_TYPES_B.DS_BALANCE_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_DS_BALANCE_TYPES_DL" ENABLE;
