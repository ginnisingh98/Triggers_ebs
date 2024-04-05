--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV74_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV74_DL" 
instead of delete on FEM_USER_LOV74_VL
referencing old as FEM_USER_LOV74_B
for each row
begin
  FEM_USER_LOV74_PKG.DELETE_ROW(
    X_USER_LOV74_CODE => :FEM_USER_LOV74_B.USER_LOV74_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV74_DL" ENABLE;
