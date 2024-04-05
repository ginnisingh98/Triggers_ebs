--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV155_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV155_DL" 
instead of delete on FEM_USER_LOV155_VL
referencing old as FEM_USER_LOV155_B
for each row
begin
  FEM_USER_LOV155_PKG.DELETE_ROW(
    X_USER_LOV155_CODE => :FEM_USER_LOV155_B.USER_LOV155_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV155_DL" ENABLE;
