--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV115_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV115_DL" 
instead of delete on FEM_USER_LOV115_VL
referencing old as FEM_USER_LOV115_B
for each row
begin
  FEM_USER_LOV115_PKG.DELETE_ROW(
    X_USER_LOV115_CODE => :FEM_USER_LOV115_B.USER_LOV115_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV115_DL" ENABLE;
