--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV48_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV48_DL" 
instead of delete on FEM_USER_LOV48_VL
referencing old as FEM_USER_LOV48_B
for each row
begin
  FEM_USER_LOV48_PKG.DELETE_ROW(
    X_USER_LOV48_CODE => :FEM_USER_LOV48_B.USER_LOV48_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV48_DL" ENABLE;
