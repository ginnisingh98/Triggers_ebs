--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV75_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV75_DL" 
instead of delete on FEM_USER_LOV75_VL
referencing old as FEM_USER_LOV75_B
for each row
begin
  FEM_USER_LOV75_PKG.DELETE_ROW(
    X_USER_LOV75_CODE => :FEM_USER_LOV75_B.USER_LOV75_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV75_DL" ENABLE;
