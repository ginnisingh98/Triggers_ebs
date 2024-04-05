--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV138_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV138_DL" 
instead of delete on FEM_USER_LOV138_VL
referencing old as FEM_USER_LOV138_B
for each row
begin
  FEM_USER_LOV138_PKG.DELETE_ROW(
    X_USER_LOV138_CODE => :FEM_USER_LOV138_B.USER_LOV138_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV138_DL" ENABLE;
