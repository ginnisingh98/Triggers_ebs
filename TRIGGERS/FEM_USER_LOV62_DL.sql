--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV62_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV62_DL" 
instead of delete on FEM_USER_LOV62_VL
referencing old as FEM_USER_LOV62_B
for each row
begin
  FEM_USER_LOV62_PKG.DELETE_ROW(
    X_USER_LOV62_CODE => :FEM_USER_LOV62_B.USER_LOV62_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV62_DL" ENABLE;
