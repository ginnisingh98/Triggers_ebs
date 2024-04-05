--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV129_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV129_DL" 
instead of delete on FEM_USER_LOV129_VL
referencing old as FEM_USER_LOV129_B
for each row
begin
  FEM_USER_LOV129_PKG.DELETE_ROW(
    X_USER_LOV129_CODE => :FEM_USER_LOV129_B.USER_LOV129_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV129_DL" ENABLE;
