--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV170_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV170_DL" 
instead of delete on FEM_USER_LOV170_VL
referencing old as FEM_USER_LOV170_B
for each row
begin
  FEM_USER_LOV170_PKG.DELETE_ROW(
    X_USER_LOV170_CODE => :FEM_USER_LOV170_B.USER_LOV170_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV170_DL" ENABLE;
