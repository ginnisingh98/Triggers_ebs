--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV156_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV156_DL" 
instead of delete on FEM_USER_LOV156_VL
referencing old as FEM_USER_LOV156_B
for each row
begin
  FEM_USER_LOV156_PKG.DELETE_ROW(
    X_USER_LOV156_CODE => :FEM_USER_LOV156_B.USER_LOV156_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV156_DL" ENABLE;
