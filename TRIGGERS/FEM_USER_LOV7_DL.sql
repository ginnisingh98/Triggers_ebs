--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV7_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV7_DL" 
instead of delete on FEM_USER_LOV7_VL
referencing old as FEM_USER_LOV7_B
for each row
begin
  FEM_USER_LOV7_PKG.DELETE_ROW(
    X_USER_LOV7_CODE => :FEM_USER_LOV7_B.USER_LOV7_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV7_DL" ENABLE;
