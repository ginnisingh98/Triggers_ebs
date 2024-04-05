--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV93_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV93_DL" 
instead of delete on FEM_USER_LOV93_VL
referencing old as FEM_USER_LOV93_B
for each row
begin
  FEM_USER_LOV93_PKG.DELETE_ROW(
    X_USER_LOV93_CODE => :FEM_USER_LOV93_B.USER_LOV93_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV93_DL" ENABLE;
