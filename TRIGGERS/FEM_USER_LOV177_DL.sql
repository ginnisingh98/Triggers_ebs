--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV177_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV177_DL" 
instead of delete on FEM_USER_LOV177_VL
referencing old as FEM_USER_LOV177_B
for each row
begin
  FEM_USER_LOV177_PKG.DELETE_ROW(
    X_USER_LOV177_CODE => :FEM_USER_LOV177_B.USER_LOV177_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV177_DL" ENABLE;
