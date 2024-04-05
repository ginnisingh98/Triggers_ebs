--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV152_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV152_DL" 
instead of delete on FEM_USER_LOV152_VL
referencing old as FEM_USER_LOV152_B
for each row
begin
  FEM_USER_LOV152_PKG.DELETE_ROW(
    X_USER_LOV152_CODE => :FEM_USER_LOV152_B.USER_LOV152_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV152_DL" ENABLE;
