--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV58_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV58_DL" 
instead of delete on FEM_USER_LOV58_VL
referencing old as FEM_USER_LOV58_B
for each row
begin
  FEM_USER_LOV58_PKG.DELETE_ROW(
    X_USER_LOV58_CODE => :FEM_USER_LOV58_B.USER_LOV58_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV58_DL" ENABLE;
