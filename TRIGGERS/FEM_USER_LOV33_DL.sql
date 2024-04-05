--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV33_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV33_DL" 
instead of delete on FEM_USER_LOV33_VL
referencing old as FEM_USER_LOV33_B
for each row
begin
  FEM_USER_LOV33_PKG.DELETE_ROW(
    X_USER_LOV33_CODE => :FEM_USER_LOV33_B.USER_LOV33_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV33_DL" ENABLE;
