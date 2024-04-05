--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV112_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV112_DL" 
instead of delete on FEM_USER_LOV112_VL
referencing old as FEM_USER_LOV112_B
for each row
begin
  FEM_USER_LOV112_PKG.DELETE_ROW(
    X_USER_LOV112_CODE => :FEM_USER_LOV112_B.USER_LOV112_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV112_DL" ENABLE;
