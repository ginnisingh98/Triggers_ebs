--------------------------------------------------------
--  DDL for Trigger FEM_RECMETHODS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_RECMETHODS_DL" 
instead of delete on FEM_RECMETHODS_VL
referencing old as FEM_RECMETHODS_B
for each row
begin
  FEM_RECMETHODS_PKG.DELETE_ROW(
    X_RECOVERY_METHOD_CODE => :FEM_RECMETHODS_B.RECOVERY_METHOD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_RECMETHODS_DL" ENABLE;
