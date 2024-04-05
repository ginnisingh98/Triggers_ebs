--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV41_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV41_DL" 
instead of delete on FEM_USER_LOV41_VL
referencing old as FEM_USER_LOV41_B
for each row
begin
  FEM_USER_LOV41_PKG.DELETE_ROW(
    X_USER_LOV41_CODE => :FEM_USER_LOV41_B.USER_LOV41_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV41_DL" ENABLE;
