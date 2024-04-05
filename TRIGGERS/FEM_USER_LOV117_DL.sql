--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV117_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV117_DL" 
instead of delete on FEM_USER_LOV117_VL
referencing old as FEM_USER_LOV117_B
for each row
begin
  FEM_USER_LOV117_PKG.DELETE_ROW(
    X_USER_LOV117_CODE => :FEM_USER_LOV117_B.USER_LOV117_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV117_DL" ENABLE;
