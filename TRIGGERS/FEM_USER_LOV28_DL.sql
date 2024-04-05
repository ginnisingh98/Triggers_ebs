--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV28_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV28_DL" 
instead of delete on FEM_USER_LOV28_VL
referencing old as FEM_USER_LOV28_B
for each row
begin
  FEM_USER_LOV28_PKG.DELETE_ROW(
    X_USER_LOV28_CODE => :FEM_USER_LOV28_B.USER_LOV28_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV28_DL" ENABLE;
