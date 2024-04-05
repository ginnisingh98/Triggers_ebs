--------------------------------------------------------
--  DDL for Trigger FEM_PAY_AHEAD_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_PAY_AHEAD_DL" 
instead of delete on FEM_PAY_AHEAD_VL
referencing old as FEM_PAY_AHEAD_B
for each row
begin
  FEM_PAY_AHEAD_PKG.DELETE_ROW(
    X_PAY_AHEAD_CODE => :FEM_PAY_AHEAD_B.PAY_AHEAD_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_PAY_AHEAD_DL" ENABLE;
