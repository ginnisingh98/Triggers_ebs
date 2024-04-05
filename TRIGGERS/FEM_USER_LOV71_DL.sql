--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV71_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV71_DL" 
instead of delete on FEM_USER_LOV71_VL
referencing old as FEM_USER_LOV71_B
for each row
begin
  FEM_USER_LOV71_PKG.DELETE_ROW(
    X_USER_LOV71_CODE => :FEM_USER_LOV71_B.USER_LOV71_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV71_DL" ENABLE;
