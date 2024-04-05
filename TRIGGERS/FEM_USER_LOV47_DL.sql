--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV47_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV47_DL" 
instead of delete on FEM_USER_LOV47_VL
referencing old as FEM_USER_LOV47_B
for each row
begin
  FEM_USER_LOV47_PKG.DELETE_ROW(
    X_USER_LOV47_CODE => :FEM_USER_LOV47_B.USER_LOV47_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV47_DL" ENABLE;
