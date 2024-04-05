--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV19_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV19_DL" 
instead of delete on FEM_USER_LOV19_VL
referencing old as FEM_USER_LOV19_B
for each row
begin
  FEM_USER_LOV19_PKG.DELETE_ROW(
    X_USER_LOV19_CODE => :FEM_USER_LOV19_B.USER_LOV19_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV19_DL" ENABLE;
