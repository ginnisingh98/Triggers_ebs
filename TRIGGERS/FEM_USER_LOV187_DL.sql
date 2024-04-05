--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV187_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV187_DL" 
instead of delete on FEM_USER_LOV187_VL
referencing old as FEM_USER_LOV187_B
for each row
begin
  FEM_USER_LOV187_PKG.DELETE_ROW(
    X_USER_LOV187_CODE => :FEM_USER_LOV187_B.USER_LOV187_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV187_DL" ENABLE;
