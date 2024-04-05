--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV118_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV118_DL" 
instead of delete on FEM_USER_LOV118_VL
referencing old as FEM_USER_LOV118_B
for each row
begin
  FEM_USER_LOV118_PKG.DELETE_ROW(
    X_USER_LOV118_CODE => :FEM_USER_LOV118_B.USER_LOV118_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV118_DL" ENABLE;
