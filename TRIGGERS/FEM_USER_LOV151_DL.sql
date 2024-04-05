--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV151_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV151_DL" 
instead of delete on FEM_USER_LOV151_VL
referencing old as FEM_USER_LOV151_B
for each row
begin
  FEM_USER_LOV151_PKG.DELETE_ROW(
    X_USER_LOV151_CODE => :FEM_USER_LOV151_B.USER_LOV151_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV151_DL" ENABLE;
