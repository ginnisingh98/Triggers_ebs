--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV130_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV130_DL" 
instead of delete on FEM_USER_LOV130_VL
referencing old as FEM_USER_LOV130_B
for each row
begin
  FEM_USER_LOV130_PKG.DELETE_ROW(
    X_USER_LOV130_CODE => :FEM_USER_LOV130_B.USER_LOV130_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV130_DL" ENABLE;
