--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV94_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV94_DL" 
instead of delete on FEM_USER_LOV94_VL
referencing old as FEM_USER_LOV94_B
for each row
begin
  FEM_USER_LOV94_PKG.DELETE_ROW(
    X_USER_LOV94_CODE => :FEM_USER_LOV94_B.USER_LOV94_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV94_DL" ENABLE;
