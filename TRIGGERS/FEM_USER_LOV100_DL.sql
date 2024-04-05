--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV100_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV100_DL" 
instead of delete on FEM_USER_LOV100_VL
referencing old as FEM_USER_LOV100_B
for each row
begin
  FEM_USER_LOV100_PKG.DELETE_ROW(
    X_USER_LOV100_CODE => :FEM_USER_LOV100_B.USER_LOV100_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV100_DL" ENABLE;
