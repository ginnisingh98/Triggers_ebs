--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV49_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV49_DL" 
instead of delete on FEM_USER_LOV49_VL
referencing old as FEM_USER_LOV49_B
for each row
begin
  FEM_USER_LOV49_PKG.DELETE_ROW(
    X_USER_LOV49_CODE => :FEM_USER_LOV49_B.USER_LOV49_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV49_DL" ENABLE;
