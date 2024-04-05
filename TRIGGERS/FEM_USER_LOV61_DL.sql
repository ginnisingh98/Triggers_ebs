--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV61_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV61_DL" 
instead of delete on FEM_USER_LOV61_VL
referencing old as FEM_USER_LOV61_B
for each row
begin
  FEM_USER_LOV61_PKG.DELETE_ROW(
    X_USER_LOV61_CODE => :FEM_USER_LOV61_B.USER_LOV61_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV61_DL" ENABLE;
