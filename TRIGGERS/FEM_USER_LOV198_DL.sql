--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV198_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV198_DL" 
instead of delete on FEM_USER_LOV198_VL
referencing old as FEM_USER_LOV198_B
for each row
begin
  FEM_USER_LOV198_PKG.DELETE_ROW(
    X_USER_LOV198_CODE => :FEM_USER_LOV198_B.USER_LOV198_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV198_DL" ENABLE;
