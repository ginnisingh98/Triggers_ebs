--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV171_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV171_DL" 
instead of delete on FEM_USER_LOV171_VL
referencing old as FEM_USER_LOV171_B
for each row
begin
  FEM_USER_LOV171_PKG.DELETE_ROW(
    X_USER_LOV171_CODE => :FEM_USER_LOV171_B.USER_LOV171_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV171_DL" ENABLE;
