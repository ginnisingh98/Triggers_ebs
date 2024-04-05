--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV72_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV72_DL" 
instead of delete on FEM_USER_LOV72_VL
referencing old as FEM_USER_LOV72_B
for each row
begin
  FEM_USER_LOV72_PKG.DELETE_ROW(
    X_USER_LOV72_CODE => :FEM_USER_LOV72_B.USER_LOV72_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV72_DL" ENABLE;
