--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV92_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV92_DL" 
instead of delete on FEM_USER_LOV92_VL
referencing old as FEM_USER_LOV92_B
for each row
begin
  FEM_USER_LOV92_PKG.DELETE_ROW(
    X_USER_LOV92_CODE => :FEM_USER_LOV92_B.USER_LOV92_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV92_DL" ENABLE;
