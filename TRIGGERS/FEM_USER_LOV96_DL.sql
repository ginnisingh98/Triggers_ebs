--------------------------------------------------------
--  DDL for Trigger FEM_USER_LOV96_DL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "APPS"."FEM_USER_LOV96_DL" 
instead of delete on FEM_USER_LOV96_VL
referencing old as FEM_USER_LOV96_B
for each row
begin
  FEM_USER_LOV96_PKG.DELETE_ROW(
    X_USER_LOV96_CODE => :FEM_USER_LOV96_B.USER_LOV96_CODE);
 ---
end DELETE_ROW;
 ---


/
ALTER TRIGGER "APPS"."FEM_USER_LOV96_DL" ENABLE;
