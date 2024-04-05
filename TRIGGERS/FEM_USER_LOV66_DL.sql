--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV66_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV66_DL" 
instead of delete on FEM_USER_LOV66_VL
referencing old as FEM_USER_LOV66_B
for each row
begin
  FEM_USER_LOV66_PKG.DELETE_ROW(
    X_USER_LOV66_CODE => :FEM_USER_LOV66_B.USER_LOV66_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV66_DL" ENABLE;
