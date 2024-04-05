--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV157_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV157_DL" 
instead of delete on FEM_USER_LOV157_VL
referencing old as FEM_USER_LOV157_B
for each row
begin
  FEM_USER_LOV157_PKG.DELETE_ROW(
    X_USER_LOV157_CODE => :FEM_USER_LOV157_B.USER_LOV157_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV157_DL" ENABLE;
