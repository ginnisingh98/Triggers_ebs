--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV189_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV189_DL" 
instead of delete on FEM_USER_LOV189_VL
referencing old as FEM_USER_LOV189_B
for each row
begin
  FEM_USER_LOV189_PKG.DELETE_ROW(
    X_USER_LOV189_CODE => :FEM_USER_LOV189_B.USER_LOV189_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV189_DL" ENABLE;
