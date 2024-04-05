--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV88_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV88_DL" 
instead of delete on FEM_USER_LOV88_VL
referencing old as FEM_USER_LOV88_B
for each row
begin
  FEM_USER_LOV88_PKG.DELETE_ROW(
    X_USER_LOV88_CODE => :FEM_USER_LOV88_B.USER_LOV88_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV88_DL" ENABLE;
