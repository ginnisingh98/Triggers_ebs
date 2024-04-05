--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV90_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV90_DL" 
instead of delete on FEM_USER_LOV90_VL
referencing old as FEM_USER_LOV90_B
for each row
begin
  FEM_USER_LOV90_PKG.DELETE_ROW(
    X_USER_LOV90_CODE => :FEM_USER_LOV90_B.USER_LOV90_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV90_DL" ENABLE;
