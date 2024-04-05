--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV182_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV182_DL" 
instead of delete on FEM_USER_LOV182_VL
referencing old as FEM_USER_LOV182_B
for each row
begin
  FEM_USER_LOV182_PKG.DELETE_ROW(
    X_USER_LOV182_CODE => :FEM_USER_LOV182_B.USER_LOV182_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV182_DL" ENABLE;
