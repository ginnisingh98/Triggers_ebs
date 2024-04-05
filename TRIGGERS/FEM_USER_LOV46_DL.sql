--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV46_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV46_DL" 
instead of delete on FEM_USER_LOV46_VL
referencing old as FEM_USER_LOV46_B
for each row
begin
  FEM_USER_LOV46_PKG.DELETE_ROW(
    X_USER_LOV46_CODE => :FEM_USER_LOV46_B.USER_LOV46_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV46_DL" ENABLE;
