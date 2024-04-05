--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV122_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV122_DL" 
instead of delete on FEM_USER_LOV122_VL
referencing old as FEM_USER_LOV122_B
for each row
begin
  FEM_USER_LOV122_PKG.DELETE_ROW(
    X_USER_LOV122_CODE => :FEM_USER_LOV122_B.USER_LOV122_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV122_DL" ENABLE;
