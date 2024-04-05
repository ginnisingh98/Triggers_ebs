--------------------------------------------------------
--  DDL for Trigger FEM_PUT_CALLS_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PUT_CALLS_DL" 
instead of delete on FEM_PUT_CALLS_VL
referencing old as FEM_PUT_CALLS_B
for each row
begin
  FEM_PUT_CALLS_PKG.DELETE_ROW(
    X_PUT_CALL_ID => :FEM_PUT_CALLS_B.PUT_CALL_ID);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PUT_CALLS_DL" ENABLE;
