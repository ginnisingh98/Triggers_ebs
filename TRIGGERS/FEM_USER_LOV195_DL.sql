--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV195_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV195_DL" 
instead of delete on FEM_USER_LOV195_VL
referencing old as FEM_USER_LOV195_B
for each row
begin
  FEM_USER_LOV195_PKG.DELETE_ROW(
    X_USER_LOV195_CODE => :FEM_USER_LOV195_B.USER_LOV195_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV195_DL" ENABLE;
