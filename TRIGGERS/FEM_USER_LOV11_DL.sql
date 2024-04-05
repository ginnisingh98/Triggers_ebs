--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV11_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV11_DL" 
instead of delete on FEM_USER_LOV11_VL
referencing old as FEM_USER_LOV11_B
for each row
begin
  FEM_USER_LOV11_PKG.DELETE_ROW(
    X_USER_LOV11_CODE => :FEM_USER_LOV11_B.USER_LOV11_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV11_DL" ENABLE;
