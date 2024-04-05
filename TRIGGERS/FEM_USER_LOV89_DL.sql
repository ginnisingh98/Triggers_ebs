--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV89_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV89_DL" 
instead of delete on FEM_USER_LOV89_VL
referencing old as FEM_USER_LOV89_B
for each row
begin
  FEM_USER_LOV89_PKG.DELETE_ROW(
    X_USER_LOV89_CODE => :FEM_USER_LOV89_B.USER_LOV89_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV89_DL" ENABLE;
