--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV14_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV14_DL" 
instead of delete on FEM_USER_LOV14_VL
referencing old as FEM_USER_LOV14_B
for each row
begin
  FEM_USER_LOV14_PKG.DELETE_ROW(
    X_USER_LOV14_CODE => :FEM_USER_LOV14_B.USER_LOV14_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV14_DL" ENABLE;
