--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV37_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV37_DL" 
instead of delete on FEM_USER_LOV37_VL
referencing old as FEM_USER_LOV37_B
for each row
begin
  FEM_USER_LOV37_PKG.DELETE_ROW(
    X_USER_LOV37_CODE => :FEM_USER_LOV37_B.USER_LOV37_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV37_DL" ENABLE;
