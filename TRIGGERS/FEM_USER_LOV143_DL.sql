--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV143_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV143_DL" 
instead of delete on FEM_USER_LOV143_VL
referencing old as FEM_USER_LOV143_B
for each row
begin
  FEM_USER_LOV143_PKG.DELETE_ROW(
    X_USER_LOV143_CODE => :FEM_USER_LOV143_B.USER_LOV143_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV143_DL" ENABLE;
