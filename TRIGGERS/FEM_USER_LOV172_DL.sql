--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV172_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV172_DL" 
instead of delete on FEM_USER_LOV172_VL
referencing old as FEM_USER_LOV172_B
for each row
begin
  FEM_USER_LOV172_PKG.DELETE_ROW(
    X_USER_LOV172_CODE => :FEM_USER_LOV172_B.USER_LOV172_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV172_DL" ENABLE;
