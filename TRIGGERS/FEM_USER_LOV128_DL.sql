--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV128_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV128_DL" 
instead of delete on FEM_USER_LOV128_VL
referencing old as FEM_USER_LOV128_B
for each row
begin
  FEM_USER_LOV128_PKG.DELETE_ROW(
    X_USER_LOV128_CODE => :FEM_USER_LOV128_B.USER_LOV128_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV128_DL" ENABLE;
