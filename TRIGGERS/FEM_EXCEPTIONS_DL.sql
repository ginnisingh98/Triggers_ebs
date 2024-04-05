--------------------------------------------------------
--  DDL for Trigger FEM_EXCEPTIONS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_EXCEPTIONS_DL" 
instead of delete on FEM_EXCEPTIONS_VL
referencing old as FEM_EXCEPTIONS_B
for each row
begin
  FEM_EXCEPTIONS_PKG.DELETE_ROW(
    X_EXCEPTION_CODE => :FEM_EXCEPTIONS_B.EXCEPTION_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_EXCEPTIONS_DL" ENABLE;
