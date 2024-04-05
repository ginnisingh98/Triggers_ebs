--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV29_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV29_DL" 
instead of delete on FEM_USER_LOV29_VL
referencing old as FEM_USER_LOV29_B
for each row
begin
  FEM_USER_LOV29_PKG.DELETE_ROW(
    X_USER_LOV29_CODE => :FEM_USER_LOV29_B.USER_LOV29_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV29_DL" ENABLE;
