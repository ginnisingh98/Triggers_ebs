--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV132_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV132_DL" 
instead of delete on FEM_USER_LOV132_VL
referencing old as FEM_USER_LOV132_B
for each row
begin
  FEM_USER_LOV132_PKG.DELETE_ROW(
    X_USER_LOV132_CODE => :FEM_USER_LOV132_B.USER_LOV132_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV132_DL" ENABLE;
