--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV56_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV56_DL" 
instead of delete on FEM_USER_LOV56_VL
referencing old as FEM_USER_LOV56_B
for each row
begin
  FEM_USER_LOV56_PKG.DELETE_ROW(
    X_USER_LOV56_CODE => :FEM_USER_LOV56_B.USER_LOV56_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV56_DL" ENABLE;
