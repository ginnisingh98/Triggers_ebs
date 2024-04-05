--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV116_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV116_DL" 
instead of delete on FEM_USER_LOV116_VL
referencing old as FEM_USER_LOV116_B
for each row
begin
  FEM_USER_LOV116_PKG.DELETE_ROW(
    X_USER_LOV116_CODE => :FEM_USER_LOV116_B.USER_LOV116_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV116_DL" ENABLE;
