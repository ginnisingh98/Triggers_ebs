--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV180_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV180_DL" 
instead of delete on FEM_USER_LOV180_VL
referencing old as FEM_USER_LOV180_B
for each row
begin
  FEM_USER_LOV180_PKG.DELETE_ROW(
    X_USER_LOV180_CODE => :FEM_USER_LOV180_B.USER_LOV180_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV180_DL" ENABLE;
