--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV196_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV196_DL" 
instead of delete on FEM_USER_LOV196_VL
referencing old as FEM_USER_LOV196_B
for each row
begin
  FEM_USER_LOV196_PKG.DELETE_ROW(
    X_USER_LOV196_CODE => :FEM_USER_LOV196_B.USER_LOV196_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV196_DL" ENABLE;
