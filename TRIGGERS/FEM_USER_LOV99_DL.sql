--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV99_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV99_DL" 
instead of delete on FEM_USER_LOV99_VL
referencing old as FEM_USER_LOV99_B
for each row
begin
  FEM_USER_LOV99_PKG.DELETE_ROW(
    X_USER_LOV99_CODE => :FEM_USER_LOV99_B.USER_LOV99_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV99_DL" ENABLE;
