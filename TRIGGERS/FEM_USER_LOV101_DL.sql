--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV101_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV101_DL" 
instead of delete on FEM_USER_LOV101_VL
referencing old as FEM_USER_LOV101_B
for each row
begin
  FEM_USER_LOV101_PKG.DELETE_ROW(
    X_USER_LOV101_CODE => :FEM_USER_LOV101_B.USER_LOV101_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV101_DL" ENABLE;
