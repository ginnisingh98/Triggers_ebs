--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV35_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV35_DL" 
instead of delete on FEM_USER_LOV35_VL
referencing old as FEM_USER_LOV35_B
for each row
begin
  FEM_USER_LOV35_PKG.DELETE_ROW(
    X_USER_LOV35_CODE => :FEM_USER_LOV35_B.USER_LOV35_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV35_DL" ENABLE;
