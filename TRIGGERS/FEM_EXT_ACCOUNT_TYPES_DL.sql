--------------------------------------------------------
--  DDL for Trigger FEM_EXT_ACCOUNT_TYPES_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_EXT_ACCOUNT_TYPES_DL" 
instead of delete on FEM_EXT_ACCOUNT_TYPES_VL
referencing old as FEM_EXT_ACCOUNT_TYPES_B
for each row
begin
  FEM_EXT_ACCOUNT_TYPES_PKG.DELETE_ROW(
    X_EXT_ACCOUNT_TYPE_CODE => :FEM_EXT_ACCOUNT_TYPES_B.EXT_ACCOUNT_TYPE_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_EXT_ACCOUNT_TYPES_DL" ENABLE;
