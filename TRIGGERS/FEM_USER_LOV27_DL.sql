--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV27_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV27_DL" 
instead of delete on FEM_USER_LOV27_VL
referencing old as FEM_USER_LOV27_B
for each row
begin
  FEM_USER_LOV27_PKG.DELETE_ROW(
    X_USER_LOV27_CODE => :FEM_USER_LOV27_B.USER_LOV27_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV27_DL" ENABLE;
