--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV147_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV147_DL" 
instead of delete on FEM_USER_LOV147_VL
referencing old as FEM_USER_LOV147_B
for each row
begin
  FEM_USER_LOV147_PKG.DELETE_ROW(
    X_USER_LOV147_CODE => :FEM_USER_LOV147_B.USER_LOV147_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV147_DL" ENABLE;
