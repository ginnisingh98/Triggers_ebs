--------------------------------------------------------
--  DDL for Trigger FEM_AGG_METHODS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_AGG_METHODS_DL" 
instead of delete on FEM_AGG_METHODS_VL
referencing old as FEM_AGG_METHODS_B
for each row
begin
  FEM_AGG_METHODS_PKG.DELETE_ROW(
    X_AGG_METHOD_CODE => :FEM_AGG_METHODS_B.AGG_METHOD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_AGG_METHODS_DL" ENABLE;
