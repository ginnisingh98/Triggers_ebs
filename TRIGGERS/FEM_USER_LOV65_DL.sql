--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV65_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV65_DL" 
instead of delete on FEM_USER_LOV65_VL
referencing old as FEM_USER_LOV65_B
for each row
begin
  FEM_USER_LOV65_PKG.DELETE_ROW(
    X_USER_LOV65_CODE => :FEM_USER_LOV65_B.USER_LOV65_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV65_DL" ENABLE;
