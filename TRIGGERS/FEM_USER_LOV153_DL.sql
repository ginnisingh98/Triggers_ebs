--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV153_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV153_DL" 
instead of delete on FEM_USER_LOV153_VL
referencing old as FEM_USER_LOV153_B
for each row
begin
  FEM_USER_LOV153_PKG.DELETE_ROW(
    X_USER_LOV153_CODE => :FEM_USER_LOV153_B.USER_LOV153_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV153_DL" ENABLE;
