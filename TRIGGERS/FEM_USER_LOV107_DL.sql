--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV107_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV107_DL" 
instead of delete on FEM_USER_LOV107_VL
referencing old as FEM_USER_LOV107_B
for each row
begin
  FEM_USER_LOV107_PKG.DELETE_ROW(
    X_USER_LOV107_CODE => :FEM_USER_LOV107_B.USER_LOV107_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV107_DL" ENABLE;
