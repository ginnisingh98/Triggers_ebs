--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV70_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV70_DL" 
instead of delete on FEM_USER_LOV70_VL
referencing old as FEM_USER_LOV70_B
for each row
begin
  FEM_USER_LOV70_PKG.DELETE_ROW(
    X_USER_LOV70_CODE => :FEM_USER_LOV70_B.USER_LOV70_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV70_DL" ENABLE;
