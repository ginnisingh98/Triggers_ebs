--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV23_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV23_DL" 
instead of delete on FEM_USER_LOV23_VL
referencing old as FEM_USER_LOV23_B
for each row
begin
  FEM_USER_LOV23_PKG.DELETE_ROW(
    X_USER_LOV23_CODE => :FEM_USER_LOV23_B.USER_LOV23_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV23_DL" ENABLE;
