--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV192_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV192_DL" 
instead of delete on FEM_USER_LOV192_VL
referencing old as FEM_USER_LOV192_B
for each row
begin
  FEM_USER_LOV192_PKG.DELETE_ROW(
    X_USER_LOV192_CODE => :FEM_USER_LOV192_B.USER_LOV192_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV192_DL" ENABLE;
