--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV150_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV150_DL" 
instead of delete on FEM_USER_LOV150_VL
referencing old as FEM_USER_LOV150_B
for each row
begin
  FEM_USER_LOV150_PKG.DELETE_ROW(
    X_USER_LOV150_CODE => :FEM_USER_LOV150_B.USER_LOV150_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV150_DL" ENABLE;
