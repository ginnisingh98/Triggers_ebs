--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV119_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV119_DL" 
instead of delete on FEM_USER_LOV119_VL
referencing old as FEM_USER_LOV119_B
for each row
begin
  FEM_USER_LOV119_PKG.DELETE_ROW(
    X_USER_LOV119_CODE => :FEM_USER_LOV119_B.USER_LOV119_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV119_DL" ENABLE;
