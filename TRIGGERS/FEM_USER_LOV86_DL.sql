--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV86_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV86_DL" 
instead of delete on FEM_USER_LOV86_VL
referencing old as FEM_USER_LOV86_B
for each row
begin
  FEM_USER_LOV86_PKG.DELETE_ROW(
    X_USER_LOV86_CODE => :FEM_USER_LOV86_B.USER_LOV86_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV86_DL" ENABLE;
