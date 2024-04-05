--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV106_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV106_DL" 
instead of delete on FEM_USER_LOV106_VL
referencing old as FEM_USER_LOV106_B
for each row
begin
  FEM_USER_LOV106_PKG.DELETE_ROW(
    X_USER_LOV106_CODE => :FEM_USER_LOV106_B.USER_LOV106_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV106_DL" ENABLE;
