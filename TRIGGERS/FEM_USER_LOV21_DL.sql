--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV21_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV21_DL" 
instead of delete on FEM_USER_LOV21_VL
referencing old as FEM_USER_LOV21_B
for each row
begin
  FEM_USER_LOV21_PKG.DELETE_ROW(
    X_USER_LOV21_CODE => :FEM_USER_LOV21_B.USER_LOV21_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV21_DL" ENABLE;
