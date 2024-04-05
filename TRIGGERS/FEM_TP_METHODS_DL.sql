--------------------------------------------------------
--  DDL for Trigger FEM_TP_METHODS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_TP_METHODS_DL" 
instead of delete on FEM_TP_METHODS_VL
referencing old as FEM_TP_METHODS_B
for each row
begin
  FEM_TP_METHODS_PKG.DELETE_ROW(
    X_TP_METHOD_CODE => :FEM_TP_METHODS_B.TP_METHOD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_TP_METHODS_DL" ENABLE;
