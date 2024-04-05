--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV125_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV125_DL" 
instead of delete on FEM_USER_LOV125_VL
referencing old as FEM_USER_LOV125_B
for each row
begin
  FEM_USER_LOV125_PKG.DELETE_ROW(
    X_USER_LOV125_CODE => :FEM_USER_LOV125_B.USER_LOV125_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV125_DL" ENABLE;
