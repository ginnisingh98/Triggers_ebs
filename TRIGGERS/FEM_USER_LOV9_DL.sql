--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV9_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV9_DL" 
instead of delete on FEM_USER_LOV9_VL
referencing old as FEM_USER_LOV9_B
for each row
begin
  FEM_USER_LOV9_PKG.DELETE_ROW(
    X_USER_LOV9_CODE => :FEM_USER_LOV9_B.USER_LOV9_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV9_DL" ENABLE;
