--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV34_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV34_DL" 
instead of delete on FEM_USER_LOV34_VL
referencing old as FEM_USER_LOV34_B
for each row
begin
  FEM_USER_LOV34_PKG.DELETE_ROW(
    X_USER_LOV34_CODE => :FEM_USER_LOV34_B.USER_LOV34_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV34_DL" ENABLE;
