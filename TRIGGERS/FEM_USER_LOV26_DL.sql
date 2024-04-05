--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV26_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV26_DL" 
instead of delete on FEM_USER_LOV26_VL
referencing old as FEM_USER_LOV26_B
for each row
begin
  FEM_USER_LOV26_PKG.DELETE_ROW(
    X_USER_LOV26_CODE => :FEM_USER_LOV26_B.USER_LOV26_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV26_DL" ENABLE;
