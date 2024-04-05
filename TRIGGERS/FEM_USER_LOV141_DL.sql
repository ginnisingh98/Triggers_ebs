--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV141_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV141_DL" 
instead of delete on FEM_USER_LOV141_VL
referencing old as FEM_USER_LOV141_B
for each row
begin
  FEM_USER_LOV141_PKG.DELETE_ROW(
    X_USER_LOV141_CODE => :FEM_USER_LOV141_B.USER_LOV141_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV141_DL" ENABLE;
