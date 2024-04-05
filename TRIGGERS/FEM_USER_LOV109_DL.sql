--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV109_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV109_DL" 
instead of delete on FEM_USER_LOV109_VL
referencing old as FEM_USER_LOV109_B
for each row
begin
  FEM_USER_LOV109_PKG.DELETE_ROW(
    X_USER_LOV109_CODE => :FEM_USER_LOV109_B.USER_LOV109_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV109_DL" ENABLE;
