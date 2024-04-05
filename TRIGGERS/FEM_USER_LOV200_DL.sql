--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV200_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV200_DL" 
instead of delete on FEM_USER_LOV200_VL
referencing old as FEM_USER_LOV200_B
for each row
begin
  FEM_USER_LOV200_PKG.DELETE_ROW(
    X_USER_LOV200_CODE => :FEM_USER_LOV200_B.USER_LOV200_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV200_DL" ENABLE;
