--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV68_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV68_DL" 
instead of delete on FEM_USER_LOV68_VL
referencing old as FEM_USER_LOV68_B
for each row
begin
  FEM_USER_LOV68_PKG.DELETE_ROW(
    X_USER_LOV68_CODE => :FEM_USER_LOV68_B.USER_LOV68_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV68_DL" ENABLE;
