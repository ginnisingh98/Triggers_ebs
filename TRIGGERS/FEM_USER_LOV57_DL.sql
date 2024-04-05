--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV57_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV57_DL" 
instead of delete on FEM_USER_LOV57_VL
referencing old as FEM_USER_LOV57_B
for each row
begin
  FEM_USER_LOV57_PKG.DELETE_ROW(
    X_USER_LOV57_CODE => :FEM_USER_LOV57_B.USER_LOV57_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV57_DL" ENABLE;
