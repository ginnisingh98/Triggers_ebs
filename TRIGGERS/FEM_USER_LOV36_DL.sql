--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV36_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV36_DL" 
instead of delete on FEM_USER_LOV36_VL
referencing old as FEM_USER_LOV36_B
for each row
begin
  FEM_USER_LOV36_PKG.DELETE_ROW(
    X_USER_LOV36_CODE => :FEM_USER_LOV36_B.USER_LOV36_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV36_DL" ENABLE;
